import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:women_safety_dashboard/features/Live_tracking/Google_Map/models/ReportIncidentModel.dart';
import 'package:women_safety_dashboard/utils/popups/loaders.dart';

class LiveLocationController extends GetxController {
  static LiveLocationController get instance => Get.find();

  /// SHAKE MODE IS DISABLED
  RxBool isShakeModeEnabled = false.obs;

  /// STORE ALL INCIDENT REPORTS DATA
  var reports = <ReportIncidentModel>[].obs;

  /// STORE ALL THE MARKERS DATA
  var markers = <Marker>[].obs;
  var polygons = <Polygon>[].obs;

  Rx<LatLng> initialLatLng = LatLng(19.1136, 72.8697).obs;
  Rx<GoogleMapController?> googleMapController = Rx<GoogleMapController?>(null);

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
    fetchReports();
  }

  /// Fetch reports from Firestore
  Future<void> fetchReports() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection("ReportIncidents").get();
      final List<ReportIncidentModel> fetchedReports = querySnapshot.docs
          .map((doc) => ReportIncidentModel.fromSnapshot(doc))
          .toList();
      reports.assignAll(fetchedReports);
      _loadPolygonsAndMarkers();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch reports: $e');
    }
  }

  /// Load polygons and markers based on reports
  void _loadPolygonsAndMarkers() {
    final List<List<LatLng>> clusters = _clusterReports(reports, 100);
    final List<Polygon> reportPolygons = clusters.map((cluster) {
      final String id = cluster.map((e) => e.toString()).join();
      return Polygon(
        polygonId: PolygonId(id),
        points: cluster,
        strokeColor: Colors.redAccent,
        strokeWidth: 2,
        fillColor: Colors.red.withOpacity(0.15),
      );
    }).toList();

    final List<Marker> reportMarkers = [];
    for (var report in reports) {
      LatLng point = LatLng(
        double.parse(report.latitude),
        double.parse(report.longitude),
      );
      reportMarkers.add(
        Marker(
          markerId: MarkerId(report.id),
          position: point,
          infoWindow: InfoWindow(
            title: report.titleIncident,
            snippet: report.incidentDescription,
            onTap: () {
              _showReportDetails(report); // Call the method to show details
            },
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    }

    polygons.assignAll(reportPolygons);
    markers.assignAll(reportMarkers);
  }

  /// Cluster reports based on proximity
  List<List<LatLng>> _clusterReports(List<ReportIncidentModel> reports,
      double distanceInMeters) {
    List<List<LatLng>> clusters = [];
    for (ReportIncidentModel report in reports) {
      LatLng point = LatLng(
        double.parse(report.latitude),
        double.parse(report.longitude),
      );
      bool addedToCluster = false;
      for (List<LatLng> cluster in clusters) {
        if (_isPointInCluster(point, cluster, distanceInMeters)) {
          cluster.add(point);
          addedToCluster = true;
          break;
        }
      }
      if (!addedToCluster) {
        clusters.add([point]);
      }
    }
    return clusters;
  }

  /// Check if a point is within a cluster
  bool _isPointInCluster(LatLng point, List<LatLng> cluster,
      double distanceInMeters) {
    for (LatLng clusterPoint in cluster) {
      double distance = Geolocator.distanceBetween(
        point.latitude,
        point.longitude,
        clusterPoint.latitude,
        clusterPoint.longitude,
      );
      if (distance <= distanceInMeters) {
        return true;
      }
    }
    return false;
  }

  /// Get the current location of the user
  Future<void> getCurrentLocation() async {
    if (await _isGeolocationAvailable()) {
      try {
        final position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        initialLatLng.value = LatLng(position.latitude, position.longitude);
        final GoogleMapController? controller = googleMapController.value;
        controller?.animateCamera(
          CameraUpdate.newLatLngZoom(initialLatLng.value, 14.0),
        );
      } catch (e) {
        Get.snackbar('Error', 'Failed to get current location: $e');
      }
    } else {
      Get.snackbar('Error', 'Geolocation is not available.');
    }
  }

  /// Check if geolocation services are enabled
  Future<bool> _isGeolocationAvailable() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  /// Move the camera to a specific location on the map
  void moveToLocation(LatLng location) {
    googleMapController.value?.animateCamera(
      CameraUpdate.newLatLng(location),
    );
  }


  void _showReportDetails(ReportIncidentModel report) {
    Get.dialog(
      AlertDialog(
        title: Text(report.titleIncident),
        content: Container(
          width: 300,
          height: 400,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Description: ${report.incidentDescription}"),
                SizedBox(height: 10),
                Text("Reported by: ${report.fullName}"),
                SizedBox(height: 10),
                Text("Location: ${report.incidentCity}"),
                SizedBox(height: 10),
                Text("Date: ${report.formattedDateTime}"),
                SizedBox(height: 10),
                Text("Images:"),
                SizedBox(height: 10),
                if (report.incidentImages != null && report.incidentImages!.isNotEmpty)
                  Container(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: report.incidentImages!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: report.incidentImages![index],
                              fit: BoxFit.cover,
                              width: 100,
                              height: 200,
                              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                else
                  Text("No images available."),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
            },
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}
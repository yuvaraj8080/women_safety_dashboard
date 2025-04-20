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



  // Observable variable to track the current report type
  RxString currentReportType = 'Incident'.obs; // Default to 'Incident'


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

  // Method to change the report type
  void changeReportType(String type) {
    currentReportType.value = type;
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
        title: Text(
          report.titleIncident,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Container(
          width: 300,
          height: 400,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height:20),
                _buildLabelValue("Incident Category:", report.categoriesIncident),
                _buildLabelValue("Description:", report.incidentDescription),
                _buildLabelValue("Reported by:", report.fullName),
                _buildLabelValue("Contact NO:", report.phoneNo),
                _buildLabelValue("Location:", report.incidentCity),
                _buildLabelValue("Date:", report.formattedDateTime),
                Text(
                  "Images:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
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
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Center(child: Icon(Icons.error)),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                else
                  Text(
                    "No images available.",
                    style: TextStyle(fontSize: 14),
                  ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
            },
            child: Text(
              "Close",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabelValue(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 14, color: Colors.black),
          children: [
            TextSpan(
              text: "$label ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            TextSpan(
              text: value,
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }


  final List<Map<String, String>> sosReports = [
    {
      "name": "Alice Johnson",
      "dateTime": "2025-04-20 10:15 AM",
      "mapUrl": "https://www.google.com/maps/search/?api=1&query=37.7749,-122.4194",
    },
    {
      "name": "Brian Smith",
      "dateTime": "2025-04-20 10:00 AM",
      "mapUrl": "https://www.google.com/maps/search/?api=1&query=37.7759,-122.4184",
    },
    {
      "name": "Catherine Lee",
      "dateTime": "2025-04-20 09:45 AM",
      "mapUrl": "https://www.google.com/maps/search/?api=1&query=37.7769,-122.4174",
    },
    {
      "name": "Daniel Kim",
      "dateTime": "2025-04-20 09:30 AM",
      "mapUrl": "https://www.google.com/maps/search/?api=1&query=37.7779,-122.4164",
    },
    {
      "name": "Emma Davis",
      "dateTime": "2025-04-20 09:15 AM",
      "mapUrl": "https://www.google.com/maps/search/?api=1&query=37.7789,-122.4154",
    },
    {
      "name": "Frank Miller",
      "dateTime": "2025-04-20 09:00 AM",
      "mapUrl": "https://www.google.com/maps/search/?api=1&query=37.7799,-122.4144",
    },
    {
      "name": "Grace Wilson",
      "dateTime": "2025-04-20 08:45 AM",
      "mapUrl": "https://www.google.com/maps/search/?api=1&query=37.7809,-122.4134",
    },
    {
      "name": "Henry Thomas",
      "dateTime": "2025-04-20 08:30 AM",
      "mapUrl": "https://www.google.com/maps/search/?api=1&query=37.7819,-122.4124",
    },
    {
      "name": "Isabella Martinez",
      "dateTime": "2025-04-20 08:15 AM",
      "mapUrl": "https://www.google.com/maps/search/?api=1&query=37.7829,-122.4114",
    },
    {
      "name": "Jack White",
      "dateTime": "2025-04-20 08:00 AM",
      "mapUrl": "https://www.google.com/maps/search/?api=1&query=37.7839,-122.4104",
    },
    {
      "name": "Katie Brown",
      "dateTime": "2025-04-20 07:45 AM",
      "mapUrl": "https://www.google.com/maps/search/?api=1&query=37.7849,-122.4094",
    },
    {
      "name": "Leo Scott",
      "dateTime": "2025-04-20 07:30 AM",
      "mapUrl": "https://www.google.com/maps/search/?api=1&query=37.7859,-122.4084",
    },
    {
      "name": "Mia Allen",
      "dateTime": "2025-04-20 07:15 AM",
      "mapUrl": "https://www.google.com/maps/search/?api=1&query=37.7869,-122.4074",
    },
    {
      "name": "Nathan Young",
      "dateTime": "2025-04-20 07:00 AM",
      "mapUrl": "https://www.google.com/maps/search/?api=1&query=37.7879,-122.4064",
    },
    {
      "name": "Olivia Clark",
      "dateTime": "2025-04-20 06:45 AM",
      "mapUrl": "https://www.google.com/maps/search/?api=1&query=37.7889,-122.4054",
    },
  ];

}
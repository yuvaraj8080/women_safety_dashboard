import 'dart:async';
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
  int shakeCount = 0;

  @override
  void onInit() {
    super.onInit();
    // On the web, the browser handles geolocation permissions automatically.
    getCurrentLocation();
    fetchReports();
  }

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
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    }

    polygons.assignAll(reportPolygons);
    markers.assignAll(reportMarkers);
  }

  List<List<LatLng>> _clusterReports(List<ReportIncidentModel> reports, double distanceInMeters) {
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

  bool _isPointInCluster(LatLng point, List<LatLng> cluster, double distanceInMeters) {
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

  Future<void> getCurrentLocation() async {
    // For web: the browser handles geolocation permissions.
    if (await _isGeolocationAvailable()) {
      // Get the current position using Geolocator (works in web if HTTPS is used)
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      initialLatLng.value = LatLng(position.latitude, position.longitude);
      final GoogleMapController? controller = googleMapController.value;
      controller?.animateCamera(
        CameraUpdate.newLatLngZoom(initialLatLng.value, 14.0),
      );
    } else {
      Get.snackbar('Error', 'Geolocation is not available.');
    }
  }

  Future<bool> _isGeolocationAvailable() async {
    // In web browsers, this will check if geolocation is enabled.
    return await Geolocator.isLocationServiceEnabled();
  }
}

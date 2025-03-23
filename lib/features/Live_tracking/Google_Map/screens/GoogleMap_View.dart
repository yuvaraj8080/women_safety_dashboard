import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:women_safety_dashboard/features/Live_tracking/Google_Map/widgets/report_widget.dart';
import '../controller/LiveLocationController.dart';

class GoogleMap_View_Screen extends StatelessWidget {
  final LiveLocationController locationController = Get.put(LiveLocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Map View")),
      body: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            flex: 3, // Google Map takes 3 parts
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
              child: Obx(() => GoogleMap(
                buildingsEnabled: true,
                trafficEnabled: true,
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: locationController.initialLatLng.value,
                  zoom: 14.0,
                ),
                markers: Set<Marker>.of(locationController.markers),
                polygons: Set<Polygon>.of(locationController.polygons),
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  locationController.googleMapController.value = controller;
                },
              )),
            ),
          ),
          SizedBox(width: 10), // Space between map and list
          Expanded(
            flex: 1, // Incident list takes 1 part
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('ReportIncidents').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Failed to load reports: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No reports found.'));
                } else {
                  final reports = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: reports.length,
                    itemBuilder: (context, index) {
                      final report = reports[index];
                      LatLng reportLocation = LatLng(
                        double.parse(report['Latitude']),
                        double.parse(report['Longitude']),
                      );
                      return GestureDetector(
                        onTap: () {
                          // Move the camera to the report's location
                          locationController.moveToLocation(reportLocation);
                        },
                        child: ReportWidget(
                          city: report['IncidentCity'],
                          description: report['IncidentDescription'],
                          fullName: report['FullName'],
                          phoneNo: report['PhoneNo'],
                          time: report['IncidentDate'].toDate(),
                          type: report['TitleIncident'],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
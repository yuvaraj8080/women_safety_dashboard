import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:women_safety_dashboard/features/Live_tracking/Google_Map/repositories/reports_fetching.dart';
import 'package:women_safety_dashboard/features/Live_tracking/Google_Map/widgets/report_widget.dart';
import '../controller/LiveLocationController.dart';

class GoogleMap_View_Screen extends StatelessWidget {
  final LiveLocationController locationController = Get.put(LiveLocationController());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    fetchAndPrintReports();
    fetchAndPrintReports();
    
    return Scaffold(
      appBar: AppBar(title: Text("Map View")),
      body: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container for the map covering 60% of the screen height
              
              Container(
                height: screenHeight * 0.8,
                width:screenWidth *0.6,
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
              // Additional content below the map
              
            ],
          ),
          SizedBox(width: 10),
          // fetch reports
          StreamBuilder<QuerySnapshot>(
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
                      return ReportWidget(
                        city: report['IncidentCity'],
                        description: report['IncidentDescription'],
                        fullName: report['FullName'],
                        phoneNo: report['PhoneNo'],
                        time: report['IncidentDate'].toDate(),
                        type: report['TitleIncident'],
                      );
                    },
                  );
                }
              },
            ),   
  
        ],
      ),
    );
  }
}

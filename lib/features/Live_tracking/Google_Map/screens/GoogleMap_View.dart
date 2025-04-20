import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:women_safety_dashboard/features/Live_tracking/Google_Map/widgets/report_widget.dart';
import '../controller/LiveLocationController.dart';
import '../widgets/IncidentReportListView.dart';
import '../widgets/SOSReportLIstView.dart';

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
          SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                ToggleButtons(
                  isSelected: [
                    locationController.currentReportType.value == 'Incident',
                    locationController.currentReportType.value == 'SOS',
                  ],
                  onPressed: (int index) {
                    locationController.changeReportType(index == 0 ? 'Incident' : 'SOS');
                  },
                  children:  [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal:30,),
                      child: Text("Incident"),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal:30,),
                      child: Text("SOS"),
                    ),
                  ],
                ),
                Obx(() {
                  // Display the appropriate ListView based on the selected report type
                  if (locationController.currentReportType.value == 'Incident') {
                    return IncidentReportListView(locationController: locationController);
                  } else {
                    return Sosreportlistview(locationController: locationController); // Placeholder for SOS reports
                  }
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

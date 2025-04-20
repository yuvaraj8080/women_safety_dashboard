import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controller/LiveLocationController.dart';

class Sosreportlistview extends StatelessWidget {
  const Sosreportlistview({
    Key? key,
    required this.locationController,
  }) : super(key: key);

  final LiveLocationController locationController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: locationController.sosReports.length,
        itemBuilder: (context, index) {
          final report = locationController.sosReports[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: ListTile(
              leading:Icon(Icons.account_circle_rounded,size:30),
              title: Text(
                report["name"] ?? "",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize:12),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Time: ${report["dateTime"]}",style: const TextStyle(fontSize: 10)),
                  GestureDetector(
                    onTap: () async {
                      final url = report["mapUrl"] ?? "";
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      }
                    },
                    child: const Text(
                      "View Location",
                      style: TextStyle(color: Colors.blue, fontSize: 14, decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

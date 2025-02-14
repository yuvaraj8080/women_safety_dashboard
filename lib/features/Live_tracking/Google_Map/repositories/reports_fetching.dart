
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:women_safety_dashboard/features/Live_tracking/Google_Map/models/ReportIncidentModel.dart';

Future<List<ReportIncidentModel>> fetchReportsFromFirebase() async {
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('ReportIncidents').get();

    List<ReportIncidentModel> reports = querySnapshot.docs
        .map((doc) => ReportIncidentModel.fromSnapshot(doc))
        .toList();

    return reports;
  } catch (e) {
    print('Error fetching reports: $e');
    return [];
  }
}

void fetchAndPrintReports() async {
  List<ReportIncidentModel> reports = await fetchReportsFromFirebase();
  if (reports.isEmpty) {
    print("No reports found.");
  } else {
    for (var report in reports) {
      print(report); // Ensure your ReportIncidentModel has a proper toString() method for meaningful output.
    }
  }
}
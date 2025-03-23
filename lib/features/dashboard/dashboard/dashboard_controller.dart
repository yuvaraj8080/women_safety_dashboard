import 'package:get/get.dart';
import 'package:women_safety_dashboard/features/Live_tracking/Google_Map/models/ReportIncidentModel.dart';
import '../../../data/repositories/dashboard/dashboard_repository.dart';
import '../../../utils/popups/loaders.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();

  RxBool isLoading = true.obs;
  final RxList<int> monthlyIncidentCounts = List.filled(12, 0).obs;
  RxList<ReportIncidentModel> totalReportedIncidents = <ReportIncidentModel>[].obs;
  final DashboardRepository dashboardRepository = Get.put(DashboardRepository());

  // New variable for selected incident type
  RxString selectedIncidentType = 'Harassment'.obs; // Default selected incident type
  final List<String> popularIncidents = [
    'Harassment',
    'Sexual Harassment',
    'Stalking',
    'Domestic Violence',
    'Rape',
    'Attempt to Rape',
    'Molestation',
    'Human Trafficking',
    'Acid Attack',
    'Dowry Harassment',
    'Workplace Harassment',
    'Cyber Harassment',
    'Public Safety Violation',
    'Kidnapping & Abduction',
    'Eve-Teasing',
    'Forced Marriage',
    'Online Blackmail'
  ];

  @override
  void onInit() {
    fetchReceivingTransactionRecords();
    super.onInit();
  }

  Future<void> fetchReceivingTransactionRecords() async {
    try {
      isLoading.value = true;
      List<ReportIncidentModel> incidentsReport = await dashboardRepository.fetchIncidentsReports();
      totalReportedIncidents.assignAll(incidentsReport);
      _calculateMonthlyIncidentCounts();
      isLoading.value = false;
    } catch (e) {
      print("error:${e.toString()}");
      isLoading.value = false;
      TLoaders.errorSnackBar(title: "Oh Snap", message: e.toString());
    }
  }

  void _calculateMonthlyIncidentCounts() {
    // Reset monthly counts
    monthlyIncidentCounts.assignAll(List.filled(12, 0));

    for (var incident in totalReportedIncidents) {
      // Filter incidents based on selected incident type
      if (incident.titleIncident == selectedIncidentType.value) {
        DateTime? incidentDate = incident.incidentDate; // Adjust this line based on your model
        int month = incidentDate!.month - 1; // Get month index (0-11)
        monthlyIncidentCounts[month]++;
      }
    }
  }

  // Method to change selected incident type
  void changeSelectedIncidentType(String newType) {
    selectedIncidentType.value = newType;
    _calculateMonthlyIncidentCounts(); // Recalculate counts when type changes
  }
}
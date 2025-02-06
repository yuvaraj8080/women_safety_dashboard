import 'package:get/get.dart';

class DashboardController extends GetxController{
  static DashboardController get instance => Get.find();

  RxBool isLoading = true.obs;
  final RxList<double> yearlyCrimeData = <double>[].obs;
  final RxDouble totalYearlyCrime = 0.0.obs;

  @override
  void onInit(){
    fetchDummyYearlyData();
    _calculateYearlyCrimeData();
    super.onInit();
  }

  // Dummy data function for yearly crime percentage
  void fetchDummyYearlyData() {
    yearlyCrimeData.value = [10.0, 12.5, 8.0, 15.5, 20.0, 18.5, 25.0, 30.0, 22.5, 27.0, 35.0, 40.5];
  }

  void _calculateYearlyCrimeData(){
    // This method can be used to calculate yearly crime data from actual data sources
    // For now, it just assigns the dummy data
    totalYearlyCrime.value = yearlyCrimeData.reduce((a, b) => a + b);
  }
}
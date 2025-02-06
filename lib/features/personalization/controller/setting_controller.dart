import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_safety_dashboard/features/personalization/controller/setting_repository.dart';
import 'package:women_safety_dashboard/features/personalization/controller/setting_repository.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../models/setting_model.dart';

class SettingController extends GetxController {
  static SettingController get instance => Get.find();

  RxBool loading = false.obs; // To track loading state
  Rx<SettingModel> setting = SettingModel.empty().obs; // Reactive setting model

  final settingFormKey = GlobalKey<FormState>(); // Form key for validation
  final appNameController = TextEditingController(); // Controller for app name
  final taxRateController = TextEditingController(); // Controller for tax rate
  final shippingRateController = TextEditingController(); // Controller for shipping rate
  final threshHoldController = TextEditingController(); // Controller for threshold

  final SettingRepository _repository = Get.put(SettingRepository()); // Repository instance

  @override
  void onInit() {
    fetchSettingDetails(); // Fetch settings on initialization
    super.onInit();
  }

  /// FETCHES SETTINGS FROM THE REPOSITORY
  Future<void> fetchSettingDetails() async {
    try {
      loading.value = true; // Set loading to true
      final settingData = await _repository.getSettings(); // Fetch settings from repository
      if (settingData != null) {
        setting.value = settingData; // Update reactive setting model
        // Assign the fetched data to the TextEditingController
        appNameController.text = settingData.appName;
        taxRateController.text = settingData.taxRate.toString();
        shippingRateController.text = settingData.shippingRate.toString();
        threshHoldController.text = settingData.threshHold.toString();
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Something went wrong', message: e.toString()); // Show error message
    } finally {
      loading.value = false; // Set loading to false
    }
  }

  /// Adds new settings to the repository
  Future<void> addSettingDetails() async {

    TFullScreenLoader.openLoadingDialog("Updating Data", TImages.docerAnimation);


    if (settingFormKey.currentState!.validate()) { // Validate form
      try {
        final newSetting = SettingModel(
          appName: appNameController.text, // Get app name from controller
          taxRate: double.parse(taxRateController.text), // Parse tax rate
          shippingRate: double.parse(shippingRateController.text), // Parse shipping rate
          threshHold: double.parse(threshHoldController.text), // Parse threshold
        );
        await _repository.createSettings(newSetting);


        update();

        TFullScreenLoader.stopLoading();
        TLoaders.successSnackBar(title: 'Success', message: 'Settings details updated successfully');

      } catch (e) {
        TFullScreenLoader.stopLoading();
        Get.snackbar('Error', e.toString()); // Show error message
      }
    }
  }


}

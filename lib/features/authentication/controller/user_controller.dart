import 'package:flutter/material.dart';
import 'package:flutter_admin_web/data/repositories/user/user_repository.dart';
import 'package:flutter_admin_web/routes/routes.dart';
import 'package:flutter_admin_web/utils/popups/loaders.dart';
import 'package:get/get.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../models/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  RxBool loading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());

  final adminFormKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  void onInit() {
    fetchUserDetails();
    super.onInit();
  }

  /// FETCHES USER DETAILS FROM THE REPOSITORY
  Future<UserModel> fetchUserDetails() async {
    try {
      loading.value = true;
      final user = await userRepository.fetchAdminDetails();
      this.user.value = user;
      loading.value = false;

      // Assign the fetched data to the TextEditingController
      firstNameController.text = user.firstName;
      lastNameController.text = user.lastName;
      emailController.text = user.email;
      phoneNumberController.text = user.phoneNumber;

      return user;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Something went wrong', message: e.toString());
      return UserModel.empty();
    }
  }

  /// UPDATES ADMIN DETAILS
  Future<void> updateAdminDetails() async {
    if (adminFormKey.currentState!.validate()) {
      try {


        TFullScreenLoader.openLoadingDialog("Updating Data", TImages.docerAnimation);

        await userRepository.updateAdminDetails(
          firstNameController.text,
          lastNameController.text,
          phoneNumberController.text,
        );

        update();

        TFullScreenLoader.stopLoading();
        TLoaders.successSnackBar(title: 'Success', message: 'Admin details updated successfully');
      } catch (e) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(title: 'Something went wrong', message: e.toString());
      }
    }
  }



  ///  CONFIRMATION DIALOGUE BOX TO DELETE THE CATEGORY ITEMS
  confirmLogoutUser(){
    /// SHOW A DIALOGUE BOX
    Get.defaultDialog(
        title:"Log Out User",
        content:const Text("Are you sure you want to logout this user?"),
        confirm:SizedBox(
            width:50,
            child:ElevatedButton(
              onPressed: () async => await logoutUser(),
              style:OutlinedButton.styleFrom(
                padding:const EdgeInsets.symmetric(vertical:TSizes.buttonHeight18 / 2),
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(TSizes.buttonRadius10 * 5)),
              ),
              child: const Text("Ok"),
            )
        ),
        cancel:SizedBox(
            width:80,
            child:OutlinedButton(
              onPressed:()=> Get.back(),
              style:OutlinedButton.styleFrom(
                padding:const EdgeInsets.symmetric(vertical:TSizes.buttonHeight18 / 2),
                shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(TSizes.buttonRadius10 * 5)),
              ),
              child:const Text("Cancel"),
            )
        )
    );
  }

  /// LOGOUT USER
  Future<void> logoutUser() async {
    try {
      TFullScreenLoader.openLoadingDialog("Logging out", TImages.docerAnimation);
      await userRepository.logoutUser();
      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(title: 'Success', message: 'Logged out successfully');
      Get.offAllNamed(TRoutes.login); // Navigate to login screen after logout
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Something went wrong', message: e.toString());
    }
  }

}
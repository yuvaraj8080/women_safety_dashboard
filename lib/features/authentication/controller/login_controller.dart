import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:women_safety_dashboard/data/repositories/user/user_repository.dart';
import 'package:women_safety_dashboard/features/authentication/controller/user_controller.dart';
import 'package:women_safety_dashboard/features/authentication/models/user_model.dart';
import 'package:women_safety_dashboard/utils/constants/enums.dart';
import 'package:women_safety_dashboard/utils/helpers/network_manager.dart';
import 'package:women_safety_dashboard/utils/popups/loaders.dart';

import '../../../data/repositories/authentication/authentication_repositories.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/popups/full_screen_loader.dart';

class LoginController extends GetxController{
  static LoginController get instance => Get.find();

  final hidePassword = true.obs;
  final rememberMe = false.obs;

  final email = TextEditingController();
  final password = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();


  /// HANDLES EMAIL AND PASSWORD SIGN IN PROCESS
  Future<void> emailAndPasswordSignIn() async{
    try{
      /// START LOADING
      TFullScreenLoader.openLoadingDialog("Login Admin Account...", TImages.docerAnimation);

      /// CHECK INTERNET CONNECTIVITY
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }

      /// FORM VALIDATION
      if(!loginFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }


      /// login USER USING EMAIL & PASSWORD AUTHENTICATIONS
      await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(),password.text.trim());


      /// FETCH USER DETAILS AND ASSIGN TO USER CONTROLLER
      final user = await UserController.instance.fetchUserDetails();

      /// REMOVE THE LOADER
      TFullScreenLoader.stopLoading();

      // IF USER IS NOT ADMIN, LOGOUT AND RETURN
      if(user.role != AppRole.admin){
        await AuthenticationRepository.instance.logout();
        TLoaders.errorSnackBar(title:"Not Authorized",message:"You are not authorized or do have access. Contact Admin");
      }else{
        AuthenticationRepository.instance.screenRedirect();
      }
    }
    catch(e){
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title:"Oh Snap",message:e.toString());
    }
  }


  /// HANDLES REGISTRATION OF ADMIN USER
  Future<void> registerAdmin()async{
    try{
      /// START LOADING
      TFullScreenLoader.openLoadingDialog("Registration Admin Account...", TImages.docerAnimation);

      /// CHECK INTERNET CONNECTIVITY
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        return;
      }

      /// FORM VALIDATION
      if(!loginFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }




      /// REGISTER USER USING EMAIL & PASSWORD AUTHENTICATIONS
      await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(),password.text.trim());


      ///  CREATE ADMIN RECORD IN THE FIRESTORE
      final userRepository = Get.put(UserRepository());
      await userRepository.createUser(
        UserModel(
          id:AuthenticationRepository.instance.authUser!.uid,
          email:email.text.trim(),
          firstName:"Yuvaraj",
          lastName: "Dekhane",
          role: AppRole.admin,
          createdAt:DateTime.now(),
          phoneNumber: '8080737803',
        ),
      );

      /// REMOVE THE LOADER
      TFullScreenLoader.stopLoading();

      ///  REDIRECT
      AuthenticationRepository.instance.screenRedirect();

    }
    catch(e){
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title:"Oh Snap",message:e.toString());
    }
  }

}
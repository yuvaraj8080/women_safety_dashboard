import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:women_safety_dashboard/features/authentication/models/user_model.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../authentication/authentication_repositories.dart';

class UserRepository extends GetxController{
  static UserRepository get instance => Get.find();


  final _db = FirebaseFirestore.instance;

  /// FUNCTION TO STORE USER DATA TO FiRESTORE
  Future<void> createUser(UserModel user) async{
    try{
      await _db.collection("Users").doc(user.id).set(user.toJson());
    }
    on FirebaseAuthException catch(e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const TFormatException();
    } on PlatformException catch(e){
      throw TPlatformException(e.code).message;
    }
    catch(e){
      throw "Something went wrong. Please try again";
    }
  }

  /// FUCTION TO FETCH USER DETIALS BASED ON USER ID
  Future<UserModel> fetchUserDetails(String id) async{
      try {
        final docSnapshot = await _db.collection("Users").doc(id).get();
        if (docSnapshot.exists) {
          return UserModel.fromSnapshot(docSnapshot);
        } else {
          return UserModel.empty(); // Return an empty UserModel if the user ID is not found
        }
    }
    on FirebaseAuthException catch(e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const TFormatException();
    } on PlatformException catch(e){
      throw TPlatformException(e.code).message;
    }
    catch(e){
      print("error:${e.toString()}");
      throw "Something went wrong. Please try again";
    }
  }


  /// FUNCTION TO FETCH USER AND ADMIN DETAILS ON USER ID
  Future<UserModel> fetchAdminDetails() async{
    try{
      final docSnapshot = await _db.collection("Users").doc(AuthenticationRepository.instance.authUser!.uid).get();
      return UserModel.fromSnapshot(docSnapshot);
    }
    on FirebaseAuthException catch(e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const TFormatException();
    } on PlatformException catch(e){
      throw TPlatformException(e.code).message;
    }
    catch(e){
      throw "Something went wrong. Please try again";
    }
  }


  ///  FUNCTION TO FETCH USER DETAILS BASED ON USER ID
  Future<List<UserModel>> getAllaUsers() async{
    try{
      final querySnapshot = await _db.collection("Users").orderBy("FirstName").get();
      return querySnapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).toList();
    }
    on FirebaseAuthException catch(e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const TFormatException();
    } on PlatformException catch(e){
      throw TPlatformException(e.code).message;
    }
    catch(e){
      throw "Something went wrong. Please try again";
    }
  }



  /// FUNCTION TO STORE USER DATA TO FiRESTORE
  Future<void> deleteUser(String id) async{
    try{
      await _db.collection("Users").doc(id).delete();
    }
    on FirebaseAuthException catch(e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const TFormatException();
    } on PlatformException catch(e){
      throw TPlatformException(e.code).message;
    }
    catch(e){
      throw "Something went wrong. Please try again";
    }
  }

  /// UPDATES ADMIN DETAILS
  Future<void> updateAdminDetails(String firstName, String lastName, String phoneNumber) async {
    try {
      await _db.collection("Users").doc(AuthenticationRepository.instance.authUser!.uid).update({
        "FirstName": firstName,
        "LastName": lastName,
        "PhoneNumber": phoneNumber,
      });
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }


  /// FUNCTION TO LOGOUT USER
  Future<void> logoutUser() async {
    try {
      await AuthenticationRepository.instance.logout();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

}
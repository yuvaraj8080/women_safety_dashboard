import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_admin_web/routes/routes.dart';
import 'package:flutter_admin_web/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:flutter_admin_web/utils/exceptions/firebase_exceptions.dart';
import 'package:flutter_admin_web/utils/exceptions/format_exceptions.dart';
import 'package:flutter_admin_web/utils/exceptions/platform_exceptions.dart';
import 'package:get/get.dart';

class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance => Get.find();

  /// FIREBASE AUTH INSTANCE
  final _auth = FirebaseAuth.instance;

  /// GET AUTHENTICATED USER
  User? get authUser => _auth.currentUser;

  /// GET IS AUTHENTICATED USER
  bool get isAuthenticated => _auth.currentUser != null;

  @override
  void onReady() {
    _auth.setPersistence(Persistence.LOCAL);
  }


  /// FUNCTION TI DETERMINE THE RELEVANT SCREEN ADN REDIRECT ACCORDINGLY
  void screenRedirect() async{
    final user = _auth.currentUser;

    /// IF THE USER IS LOGGED IN
    if(user != null){
      /// navigate to the home
      Get.offAllNamed(TRoutes.dashboard);
    }
    else{
      Get.offAllNamed(TRoutes.login);
    }
  }


  /// LOGIN
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async{
    try{
      return await _auth.signInWithEmailAndPassword(email:email, password: password);
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

  /// REGISTER
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async{
    try{
      return await _auth.createUserWithEmailAndPassword(email:email, password: password);
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


  /// REGISTER USER BY ADMIN


  /// LOGOUT
  Future<void> logout() async{
    try{
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed(TRoutes.login);
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
}
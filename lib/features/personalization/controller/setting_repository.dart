import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../models/setting_model.dart';

class SettingRepository extends GetxService {
  static SettingRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// FUNCTION TO CREATE OR ADD SETTINGS
  Future<void> createSettings(SettingModel settings) async {
    try {
      // Add settings to Firestore, 'settings' is the collection name
      await _db.collection("AppSetting").doc('settings').set(settings.toJson());
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


  /// FUNCTION TO GET SETTINGS
  Future<SettingModel> getSettings() async {
    try {
      // Fetch the settings document
      final DocumentSnapshot settingsDoc = await _db.collection("AppSetting").doc('settings').get();

      // Check if the document exists before converting
      if (!settingsDoc.exists) {
        return SettingModel.empty(); // Return an empty model if no document is found
      }

      // Convert the Firestore document to SettingModel
      return SettingModel.fromSnapshot(settingsDoc);

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

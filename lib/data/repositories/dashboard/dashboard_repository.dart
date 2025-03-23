import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:women_safety_dashboard/features/Live_tracking/Google_Map/models/ReportIncidentModel.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class DashboardRepository extends GetxController {
  static DashboardRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //// FUNCTION FOR THE FETCH REPORT INCIDENTS FROM THE ReportIncidents COLLECTIONS

  Future<List<ReportIncidentModel>> fetchIncidentsReports() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection("ReportIncidents").get();
      return querySnapshot.docs.map((doc) => ReportIncidentModel.fromSnapshot(doc)).toList();
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

  //
  // /// Fetch the registered clients from Firestore
  // Future<List<AdminModel>> fetchRegisterMembers() async {
  //   try {
  //     final querySnapshot = await FirebaseFirestore.instance.collection("Admin").get();
  //
  //     // Map the documents to ClientRegistrationModel instances
  //     return querySnapshot.docs.map((doc) => AdminModel.fromSnapshot(doc)).toList();
  //   } on FirebaseAuthException catch (e) {
  //     throw TFirebaseAuthException(e.code).message;
  //   } on FirebaseException catch (e) {
  //     throw TFirebaseException(e.code).message;
  //   } on FormatException catch (_) {
  //     throw const TFormatException();
  //   } on PlatformException catch (e) {
  //     throw TPlatformException(e.code).message;
  //   } catch (e) {
  //     throw "Something went wrong. Please try again";
  //   }
  // }
  //
  //
  // //// FUNCTION FOR THE FETCHING THE ALL EXPANSES RECORDS FROM THE ExpansesTransaction COLLECTION ////
  // Future<List<ExpansesTransactionModel>>getAllExpansesRecords() async {
  //   try {
  //     final snapshot = await _db.collection("ExpansesTransaction").get();
  //
  //     final result = snapshot.docs.map((doc) => ExpansesTransactionModel.fromSnapshot(doc)).toList();
  //     return result;
  //   } on FirebaseException catch (e) {
  //     throw TFirebaseException(e.code).message;
  //   } on PlatformException catch (e) {
  //     throw TPlatformException(e.code).message;
  //   } catch (e) {
  //     printError(info: e.toString());
  //     throw "Something went wrong. Please try again";
  //   }
  // }
  //
  // //// FUNCTION FOR THE FETCHING THE ALL RECEIVING RECORDS FROM THE ReceivingTransaction COLLECTION ////
  // Future<List<ClientRecordModel>>getAllReceivingRecords() async {
  //   try {
  //     final snapshot = await _db.collection("ReceivingTransaction").get();
  //
  //     final result = snapshot.docs.map((doc) => ClientRecordModel.fromSnapshot(doc)).toList();
  //     return result;
  //   } on FirebaseException catch (e) {
  //     throw TFirebaseException(e.code).message;
  //   } on PlatformException catch (e) {
  //     throw TPlatformException(e.code).message;
  //   } catch (e) {
  //     printError(info: e.toString());
  //     throw "Something went wrong. Please try again";
  //   }
  // }
  //
  //
  // //// STORE THE MEMBERED ASSIGNED ROLE IN THE FIREBASE ////
  // Future<void> updateMemberRole(String memberId, String newRole) async {
  //   // Assuming you have a Firestore instance
  //   final memberRef = FirebaseFirestore.instance.collection('Admin').doc(memberId);
  //   await memberRef.update({
  //     'Role': newRole, // Store the role as a string
  //   });
  // }
  //
  // //// STORE THE PROJECT ASSIGNED STATUS IN THE FIREBASE ////
  // Future<void> updateProjectStatus(String clientId, String newStatus) async {
  //   // Assuming you have a Firestore instance
  //   final memberRef = FirebaseFirestore.instance.collection('ClientNames').doc(clientId);
  //   await memberRef.update({
  //     'Status': newStatus, // Store the role as a string
  //   });
  // }
  //
  // //// STORE THE VENDOR ASSIGNED RATING IN THE FIREBASE ////
  // Future<void> updateVendorRating(String vendorId, String newRating) async {
  //   // Assuming you have a Firestore instance
  //   final memberRef = FirebaseFirestore.instance.collection('VendorNames').doc(vendorId);
  //   await memberRef.update({
  //     'Rating': newRating, // Store the role as a string
  //   });
  // }

}
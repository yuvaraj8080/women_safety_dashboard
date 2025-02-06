// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import '../../../utils/exceptions/firebase_exceptions.dart';
// import '../../../utils/exceptions/format_exceptions.dart';
// import '../../../utils/exceptions/platform_exceptions.dart';
//
// class CrimeReportRepository extends GetxController{
//   static CrimeReportRepository get instance => Get.find();
//
//
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//
//   //// GET ALL ORDERS RELATED THE THE CURRENT USER
//   Future<List<OrderModel>> getAllOrders() async{
//     try{
//       final result = await _db.collection("Orders").orderBy("orderDate", descending: true).get();
//       return result.docs.map((documentSnapshot) => OrderModel.fromSnapshot(documentSnapshot)).toList();
//     }on FirebaseException catch(e){
//       throw TFirebaseException(e.code).message;
//     }on PlatformException catch(e){
//       throw TPlatformException(e.code).message;
//     }on FormatException catch(_){
//       throw const TFormatException().message;
//     }
//     catch(e){
//       print("error:${e.toString()}");
//       throw "Something went wrong. Please try again";
//     }
//   }
//
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../features/shop/models/address_moder.dart';

class AddressRepository extends GetxController{
  static AddressRepository get instance => Get.find();


  //// FIREBASE FIRESTORE INSTANCE
  final _db = FirebaseFirestore.instance;

  ///// FETCH USER ADDRESSES FORM FIRESTORE BASED ON USER ID
  Future<List<AddressModel>> fetchUserAddresses(String userId)async{
    try{
      //// QUERY AFIRESTORE COLLECTION TO GET USER ADDRESSES
      final result = await _db.collection("Users").doc(userId).collection("Addresses").get();
      return result.docs.map((documentSnapshot) => AddressModel.fromDocumentSnapshot(documentSnapshot)).toList();
    }catch(e){
      print('error:${e.toString()}');
      throw "Something went wrong while fetching address Information";
    }
  }

}
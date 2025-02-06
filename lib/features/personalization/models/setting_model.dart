
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingModel {
  String appName;
  double taxRate;
  double shippingRate;
  double threshHold;

  /// CONSTRUCTOR FOR SETTINGMODEL
  SettingModel({
    required this.appName,
    required this.taxRate,
    required this.shippingRate,
    required this.threshHold,
  });


  /// STATIC FUNCTION TO CREATE AN EMPTY SETTING MODEL
  static SettingModel empty() => SettingModel(
    appName: '',
    taxRate: 0.0,
    shippingRate: 0.0,
    threshHold: 0.0,
  );

  /// SERIALIZATION METHODS
  Map<String, dynamic> toJson() {
    return {
      'AppName': appName,
      'TaxRate': taxRate,
      'ShippingRate': shippingRate,
      'ThreshHold': threshHold,
    };
  }

  /// FACTORY METHOD TO CREATE SETTINGMODEL FROM JSON OR SNAPSHOT
  factory SettingModel.fromSnapshot(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;
    return SettingModel(
      appName: data.containsKey('AppName') ? data['AppName'] ?? '' : '',
      taxRate: data.containsKey('TaxRate') ? data['TaxRate'] ?? 0.0 : 0.0,
      shippingRate: data.containsKey('ShippingRate')
          ? data['ShippingRate'] ?? 0.0
          : 0.0,
      threshHold: data.containsKey('ThreshHold')
          ? data['ThreshHold'] ?? 0.0
          : 0.0,
    );
  }
}
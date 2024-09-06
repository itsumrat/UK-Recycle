import 'dart:convert';

import 'package:crm/appConfig.dart';
import 'package:crm/model/mesumarment_model/mesumarmentModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DeliveryController {
  //add delivery controller
  static Future<http.Response> addNeDelivery({
    required String deliveryTypeID,
    required String assignTo,
    // required String productCategoryId,
    required String suplierId,
    required String measurementTypeId,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    var res = await http.post(Uri.parse(AppConfig.DELIVERY_ID), headers: {
      "Authorization": "Bearer $token"
    }, body: {
      // "category_id" : productCategoryId,
      "supplier_id": suplierId,
      "delivery_type": deliveryTypeID,
      "measurement_type": measurementTypeId,
      "assigned_to": assignTo
    });
    print("res == body == ${res.statusCode}");
    print("res == body == ${res.body}");
    return res;
  }

  static Future<AllMeasurementsListModel> getAllMeasurements() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    var res = await http.get(
      Uri.parse(AppConfig.ALL_MEASURMENTS),
      headers: {"Authorization": "Bearer $token"},
    );
    print("res---- ${res.statusCode}");
    debugPrint("res---- ${res.body}");

    return AllMeasurementsListModel.fromJson(jsonDecode(res.body));
  }
}

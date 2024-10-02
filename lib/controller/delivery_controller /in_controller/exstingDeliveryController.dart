import 'dart:convert';
import 'dart:developer';

import 'package:crm/appConfig.dart';
import 'package:crm/model/cage_model/cage_model.dart';
import 'package:crm/model/delivery_model/in_model/single_deliveryin_model.dart';
import 'package:crm/model/delivery_model/in_model/single_deliveryin_transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/delivery_model/in_model/deliveryin_model.dart';

class DeliveryInController {
  //existing model
  static Future<ExsitingDeliveryinModel> getExstingDeliveryIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    var res = await http.get(Uri.parse(AppConfig.DELIVERY_ID), headers: {"Authorization": "Bearer $token"});
    print(res.statusCode);
    print(res.body);
    return ExsitingDeliveryinModel.fromJson(jsonDecode(res.body));
  }

  //get single delivery in
  static Future<SingleDeliveryInModel> getSingleDeliveryIn({required String id}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    var res = await http.get(Uri.parse("${AppConfig.DELIVERY_ID}/$id"), headers: {"Authorization": "Bearer $token"});
    return SingleDeliveryInModel.fromJson(jsonDecode(res.body));
  }

  //Single existing model
  static Future<TranscaByDeliveryInIdModel> getSingleExistingDeliveryInTransactions({required String id}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    log("Access Token: $token", name: "Access Token");
    log("URI: ${AppConfig.TRANSCATION_BY_DELIVERYID}$id", name: "URI");
    var res = await http
        .get(Uri.parse("${AppConfig.TRANSCATION_BY_DELIVERYID}$id"), headers: {"Authorization": "Bearer $token"});
    log(res.statusCode.toString());
    log("res.body ${res.body}");
    return TranscaByDeliveryInIdModel.fromJson(jsonDecode(res.body));
  }

  //Single existing model
  static Future<http.Response> editTranscations({
    required String weight,
    required CageDatum? case_no,
    required String id,
    required String cageWeight,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    // var withoutCaseNo = {"weight": weight};
    var withCaseNo = {
      "product_weight": weight,
      if (case_no != null) "case_id": case_no.id!.toString(),
      "weight": double.tryParse(cageWeight) ?? 0,
    };
    log("Body: $withCaseNo", name: "Deliver In edit");
    var res = await http.put(
      Uri.parse("${AppConfig.DELIVERY_IN_TRANSCATION}/$id"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode(withCaseNo),
    );
    log(res.statusCode.toString());
    log(res.body);
    return res;
  }

  //Single existing model
  static Future<http.Response> addTranscations({
    required String deliveryTypeId,
    required CageDatum? cageNo,
    required String measurementId,
    required String weight,
    required String productCategoryId,
    required String cageWeight,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    var data = {
      "weight": double.tryParse(cageWeight) ?? 0,
      "delivery_id": deliveryTypeId,
      "measurement": measurementId,
      if (cageNo != null) "case_id": cageNo.id.toString(),
      "category_id": productCategoryId,
      "product_weight": weight,
    };
    log("Response Data: $data", name: "Data");
    var res = await http.post(Uri.parse(AppConfig.DELIVERY_IN_TRANSCATION),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(data));
    log(res.statusCode.toString(), name: "statuscode");
    log(res.body.substring(0, 500).toString(), name: "body");
    return res;
  }

  //delivery in delete
  static Future<http.Response> deleteDeliveryIn({required String id}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    var res = await http.delete(
      Uri.parse("${AppConfig.DELIVERY_ID}/$id"),
      headers: {"Authorization": "Bearer $token"},
    );
    print("res---- ${res.statusCode}");
    debugPrint("res---- ${res.body}");

    return res;
  }
}

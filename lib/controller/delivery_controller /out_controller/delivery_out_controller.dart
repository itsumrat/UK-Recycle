import 'dart:convert';
import 'dart:developer';

import 'package:crm/appConfig.dart';
import 'package:crm/model/cage_model/cage_model.dart';
import 'package:crm/model/delivery_model/out_model/SingleExistingDeliveryOutModel.dart';
import 'package:crm/model/delivery_model/out_model/deliveryOutTsListModel.dart';
import 'package:crm/model/delivery_model/out_model/existing_delivery_out_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/delivery_model/out_model/single_delveryout_trx_momdel.dart';

class DeliveryOutController {
  static Future<http.Response> addNewDeliveryOut({
    // required String category_id,
    required String customer_id,
    required String assign_id,
    required String measurement_type,
    required String delivery_type,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    var userId = pref.getString("uid");
    log("user id == $userId");
    log("BODY: customer_id: $customer_id, assign_id: $assign_id, measurement_type: $measurement_type, delivery_type: $delivery_type",
        name: "BODY");
    var res = await http.post(
      Uri.parse(AppConfig.DELIVERY_OUT_CREATE),
      body: {
        // "category_id": category_id,
        "customer_id": customer_id,
        "measurement_type": measurement_type,
        "delivery_type": delivery_type,
        "assigned_to": assign_id,
      },
      headers: {"Authorization": "Bearer $token"},
    );
    return res;
  }

  //get exsiting delivdy out
  static Future<ExistingDeliveryOutListModel> getExistingDelidyOutList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    var res = await http.get(Uri.parse(AppConfig.DELIVERY_OUT_CREATE), headers: {"Authorization": "Bearer $token"});
    return ExistingDeliveryOutListModel.fromJson(jsonDecode(res.body));
  }

  //get single delivery in
  static Future<SingleExistingDeliveryOutModel> getSingleDeliveryOut({required String id}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    var res =
        await http.get(Uri.parse("${AppConfig.DELIVERY_OUT_CREATE}/$id"), headers: {"Authorization": "Bearer $token"});
    log(res.statusCode.toString(), name: "Status Code");
    log(res.body, name: "Response Body");
    return SingleExistingDeliveryOutModel.fromJson(jsonDecode(res.body));
  }

  //get single delivery in
  static Future<DeliveryOutTrListModel> getSingleDeliveryOutTrList({required String id}) async {
    log("delivery id === $id");
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    var res = await http
        .get(Uri.parse("${AppConfig.TRANSCATION_BY_DELIVERYOUT}$id"), headers: {"Authorization": "Bearer $token"});
    log(res.statusCode.toString(), name: "Status Code");
    log(res.body, name: "Response Body");
    return DeliveryOutTrListModel.fromJson(jsonDecode(res.body));
  }

  //get single delivery in
  static Future<SingleDeliveryOutTrxModel> getSingleDeliveryOutTrx({required String id}) async {
    log("delivery id === $id");
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    var res =
        await http.get(Uri.parse("${AppConfig.DELIVERY_OUT_TR}/$id"), headers: {"Authorization": "Bearer $token"});
    log(res.statusCode.toString(), name: "Status Code");
    log(res.body, name: "Response Body");
    return SingleDeliveryOutTrxModel.fromJson(jsonDecode(res.body));
  }

  //Single existing model
  static Future<http.Response> addTranscations({
    required String deliveryTypeId,
    required CageDatum? cageNo,
    required String measurementId,
    required String weight,
    required String categoryId,
    required String productWeight,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    log("delivery id == $deliveryTypeId");
    log("Token: $token");
    var withoutCageNoData = {
      "weight": double.tryParse(productWeight) ?? 0,
      "delivery_id": deliveryTypeId,
      "measurement": measurementId,
      if (cageNo != null) "case_id": cageNo.id?.toString(),
      "category_id": categoryId,
      "product_weight": double.tryParse(weight) ?? 0,
    };
    log("withoutCageNoData: $withoutCageNoData");
    var res = await http.post(Uri.parse(AppConfig.DELIVERY_OUT_TR),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(withoutCageNoData));

    return res;
  }

  //edit
  static Future<http.Response> editTranscations({
    required String weight,
    required CageDatum? case_no,
    required String id,
    required String cageWeight,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    var withCaseNo = {
      "product_weight": double.tryParse(weight) ?? 0,
      if (case_no != null) "case_no": case_no.id.toString(),
      "weight": double.tryParse(cageWeight) ?? 0,
    };

    log("Body: $withCaseNo");

    var res = await http.put(Uri.parse("${AppConfig.DELIVERY_OUT_TR}/$id"),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(withCaseNo));

    return res;
  }

  //delete

  //delivery in delete
  static Future<http.Response> deleteDeliveryOut({required String id}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    var res = await http.delete(
      Uri.parse("${AppConfig.DELIVERY_OUT_CREATE}/$id"),
      headers: {"Authorization": "Bearer $token"},
    );
    return res;
  }
}

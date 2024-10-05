import 'dart:convert';
import 'dart:developer';

import 'package:crm/appConfig.dart';
import 'package:crm/controller/table_controller/table_controller.dart';
import 'package:crm/model/production_model/all_production_model.dart';
import 'package:crm/model/production_model/single_production_list.dart';
import 'package:crm/model/production_model/single_production_trx.dart';
import 'package:crm/model/production_model/transaction_by_production_id_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductionController {
  //get all production list
  static Future<AllProductionModel> getAllProduction() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    var res = await http.get(Uri.parse(AppConfig.PRODUCTION_LIST), headers: {"Authorization": "Bearer $token"});
    log("Body: ${res.statusCode}", name: "ProductionController");
    return AllProductionModel.fromJson(jsonDecode(res.body));
  }

  //production edit
  static Future<http.Response> editProductionTranscation(
      {required String id, required String gread, required String weight}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    print("tr id --- $id");
    var res = await http.put(Uri.parse("${AppConfig.PRODUCTION_LIST}/$id"),
        headers: {"Authorization": "Bearer $token"}, body: {"grade": gread, "weight": weight});
    return res;
  }

  //production edit
  static Future<http.Response> addProductionTranscation(
      {required String id, required String gread, required String weight}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    var res = await http.post(Uri.parse(AppConfig.PRODUCTION_LIST),
        headers: {"Authorization": "Bearer $token"}, body: {"production_id": id, "grade": gread, "weight": weight});
    print("res == ${res.body}");
    print("res == ${res.statusCode}");
    return res;
  }

  //create production
  static Future<http.Response> createNewProduction({
    required String production_date,
    required String table,
    required String assigned_to,
  }) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    var res = await http.post(Uri.parse(AppConfig.PRODUCTION_CREATE),
        body: {"production_date": production_date, "table": table, "assigned_to": assigned_to},
        headers: {"Authorization": "Bearer $token"});
    print("res === ${res.statusCode}");
    print("res === ${res.body}");
    return res;
  }

  //single production list
  static Future<SingleProductionModel?> getSingleProduction({required String id}) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var token = pref.getString("token");
      var res =
          await http.get(Uri.parse("${AppConfig.PRODUCTION_LIST}/$id"), headers: {"Authorization": "Bearer $token"});

      final singleProductionModel = SingleProductionModel.fromJson(jsonDecode(res.body));
      var table = (await TableController.getTableList())
          .data
          ?.firstWhere((element) => element.id == singleProductionModel.data?.production?.table);
      if (table != null) {
        singleProductionModel.data?.production?.tableData = table;
      }
      return singleProductionModel;
    } on Exception catch (e) {
      log("Exception == $e", name: "Single Production");
      return null;
    }
  }

  //single production list
  static Future<TransactionByProductionModel> getTransactionByProduction({required String id}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    var res = await http
        .get(Uri.parse("${AppConfig.TRANSACTION_BY_PRODUCTION_ID}$id"), headers: {"Authorization": "Bearer $token"});
    return TransactionByProductionModel.fromJson(jsonDecode(res.body));
  }

  //single production list
  static Future<SingleProductionTrx> getSingleTransactionByProduction({required String id}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    var res =
        await http.get(Uri.parse("${AppConfig.SINGLE_TRANSCATION}$id"), headers: {"Authorization": "Bearer $token"});
    return SingleProductionTrx.fromJson(jsonDecode(res.body));
  }
}

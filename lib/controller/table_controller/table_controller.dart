import 'dart:convert';

import 'package:crm/appConfig.dart';
import 'package:crm/model/table_molde/table_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TableController {
  //get table list
  static Future<TableListModel> getTableList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    var res = await http.get(Uri.parse(AppConfig.ALL_TABLE), headers: {"Authorization": "Bearer $token"});
    return TableListModel.fromJson(jsonDecode(res.body));
  }
}

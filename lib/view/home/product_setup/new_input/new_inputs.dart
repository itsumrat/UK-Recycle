import 'dart:convert';

import 'package:crm/controller/production_controller/production_controller.dart';
import 'package:crm/controller/table_controller/table_controller.dart';
import 'package:crm/controller/user_controller/userController.dart';
import 'package:crm/model/table_molde/table_list_model.dart';
import 'package:crm/model/user_model/allUserModel.dart';
import 'package:crm/utility/app_const.dart';
import 'package:crm/view/home/home.dart';
import 'package:crm/view/home/product_setup/new_input/showInputs.dart';
import 'package:crm/view_controller/appWidgets.dart';
import 'package:crm/view_controller/commonWidget.dart';
import 'package:crm/view_controller/detailsTextSideBySide.dart';
import 'package:crm/view_controller/loader.dart';
import 'package:crm/view_controller/snackbar_controller.dart';
import 'package:crm/widgets/app_title_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewInputs extends StatefulWidget {
  const NewInputs({super.key});

  @override
  State<NewInputs> createState() => _NewInputsState();
}

class _NewInputsState extends State<NewInputs> {
  final List<String> items = [
    'A',
    'B',
    'C',
    'D',
  ];
  var selectedValue;
  var selectUser;

  bool isLoading = false;
  final List<UserDatum> _allUser = [];
  _getUser() async {
    setState(() => isLoading = true);
    var res = await UserController.getAllUser();
    for (var i in res.data!) {
      setState(() {
        _allUser.add(i);
      });
    }
    setState(() => isLoading = false);
  }

  //table list
  final List<TableDatum> _tableList = [];
  _getTableList() async {
    setState(() => isLoading = true);
    var res = await TableController.getTableList();
    for (var i in res.data!) {
      setState(() {
        _tableList.add(i);
      });
    }
    setState(() => isLoading = false);
  }

  var userId, userName, date;

  getLogInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      userId = pref.getString("user_id")!;
      userName = pref.getString("user_name")!;
      date = AppConst.currentData();

      /// Vaiya login er api thik korte bolen tai hobe,,,
      /// uid te uid dite boliyen
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTableList();
    _getUser();
    getLogInfo();
  }

  @override
  Widget build(BuildContext context) {
    return AppWidget(
        appBarOnBack: () => Get.to(const Home()),
        appBarTitle: "Production Setup",
        body: isLoading
            ? const AppLoader()
            : SingleChildScrollView(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    const Center(
                      child: AppTitleText(text: "New Production"),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: Column(
                        children: [
                          AppSideBySIdeText(leftText: "Super Id: ", rightText: "$userId"),
                          const SizedBox(
                            height: 20,
                          ),
                          AppSideBySIdeText(leftText: "Name:  ", rightText: "$userName"),
                          // SizedBox(height: 20,),
                          // AppSideBySIdeText(leftText: "Production ID:  ", rightText: "Auto Create"),
                          const SizedBox(
                            height: 20,
                          ),
                          AppSideBySIdeText(leftText: "Date: ", rightText: "$date"),
                          // SizedBox(height: 20,),
                          // AppSideBySIdeText(leftText: "Time: ", rightText: "10:30 AM"),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  "Table no.",
                                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 15),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                flex: 2,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    hint: Text(
                                      'Select Table',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    items: _tableList
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item.id.toString(),
                                              child: Text(
                                                item.name!,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    value: selectedValue,
                                    onChanged: (String? value) {
                                      setState(() {
                                        selectedValue = value;
                                      });
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5)),
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      height: 60,
                                      width: 140,
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  "Assign to",
                                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 15),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                flex: 2,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    hint: Text(
                                      'Select User',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    items: _allUser
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item.id.toString(),
                                              child: Text(
                                                item.name!,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    value: selectUser,
                                    onChanged: (String? value) {
                                      setState(() {
                                        selectUser = value;
                                      });
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5)),
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      height: 60,
                                      width: 140,
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () => _createNewProduction(),
                              child: Container(
                                width: 180,
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: AppWidgets.buildLinearGradient(),
                                ),
                                child: Center(
                                  child: isAdding
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : const Text(
                                          "Input",
                                          style:
                                              TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 17),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ));
  }

  var isAdding = false;
  void _createNewProduction() async {
    setState(() => isAdding = true);
    print("dsafdsf=== ${AppConst.serverDateFormat(DateTime.now())}");
    print("dsafdsf=== $selectedValue");
    print("dsafdsf=== $selectUser");
    var res = await ProductionController.createNewProduction(
        production_date: AppConst.serverDateFormat(DateTime.now()),
        table: selectedValue.toString(),
        assigned_to: selectUser.toString());
    if (res.statusCode == 200) {
      Get.to(ShowNewlyCretaeProduction(
        pId: jsonDecode(res.body)["data"]["id"].toString(),
      ));
      AppSnackbar.appSnackbar("Production created success.", Colors.green, context);
    } else {
      AppSnackbar.appSnackbar("Something went wrong.", Colors.red, context);
    }
    setState(() => isAdding = false);
  }
}

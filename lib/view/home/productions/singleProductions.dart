import 'package:crm/controller/production_controller/production_controller.dart';
import 'package:crm/model/production_model/single_production_list.dart';
import 'package:crm/utility/app_const.dart';
import 'package:crm/view/home/productions/edit_translations.dart';
import 'package:crm/view/home/productions/productions.dart';
import 'package:crm/view/home/productions/singleProductionInput.dart';
import 'package:crm/view_controller/appWidgets.dart';
import 'package:crm/view_controller/commonWidget.dart';
import 'package:crm/view_controller/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/production_model/all_production_model.dart';
import '../../../widgets/app_boxes.dart';

class SingleProductions extends StatefulWidget {
  final AllProductionDatum? productionModel;
  final String id;
  const SingleProductions({super.key, this.productionModel, required this.id});

  @override
  State<SingleProductions> createState() => _SingleProductionsState();
}

class _SingleProductionsState extends State<SingleProductions> {
  Future<SingleProductionModel?>? getSingleProductionFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserInfo();
  }

  var user_name, user_id, role;
  void _getUserInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      user_id = pref.getString("user_id");
      user_name = pref.getString("user_name");
      role = pref.getString("role");
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppWidget(
      appBarTitle: "",
      appBarOnBack: () => Get.to(const Productoins()),
      body: FutureBuilder<SingleProductionModel?>(
          future: ProductionController.getSingleProduction(id: widget.id.toString()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: AppLoader(),
              );
            } else if (snapshot.hasData) {
              return SingleChildScrollView(
                padding: const EdgeInsets.only(left: 50, right: 50, bottom: 30),
                child: Column(
                  children: [
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    Center(
                      child: Text(
                        "Production:\n${snapshot.data!.data!.production!.productionIdString}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // AppSideBySIdeText(
                    //     leftText: "Date: ",
                    //     rightText: AppConfig.dateFormat(snapshot.data!.data!.production!.productionDate!)),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // AppSideBySIdeText(leftText: "User ID: ", rightText: "$user_id"),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // AppSideBySIdeText(leftText: "User Name: ", rightText: "$user_name"),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // AppSideBySIdeText(leftText: "Table No: ", rightText: "${widget.productionModel!.tables!.tableId}"),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // AppSideBySIdeText(
                    //     leftText: "Assigned to: ", rightText: "${widget.productionModel!.assignedTo!.name}"),
                    // const SizedBox(
                    //   height: 30,
                    // ),
                    const Center(
                      child: Text(
                        "Total Weight",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Text(
                        snapshot.data!.data!.weight.toString(),
                        style: const TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Center(
                      child: Text(
                        "KG",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: AppBox(
                        title: "Input",
                        onClick: () async {
                          await Get.to(SingleProductionInput(
                              grades: snapshot.data!.data!.grades, production: widget.productionModel));
                          setState(() {
                            getSingleProductionFuture =
                                ProductionController.getSingleProduction(id: widget.id.toString());
                          });
                        },
                        width: 180,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    role == AppConst.supervisorRole
                        ? Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () => Get.to(EditProductionsTranslation(
                                productionModel: widget.productionModel!,
                              )),
                              child: Container(
                                width: 180,
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: AppWidgets.buildLinearGradient(),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Edit Transaction",
                                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 17),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const Center()
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text("No data found."),
              );
            }
          }),
    );
  }
}

import 'package:crm/utility/app_const.dart';
import 'package:crm/view/home/product_setup/add_grade/add_grade.dart';
import 'package:crm/view/home/product_setup/new_input/new_inputs.dart';
import 'package:crm/view_controller/appWidgets.dart';
import 'package:crm/view_controller/commonWidget.dart';
import 'package:crm/widgets/app_boxes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home.dart';

class ProductSetup extends StatefulWidget {
  const ProductSetup({super.key});

  @override
  State<ProductSetup> createState() => _ProductSetupState();
}

class _ProductSetupState extends State<ProductSetup> {
  var role;
  getRol() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      role = pref.getString("role");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRol();
  }

  @override
  Widget build(BuildContext context) {
    return AppWidget(
        appBarTitle: "Production setup",
        appBarOnBack: () => Get.to(const Home()),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                role == AppConst.staffRole
                    ? const Center()
                    : Align(
                        alignment: Alignment.center,
                        child: AppBox(title: "New Input", onClick: () => Get.to(const NewInputs()), width: 180),
                      ),
                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () => Get.to(const AddGrade()),
                    child: Container(
                      width: 180,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: AppWidgets.buildLinearGradient(),
                      ),
                      child: const Center(
                        child: Text(
                          "Add Grade",
                          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                )
              ]),
        ));
  }
}

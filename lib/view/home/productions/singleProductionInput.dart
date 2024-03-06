import 'dart:convert';

import 'package:crm/controller/production_controller/production_controller.dart';
import 'package:crm/controller/production_setup/gradeController.dart';
import 'package:crm/model/delivery_model/grade_model/grade_model.dart';
import 'package:crm/model/production_model/single_production_list.dart';
import 'package:crm/view_controller/commonWidget.dart';
import 'package:crm/view_controller/snackbar_controller.dart';
import 'package:crm/widgets/app_title_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/production_model/all_production_model.dart';
import '../../../view_controller/appWidgets.dart';
import 'showProductionInput.dart';

class SingleProductionInput extends StatefulWidget {
  final List<Grade>? grades;
  final AllProductionDatum? production;
  final String? existingWeight;
  final String? existingGrade;
  final String? existingGradeId;
  final String? transactionID;
  const SingleProductionInput(
      {Key? key,
      this.grades,
      this.production,
      this.existingWeight,
      this.existingGrade,
      this.transactionID,
      this.existingGradeId})
      : super(key: key);

  @override
  State<SingleProductionInput> createState() => _SingleProductionInputState();
}

class _SingleProductionInputState extends State<SingleProductionInput> {
  var selectedValue;
  final _weight = TextEditingController();
  final List<GradeDatum> _gradeList = [];
  Future<GradeModel> getGrade() async {
    var getGradeFuture = await GradeController.getGradeList();
    for (var i in getGradeFuture.data!) {
      setState(() {
        _gradeList.add(i);
      });
    }
    return getGradeFuture;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGrade();
    if (widget.existingWeight != null) {
      _weight.text = widget.existingWeight!;
      selectedValue = widget.existingGradeId!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppWidget(
      appBarTitle: "Production ID: ${widget.production?.productionId}",
      appBarOnBack: () => Get.back(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: AppTitleText(
                text: "Transaction",
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Weight",
                    style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 15),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: TextFormField(
                  controller: _weight,
                  decoration: InputDecoration(
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      border: const OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: "KG"),
                )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Grade",
                    style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 15),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text(
                        widget.existingGrade ?? "Select One",
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: _gradeList
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
                        decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5)),
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
                //onTap: ()=>Get.to(ShowProductionsInputs()),
                onTap: () async {
                  widget.existingWeight != null ? _editProductionWeightGrade() : _addProductionWeightGrade();
                },
                child: Container(
                  width: 180,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: AppWidgets.buildLinearGradient(),
                  ),
                  child: Center(
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            widget.existingWeight != null ? "Edit" : "Input",
                            style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 17),
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            if (widget.existingWeight == null)
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  //onTap: ()=>Get.to(ShowProductionsInputs()),
                  onTap: () async {
                    _addProductionWeightGrade(shouldNavigate: false);
                  },
                  child: Container(
                    width: 180,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: AppWidgets.buildLinearGradient(),
                    ),
                    child: Center(
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              "Input More",
                              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 17),
                            ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  //bool
  bool isLoading = false;
  Future<void> _addProductionWeightGrade({bool shouldNavigate = true}) async {
    print("dafds");
    if (_weight.text.isNotEmpty && selectedValue != null) {
      setState(() => isLoading = true);
      var res = await ProductionController.addProductionTranscation(
          id: widget.production!.id.toString(), gread: selectedValue, weight: _weight.text);
      if (res.statusCode == 200) {
        AppSnackbar.appSnackbar("Production added success.", Colors.green, context);
        var data = jsonDecode(res.body)["data"];
        if (shouldNavigate) {
          Get.to(ShowProductionsInputs(
            transactionID: data["id"].toString(),
            date: data["created_at"],
            weight: data["weight"],
            grade: data["grade"],
            production: widget.production,
          ));
        } else {
          setState(() {
            _weight.text = "";
            selectedValue = null;
          });
        }
      }
      setState(() => isLoading = false);
    } else {
      //show error message
      AppSnackbar.appSnackbar("Weight or Grade must not be empty.", Colors.red, context);
    }
  }

  Future<void> _editProductionWeightGrade() async {
    print("dafds");
    if (_weight.text.isNotEmpty && selectedValue != null && widget.production!.id != null) {
      setState(() => isLoading = true);
      var res = await ProductionController.editProductionTranscation(
          id: widget.transactionID.toString(), gread: selectedValue, weight: _weight.text);
      print("edit: ${res.body}");
      if (res.statusCode == 200) {
        AppSnackbar.appSnackbar("Production edit success.", Colors.green, context);
        var data = jsonDecode(res.body)["data"];
        Get.to(ShowProductionsInputs(
          transactionID: widget.transactionID,
          date: data["created_at"],
          weight: data["weight"],
          grade: data["grade"],
          production: widget.production,
        ));
      }
      setState(() => isLoading = false);
    } else {
      //show error message
      AppSnackbar.appSnackbar("Weight or Grade or Production ID must not be empty.", Colors.red, context);
    }
  }
}

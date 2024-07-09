import 'dart:core';

import 'package:crm/controller/cage_controller/cage_controller.dart';
import 'package:crm/controller/delivery_controller%20/in_controller/delivery_type_controller.dart';
import 'package:crm/controller/delivery_controller%20/out_controller/delivery_out_controller.dart';
import 'package:crm/controller/user_controller/userController.dart';
import 'package:crm/model/cage_model/cage_model.dart';
import 'package:crm/model/delivery_model/in_model/delivery_model.dart';
import 'package:crm/model/delivery_model/in_model/product_category_model.dart';
import 'package:crm/model/delivery_model/out_model/existing_delivery_out_model.dart';
import 'package:crm/model/user_model/allUserModel.dart';
import 'package:crm/utility/app_const.dart';
import 'package:crm/view_controller/appWidgets.dart';
import 'package:crm/view_controller/commonWidget.dart';
import 'package:crm/view_controller/loader.dart';
import 'package:crm/view_controller/snackbar_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'single_existing_delivery.dart';

class CreateSingleTr extends StatefulWidget {
  final ExistingDeliveryOutDatum? existingDeliveryInDatum;
  final String? existingDeliveryId;

  const CreateSingleTr({
    super.key,
    this.existingDeliveryInDatum,
    this.existingDeliveryId,
  });

  @override
  State<CreateSingleTr> createState() => _CreateSingleTrState();
}

class _CreateSingleTrState extends State<CreateSingleTr> {
  //current data form app const
  var currentDate;

  final userIdTextController = TextEditingController();
  final dateTextController = TextEditingController();

  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  String? selectedDeliveryType;
  String? selectedProductCategory;
  CageDatum? selectedCageOn;
  String? selectUserName;

  Future<AllUserModel>? allUserFuture;
  final List<DeliveryDatum> _allDeliveryTypeList = [];
  final List<ProductCategoryDatum> _allProductCategoryList = [];
  //get delivery type list
  void _getDeliveryTypeList() async {
    var res = await DeliveryTypeController.getDeliveryType();
    for (var i in res.data!) {
      setState(() {
        _allDeliveryTypeList.add(i);
      });
    }
  }

  //get product category
  final List<CageDatum> _allCageList = [];

  void _getAllCageList() async {
    var res = await CageController.getCageNo();
    for (var i in res.data!) {
      setState(() {
        _allCageList.add(i);
      });
    }
  }

  final weight = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allUserFuture = UserController.getAllUser(); // get all user
    dateTextController.text = AppConst.currentData(); //get current date
    //_getDeliveryTypeList();
    _getAllCageList();

    print(
        " widget.existingDeliveryInDatum!.deliveryType.toString() == ${widget.existingDeliveryInDatum!.deliveryType.toString()}");
    print(
        " widget.existingDeliveryInDatum!.deliveryType.toString() == ${widget.existingDeliveryInDatum!.measurement!.id.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AppWidget(
      appBarTitle: "Delivery Out ID: ${widget.existingDeliveryInDatum!.deliveryOutId}",
      textSize: 20,
      appBarOnBack: () => Get.back(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            FutureBuilder<AllUserModel>(
                future: allUserFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: AppLoader(),
                    );
                  } else if (snapshot.hasData) {
                    return Column(
                      children: [
                        widget.existingDeliveryInDatum!.measurement!.name == "Cage"
                            ? Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      "Cage No",
                                      style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 15),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2<CageDatum>(
                                        isExpanded: true,
                                        hint: Text(
                                          'Select One',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Theme.of(context).hintColor,
                                          ),
                                        ),
                                        items: (_allCageList)
                                            .map((item) => DropdownMenuItem<CageDatum>(
                                                  value: item,
                                                  child: Text(
                                                    item.caseName!,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                        value: selectedCageOn,
                                        onChanged: (CageDatum? value) {
                                          setState(() {
                                            selectedCageOn = value;
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
                              )
                            : const Center(),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${widget.existingDeliveryInDatum!.measurement!.name}",
                                style: const TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 15),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                flex: 2,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: weight,
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey.shade200,
                                      filled: true,
                                      border: const OutlineInputBorder(borderSide: BorderSide.none),
                                      hintText: "Weight"),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        InkWell(
                          onTap: () => _createDeliveryInTranscation(),
                          child: Container(
                            width: 200,
                            height: 60,
                            decoration: BoxDecoration(
                                gradient: AppWidgets.buildLinearGradient(), borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: isAdding
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      "Input",
                                      style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white, fontSize: 16),
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () => _createDeliveryInTranscation(shouldNavigate: false),
                          child: Container(
                            width: 200,
                            height: 60,
                            decoration: BoxDecoration(
                                gradient: AppWidgets.buildLinearGradient(), borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: isAdding
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      "Input More",
                                      style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white, fontSize: 16),
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: Text("Check your internet connection."),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }

  bool isAdding = false;
  void _createDeliveryInTranscation({bool shouldNavigate = true}) async {
    setState(() => isAdding = true);
    if (weight.text.isEmpty) {
      AppSnackbar.appSnackbar("Input field must not be empty.", Colors.red, context);
    } else {
      if (widget.existingDeliveryInDatum!.measurement!.name == "Cage" && selectedCageOn == null) {
        AppSnackbar.appSnackbar("Select Cage no.", Colors.red, context);
      } else {
        var res = await DeliveryOutController.addTranscations(
            weight: weight.text,
            deliveryTypeId: widget.existingDeliveryId.toString(),
            measurementId: widget.existingDeliveryInDatum!.measurement!.id.toString(),
            cageNo: selectedCageOn);
        if (res.statusCode == 200) {
          AppSnackbar.appSnackbar("Transaction created success.", Colors.green, context);

          //Get.to(ShowNewlyCreateDeliveryOutSingleTrx(trxId: jsonDecode(res.body)["data"]["id"].toString(), existingDeliveryInDatum: widget.existingDeliveryInDatum, existingDeliveryId: widget.existingDeliveryId,));
          if (shouldNavigate) {
            Get.to(
              SingleExistingDeliveriesOuts(
                existingDeliveryOutDatum: widget.existingDeliveryInDatum,
                existingDeliveryId: widget.existingDeliveryId.toString(),
              ),
            );
          } else {
            weight.clear();
          }
        } else {
          AppSnackbar.appSnackbar("Something went wrong.", Colors.red, context);
        }
      }
    }

    setState(() => isAdding = false);
  }
}

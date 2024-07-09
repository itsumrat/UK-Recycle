// ignore_for_file: use_build_context_synchronously

import 'dart:core';

import 'package:crm/controller/cage_controller/cage_controller.dart';
import 'package:crm/controller/delivery_controller%20/in_controller/exstingDeliveryController.dart';
import 'package:crm/controller/user_controller/userController.dart';
import 'package:crm/model/cage_model/cage_model.dart';
import 'package:crm/model/delivery_model/in_model/deliveryin_model.dart';
import 'package:crm/model/user_model/allUserModel.dart';
import 'package:crm/utility/app_const.dart';
import 'package:crm/view/home/dalivery/deliveryIn/existingDeliveries/singleExistingDeliveries.dart';
import 'package:crm/view_controller/appWidgets.dart';
import 'package:crm/view_controller/commonWidget.dart';
import 'package:crm/view_controller/loader.dart';
import 'package:crm/view_controller/snackbar_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNewCageBox extends StatefulWidget {
  final ExistingDeliveryInDatum? existingDeliveryInDatum;
  final String? deliveryId;

  const CreateNewCageBox({super.key, this.existingDeliveryInDatum, this.deliveryId});

  @override
  State<CreateNewCageBox> createState() => _CreateNewCageBoxState();
}

class _CreateNewCageBoxState extends State<CreateNewCageBox> {
  //current data form app const

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
  // final List<DeliveryDatum> _allDeliveryTypeList = [];
  // final List<ProductCategoryDatum> _allProductCategoryList = [];
  //get delivery type list
  // void _getDeliveryTypeList() async {
  //   var res = await DeliveryTypeController.getDeliveryType();
  //   for (var i in res.data!) {
  //     setState(() {
  //       _allDeliveryTypeList.add(i);
  //     });
  //   }
  // }

  // //get product category
  // void _getProductCategoryList() async {
  //   var res = await DeliveryInProductCategoryController.getProductCategory();
  //   for (var i in res!.data!) {
  //     setState(() {
  //       _allProductCategoryList.add(i);
  //     });
  //   }
  // }

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
    super.initState();
    allUserFuture = UserController.getAllUser(); // get all user
    dateTextController.text = AppConst.currentData(); //get current date
    // _getDeliveryTypeList();
    // _getProductCategoryList();
    _getAllCageList();
  }

  @override
  Widget build(BuildContext context) {
    return AppWidget(
      appBarTitle: "Deliveries In ID: ${widget.existingDeliveryInDatum!.deliveryInId}",
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
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Text("User Name",
                        //         style: TextStyle(
                        //             fontWeight: FontWeight.w400,
                        //             color: Colors.black,
                        //             fontSize: 15
                        //         ),
                        //       ),
                        //     ),
                        //     SizedBox(width: 20,),
                        //     Expanded(
                        //       flex: 2,
                        //       child: DropdownButtonHideUnderline(
                        //         child: DropdownButton2<String>(
                        //           isExpanded: true,
                        //           hint: Text(
                        //             'Select One',
                        //             style: TextStyle(
                        //               fontSize: 16,
                        //               color: Theme.of(context).hintColor,
                        //             ),
                        //           ),
                        //           items: (snapshot.data!.data)?.map((item)  => DropdownMenuItem<String>(
                        //             value: item.userId,
                        //             child: Text(
                        //               item.name!,
                        //               style: const TextStyle(
                        //                 fontSize: 14,
                        //               ),
                        //             ),
                        //           ))
                        //               .toList(),
                        //           value: selectUserName,
                        //           onChanged: (String? value) {
                        //             setState(() {
                        //               selectUserName = value; //selected the user name
                        //               userIdTextController.text = value!;
                        //             });
                        //           },
                        //           buttonStyleData:  ButtonStyleData(
                        //             decoration: BoxDecoration(
                        //                 color: Colors.grey.shade200,
                        //                 borderRadius: BorderRadius.circular(5)
                        //             ),
                        //             padding: EdgeInsets.symmetric(horizontal: 16),
                        //             height: 60,
                        //             width: 140,
                        //           ),
                        //           menuItemStyleData: const MenuItemStyleData(
                        //             height: 40,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //
                        //   ],
                        // ),
                        // SizedBox(height: 20,),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Text("User ID",
                        //         style: TextStyle(
                        //             fontWeight: FontWeight.w400,
                        //             color: Colors.black,
                        //             fontSize: 15
                        //         ),
                        //       ),
                        //     ),
                        //     SizedBox(width: 20,),
                        //     Expanded(
                        //         flex: 2,
                        //         child: TextFormField(
                        //           controller: userIdTextController,
                        //           decoration: InputDecoration(
                        //               fillColor: Colors.grey.shade200,
                        //               filled: true,
                        //               border: OutlineInputBorder(
                        //                   borderSide: BorderSide.none
                        //               ),
                        //               hintText: "User ID 02"
                        //           ),
                        //         )
                        //     )
                        //   ],
                        // ),
                        // SizedBox(height: 20,),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Text("Date",
                        //         style: TextStyle(
                        //             fontWeight: FontWeight.w400,
                        //             color: Colors.black,
                        //             fontSize: 15
                        //         ),
                        //       ),
                        //     ),
                        //     SizedBox(width: 20,),
                        //     Expanded(
                        //         flex: 2,
                        //         child: TextFormField(
                        //           controller: dateTextController,
                        //           decoration: InputDecoration(
                        //               fillColor: Colors.grey.shade200,
                        //               filled: true,
                        //               border: OutlineInputBorder(
                        //                   borderSide: BorderSide.none
                        //               ),
                        //               hintText: "Auto Fill up"
                        //           ),
                        //         )
                        //     )
                        //   ],
                        // ),
                        // SizedBox(height: 20,),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Text("Delivery Type",
                        //         style: TextStyle(
                        //             fontWeight: FontWeight.w400,
                        //             color: Colors.black,
                        //             fontSize: 15
                        //         ),
                        //       ),
                        //     ),
                        //     SizedBox(width: 20,),
                        //     Expanded(
                        //       flex: 2,
                        //       child: DropdownButtonHideUnderline(
                        //         child: DropdownButton2<String>(
                        //           isExpanded: true,
                        //           hint: Text(
                        //             'Select One',
                        //             style: TextStyle(
                        //               fontSize: 16,
                        //               color: Theme.of(context).hintColor,
                        //             ),
                        //           ),
                        //           items: (_allDeliveryTypeList)?.map((item) => DropdownMenuItem<String>(
                        //             value: item.id.toString(),
                        //             child: Text(
                        //               item.name!,
                        //               style: const TextStyle(
                        //                 fontSize: 14,
                        //               ),
                        //             ),
                        //           ))
                        //               .toList(),
                        //           value: selectedDeliveryType,
                        //           onChanged: (String? value) {
                        //             setState(() {
                        //               selectedDeliveryType = value;
                        //             });
                        //             print("value -==${value}");
                        //           },
                        //           buttonStyleData:  ButtonStyleData(
                        //             decoration: BoxDecoration(
                        //                 color: Colors.grey.shade200,
                        //                 borderRadius: BorderRadius.circular(5)
                        //             ),
                        //             padding: EdgeInsets.symmetric(horizontal: 16),
                        //             height: 60,
                        //             width: 140,
                        //           ),
                        //           menuItemStyleData: const MenuItemStyleData(
                        //             height: 40,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //
                        //   ],
                        // ),
                        // SizedBox(height: 20,),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Text("Product Category",
                        //         style: TextStyle(
                        //             fontWeight: FontWeight.w400,
                        //             color: Colors.black,
                        //             fontSize: 15
                        //         ),
                        //       ),
                        //     ),
                        //     SizedBox(width: 20,),
                        //     Expanded(
                        //       flex: 2,
                        //       child: DropdownButtonHideUnderline(
                        //         child: DropdownButton2<String>(
                        //           isExpanded: true,
                        //           hint: Text(
                        //             'Select One',
                        //             style: TextStyle(
                        //               fontSize: 16,
                        //               color: Theme.of(context).hintColor,
                        //             ),
                        //           ),
                        //           items:(_allProductCategoryList)?.map((item) => DropdownMenuItem<String>(
                        //             value: item.id.toString(),
                        //             child: Text(
                        //               item.name!,
                        //               style: const TextStyle(
                        //                 fontSize: 14,
                        //               ),
                        //             ),
                        //           ))
                        //               .toList(),
                        //           value: selectedProductCategory,
                        //           onChanged: (String? value) {
                        //             setState(() {
                        //               selectedProductCategory = value;
                        //             });
                        //           },
                        //           buttonStyleData:  ButtonStyleData(
                        //             decoration: BoxDecoration(
                        //                 color: Colors.grey.shade200,
                        //                 borderRadius: BorderRadius.circular(5)
                        //             ),
                        //             padding: EdgeInsets.symmetric(horizontal: 16),
                        //             height: 60,
                        //             width: 140,
                        //           ),
                        //           menuItemStyleData: const MenuItemStyleData(
                        //             height: 40,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //
                        //   ],
                        // ),
                        // SizedBox(height: 20,),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Text("Cage No",
                        //         style: TextStyle(
                        //             fontWeight: FontWeight.w400,
                        //             color: Colors.black,
                        //             fontSize: 15
                        //         ),
                        //       ),
                        //     ),
                        //     SizedBox(width: 20,),
                        //     Expanded(
                        //       flex: 2,
                        //       child: DropdownButtonHideUnderline(
                        //         child: DropdownButton2<String>(
                        //           isExpanded: true,
                        //           hint: Text(
                        //             'Select One',
                        //             style: TextStyle(
                        //               fontSize: 16,
                        //               color: Theme.of(context).hintColor,
                        //             ),
                        //           ),
                        //           items: items
                        //               .map((String item) => DropdownMenuItem<String>(
                        //             value: item,
                        //             child: Text(
                        //               item,
                        //               style: const TextStyle(
                        //                 fontSize: 14,
                        //               ),
                        //             ),
                        //           ))
                        //               .toList(),
                        //           value: selectedCageOn,
                        //           onChanged: (String? value) {
                        //             setState(() {
                        //               selectedCageOn = value;
                        //             });
                        //           },
                        //           buttonStyleData:  ButtonStyleData(
                        //             decoration: BoxDecoration(
                        //                 color: Colors.grey.shade200,
                        //                 borderRadius: BorderRadius.circular(5)
                        //             ),
                        //             padding: EdgeInsets.symmetric(horizontal: 16),
                        //             height: 60,
                        //             width: 140,
                        //           ),
                        //           menuItemStyleData: const MenuItemStyleData(
                        //             height: 40,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //
                        //   ],
                        // ),
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
                                      hintText: "${widget.existingDeliveryInDatum!.measurement!.name}"),
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
  bool isAddingMore = false;
  void _createDeliveryInTranscation({bool shouldNavigate = true}) async {
    if (widget.existingDeliveryInDatum!.measurement!.name == "Cage" && selectedCageOn == null) {
      AppSnackbar.appSnackbar("Please select cage.", Colors.red, context);
      return;
    }
    if (weight.text.isEmpty) {
      AppSnackbar.appSnackbar("Please enter weight.", Colors.red, context);
      return;
    }
    setState(() => isAdding = true);
    var res = await DeliveryInController.addTranscations(
        weight: weight.text,
        deliveryTypeId: widget.deliveryId.toString(),
        measurementId: widget.existingDeliveryInDatum!.measurement!.id.toString(),
        cageNo: selectedCageOn);
    if (res.statusCode == 200) {
      AppSnackbar.appSnackbar("Transaction created success.", Colors.green, context);
      //Get.to(SingleExistingDeliveries(existingDeliveryInDatum: widget.existingDeliveryInDatum, existingDeliveryId: widget.deliveryId.toString(),));
      if (shouldNavigate) {
        Get.to(
          SingleExistingDeliveries(
            existingDeliveryInDatum: widget.existingDeliveryInDatum,
            existingDeliveryId: widget.deliveryId.toString(),
          ),
        );
      } else {
        weight.clear();
      }
    } else {
      AppSnackbar.appSnackbar("Something went wrong.", Colors.red, context);
    }
    setState(() => isAdding = false);
  }
}

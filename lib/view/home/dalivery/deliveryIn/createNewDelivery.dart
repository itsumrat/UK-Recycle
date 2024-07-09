import 'dart:convert';

import 'package:crm/controller/delivery_controller%20/in_controller/delivery_controller.dart';
import 'package:crm/controller/delivery_controller%20/in_controller/delivery_type_controller.dart';
import 'package:crm/controller/delivery_controller%20/in_controller/product_category_controller.dart';
import 'package:crm/controller/delivery_controller%20/out_controller/delivery_out_controller.dart';
import 'package:crm/controller/user_controller/userController.dart';
import 'package:crm/model/delivery_model/in_model/delivery_model.dart';
import 'package:crm/model/delivery_model/in_model/product_category_model.dart';
import 'package:crm/model/mesumarment_model/mesumarmentModel.dart';
import 'package:crm/model/user_model/allUserModel.dart';
import 'package:crm/model/user_model/all_coustomer.dart';
import 'package:crm/utility/app_const.dart';
import 'package:crm/view_controller/appWidgets.dart';
import 'package:crm/view_controller/commonWidget.dart';
import 'package:crm/view_controller/loader.dart';
import 'package:crm/view_controller/snackbar_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../model/user_model/all_supplier_model.dart';
import '../delivery_out/show_new_create_deliveryout.dart';
import 'existingDeliveries/add_new/cageBox/show_cage_box.dart';

class AddNewDelivery extends StatefulWidget {
  final bool isDeliveryOut;

  const AddNewDelivery({super.key, this.isDeliveryOut = true});

  @override
  State<AddNewDelivery> createState() => _AddNewDeliveryState();
}

class _AddNewDeliveryState extends State<AddNewDelivery> {
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  String? selectedSupplierId;
  String? selectedCustomerId;
  String? selectedMeasurementId;
  String? selectedDeliveryType;
  String? selectedProductCategory;
  String? selectedAssignTo;

  final userId = TextEditingController();
  final user_name = TextEditingController();
  final date = TextEditingController();

  bool isLoading = false;
  final List<DeliveryDatum> _deliveryTypeList = [];
  void _getDeliveryType() async {
    setState(() => isLoading = true);
    var res = await DeliveryTypeController.getDeliveryType();
    for (var i in res.data!) {
      setState(() {
        _deliveryTypeList.add(i);
      });
    }
    setState(() => isLoading = false);
  }

  final List<ProductCategoryDatum> _productCategoryList = [];
  void _getProductCategory() async {
    setState(() => isLoading = true);
    var res = await DeliveryInProductCategoryController.getProductCategory();
    for (var i in res!.data!) {
      setState(() {
        _productCategoryList.add(i);
      });
    }
    setState(() => isLoading = false);
  }

  //all supplier
  final List<SupplierDatum> _allSupplier = [];
  void _getAllSupplier() async {
    setState(() => isLoading = true);
    var res = await UserController.getAllSupplier();
    for (var i in res.data!) {
      setState(() {
        _allSupplier.add(i);
      });
    }
    setState(() => isLoading = false);
  }

  //all customers
  final List<AllCustomerDatum> _allCustomer = [];
  void _getAllCustomer() async {
    setState(() => isLoading = true);
    var res = await UserController.getAllCustomer();
    for (var i in res.data!) {
      setState(() {
        _allCustomer.add(i);
      });
    }
    setState(() => isLoading = false);
  }

  //all customers
  final List<UserDatum> _allUser = [];
  void _getAllUser() async {
    setState(() => isLoading = true);
    var res = await UserController.getAllUser();
    for (var i in res.data!) {
      setState(() {
        _allUser.add(i);
      });
    }
    setState(() => isLoading = false);
  }

  final List<MeasurmentDatum> _allMeasurmentsList = [];
  void _getAllMeasurments() async {
    setState(() => isLoading = true);
    var res = await DeliveryController.getAllMeasurements();
    for (var i in res.data!) {
      setState(() {
        _allMeasurmentsList.add(i);
      });
    }
    setState(() => isLoading = false);
  }

  //get role
  var role;
  getRole() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      role = pref.getString("role");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storeUserId();
    _getDeliveryType();
    _getProductCategory();
    _getAllSupplier();
    _getAllMeasurments();
    _getAllCustomer();
    _getAllUser();
    getRole();
  }

  storeUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      userId.text = pref.getString("user_id").toString();
      user_name.text = pref.getString("user_name").toString();
      date.text = AppConst.currentData();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AppWidget(
      appBarTitle: widget.isDeliveryOut ? "New Delivery In Create" : "New Delivery Out Create",
      appBarOnBack: () => Get.back(),
      body: isLoading
          ? const AppLoader()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * .05,
                  ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Text("User ID",
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.w400,
                  //           color: Colors.black,
                  //           fontSize: 15
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(width: 20,),
                  //     Expanded(
                  //       flex: 2,
                  //       child: TextFormField(
                  //         controller: userId,
                  //         readOnly: true,
                  //         decoration: InputDecoration(
                  //           fillColor: Colors.grey.shade200,
                  //           filled: true,
                  //           border: OutlineInputBorder(
                  //             borderSide: BorderSide.none
                  //           ),
                  //           hintText: "Auto Fill up"
                  //         ),
                  //       )
                  //     )
                  //   ],
                  // ),
                  //
                  // SizedBox(height: 20,),
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
                  //         flex: 2,
                  //         child: TextFormField(
                  //           controller: user_name,
                  //           readOnly: true,
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
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Date",
                          style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 15),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: date,
                            readOnly: true,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade200,
                                filled: true,
                                border: const OutlineInputBorder(borderSide: BorderSide.none),
                                hintText: "Auto Fill up"),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Measurements",
                          style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 15),
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
                              'Select Item',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: _allMeasurmentsList
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
                            value: selectedMeasurementId,
                            onChanged: (String? value) {
                              setState(() {
                                selectedMeasurementId = value;
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              decoration:
                                  BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5)),
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
                  widget.isDeliveryOut != true
                      ? Row(
                          children: [
                            const Expanded(
                              child: Text(
                                "Customer Name",
                                style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 15),
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
                                    'Select Item',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: _allCustomer
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
                                  value: selectedCustomerId,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedCustomerId = value;
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
                      : Row(
                          children: [
                            const Expanded(
                              child: Text(
                                "Suppliers Name",
                                style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 15),
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
                                    'Select Item',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: _allSupplier
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
                                  value: selectedSupplierId,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedSupplierId = value;
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
                          "Delivery Type",
                          style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 15),
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
                              'Select Item',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: _deliveryTypeList
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
                            value: selectedDeliveryType,
                            onChanged: (String? value) {
                              setState(() {
                                selectedDeliveryType = value;
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              decoration:
                                  BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5)),
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
                          "Product Category",
                          style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 15),
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
                              'Select Item',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: _productCategoryList
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
                            value: selectedProductCategory,
                            onChanged: (String? value) {
                              setState(() {
                                selectedProductCategory = value;
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              decoration:
                                  BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5)),
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
                  role == AppConst.staffRole
                      ? Row(
                          children: [
                            const Expanded(
                              child: Text(
                                "User Name",
                                style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 15),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                flex: 2,
                                child: TextFormField(
                                  controller: user_name,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey.shade200,
                                      filled: true,
                                      border: const OutlineInputBorder(borderSide: BorderSide.none),
                                      hintText: "Auto Fill up"),
                                ))
                          ],
                        )
                      : Row(
                          children: [
                            const Expanded(
                              child: Text(
                                "Assign to",
                                style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 15),
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
                                    'Select one',
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
                                  value: selectedAssignTo,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedAssignTo = value;
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
                    height: 70,
                  ),
                  InkWell(
                    onTap: () => widget.isDeliveryOut ? _addNewDeliveryId() : _addNewDeliveryOut(),
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
                                "Create",
                                style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white, fontSize: 16),
                              ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  //add new delivery in
  bool isAdding = false;
  void _addNewDeliveryId() async {
    setState(() => isAdding = true);
    var res = await DeliveryController.addNeDelivery(
        deliveryTypeID: selectedDeliveryType!,
        productCategoryId: selectedProductCategory!,
        suplierId: selectedSupplierId!,
        measurementTypeId: selectedMeasurementId!,
        assign_to: role == AppConst.staffRole ? userId.text : selectedAssignTo!);
    if (res.statusCode == 200) {
      AppSnackbar.appSnackbar("New delivery in created success.", Colors.green, context);
      Get.to(ShowCageBox(
        deliveryId: jsonDecode(res.body)["data"]["id"].toString(),
      ));
    } else {
      AppSnackbar.appSnackbar("Something went wrong.", Colors.red, context);
    }
    setState(() => isAdding = false);
  }

  //add new delivery out
  void _addNewDeliveryOut() async {
    setState(() => isAdding = true);
    var res = await DeliveryOutController.addNewDeliveryOut(
        category_id: selectedProductCategory!,
        measurement_type: selectedMeasurementId!,
        delivery_type: selectedDeliveryType!,
        customer_id: selectedCustomerId!,
        assign_id: role == AppConst.staffRole ? userId.text : selectedAssignTo!);
    if (res.statusCode == 200) {
      AppSnackbar.appSnackbar("New delivery Out created success.", Colors.green, context);
      Get.to(ShowNewlyCreateDeliveryOut(
        deliveryId: jsonDecode(res.body)["data"]["id"].toString(),
      ));
    } else {
      AppSnackbar.appSnackbar("Something went wrong.", Colors.red, context);
    }
    setState(() => isAdding = false);
  }
}

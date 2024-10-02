import 'package:crm/controller/cage_controller/cage_controller.dart';
import 'package:crm/controller/delivery_controller%20/in_controller/exstingDeliveryController.dart';
import 'package:crm/model/cage_model/cage_model.dart';
import 'package:crm/model/delivery_model/in_model/deliveryin_model.dart';
import 'package:crm/model/delivery_model/in_model/single_deliveryin_transaction_model.dart';
import 'package:crm/utility/app_const.dart';
import 'package:crm/view/home/dalivery/deliveryIn/existingDeliveries/transactions.dart';
import 'package:crm/view_controller/appWidgets.dart';
import 'package:crm/view_controller/commonWidget.dart';
import 'package:crm/view_controller/snackbar_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../model/delivery_model/in_model/single_deliveryin_model.dart';

class EditTranscation extends StatefulWidget {
  final Transaction singleTransaction;
  final SingleDeliveryInModel singleDelivery;
  final ExistingDeliveryInDatum? existingDeliveryInDatum;
  final CageDatum? existingCage;

  const EditTranscation(
      {super.key,
      required this.singleTransaction,
      required this.singleDelivery,
      this.existingDeliveryInDatum,
      this.existingCage});

  @override
  State<EditTranscation> createState() => _EditTranscationState();
}

class _EditTranscationState extends State<EditTranscation> {
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  String? selectedValue;
  CageDatum? selectedCageOn;
  String? selectedDeliveryType;
  String? selectedProductCategory;

  final userName = TextEditingController();
  final userId = TextEditingController();
  final date = TextEditingController();
  final deliveryType = TextEditingController();
  final productCategory = TextEditingController();
  final cageNo = TextEditingController();
  final weight = TextEditingController();
  final cageWeight = TextEditingController();

  final List<CageDatum> _allCageList = [];
  //get product category
  void _getAllCageList() async {
    var res = await CageController.getCageNo();
    for (var i in res.data!) {
      setState(() {
        _allCageList.add(i);
      });
    }

    selectedCageOn = _allCageList.firstWhereOrNull((element) => element.id == widget.existingCage?.id);
  }

  @override
  void initState() {
    super.initState();
    // _getDeliveryTypeFuture();
    // _getProductCategoryFuture();
    _getAllCageList();
    userName.text = widget.singleTransaction.user?.name?.toString() ?? '';
    userId.text = widget.singleTransaction.user?.id?.toString() ?? '';
    date.text = AppConst.formetData(widget.singleTransaction.date);
    weight.text = ((widget.singleTransaction.productWeight ?? 0) +
            (widget.singleTransaction.weight ?? widget.existingCage?.weight ?? 0))
        .toStringAsFixed(2);
    cageWeight.text = (widget.singleTransaction.weight ?? 0).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return AppWidget(
      appBarTitle:
          "Transaction ID: ${widget.singleDelivery.data!.delivery!.deliveryInId}/${widget.singleTransaction.id}",
      textSize: 20,
      appBarOnBack: () => Get.back(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            widget.singleDelivery.data!.delivery!.measurement!.name == "Cage"
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
                        child: AbsorbPointer(
                          absorbing: widget.existingCage != null,
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
                      ),
                    ],
                  )
                : const Center(),
            const SizedBox(
              height: 20,
            ),
            if (widget.singleDelivery.data!.delivery!.measurement!.name == "Cage") ...[
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Cage Weight",
                      style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: cageWeight,
                      readOnly: selectedCageOn?.caseName != 'Free Weight',
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        border: const OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: "0 KG",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${widget.singleDelivery.data!.delivery!.measurement!.name == "Cage" && widget.singleDelivery.data!.delivery!.measurement!.name == "KG" ? "Weight" : widget.singleDelivery.data!.delivery!.measurement!.name}",
                    style: const TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 15),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: weight,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      border: const OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: "00 ",
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 70,
            ),
            InkWell(
              onTap: () => editTransition(),
              child: Container(
                width: 200,
                height: 60,
                decoration:
                    BoxDecoration(gradient: AppWidgets.buildLinearGradient(), borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: isEditingLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Save",
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

  bool isEditingLoading = false;
  editTransition() async {
    if (weight.text.isEmpty) {
      AppSnackbar.appSnackbar("Please enter weight.", Colors.red, context);
      return;
    } else if (selectedCageOn == null && widget.singleDelivery.data!.delivery!.measurement!.name == "Cage") {
      AppSnackbar.appSnackbar("Please select cage.", Colors.red, context);
      return;
    }
    setState(() => isEditingLoading = true);
    var res = await DeliveryInController.editTranscations(
      case_no: selectedCageOn,
      weight: weight.text,
      id: widget.singleTransaction.id.toString(),
      cageWeight: cageWeight.text,
    );
    if (res.statusCode == 200) {
      Get.to(Transactions(
        existingDeliveryInDatum: widget.existingDeliveryInDatum,
        singleDeliveryInModel: widget.singleDelivery,
      ));
      AppSnackbar.appSnackbar("Edit success.", Colors.green, context);
    } else {
      AppSnackbar.appSnackbar("Something went wrong.", Colors.red, context);
    }
    setState(() => isEditingLoading = false);
  }
}

import 'package:crm/controller/delivery_controller%20/in_controller/exstingDeliveryController.dart';
import 'package:crm/model/delivery_model/in_model/single_deliveryin_model.dart';
import 'package:crm/model/delivery_model/out_model/existing_delivery_out_model.dart';
import 'package:crm/utility/utility.dart';
import 'package:crm/view/home/dalivery/deliveryIn/existingDeliveries/add_new/cageBox/create_cage_box.dart';
import 'package:crm/view/home/dalivery/deliveryIn/existingDeliveries/existingDeliveries.dart';
import 'package:crm/view_controller/appWidgets.dart';
import 'package:crm/view_controller/commonWidget.dart';
import 'package:crm/view_controller/loader.dart';
import 'package:crm/view_controller/snackbar_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../model/delivery_model/in_model/deliveryin_model.dart';
import 'transactions.dart';

class SingleExistingDeliveries extends StatefulWidget {
  final ExistingDeliveryInDatum? existingDeliveryInDatum;
  final ExistingDeliveryOutDatum? existingDeliveryOutDatum;
  final String? existingDeliveryId;
  const SingleExistingDeliveries(
      {super.key, this.existingDeliveryInDatum, this.existingDeliveryId, this.existingDeliveryOutDatum});

  @override
  State<SingleExistingDeliveries> createState() => _SingleExistingDeliveriesState();
}

class _SingleExistingDeliveriesState extends State<SingleExistingDeliveries> {
  Future<SingleDeliveryInModel>? _singleDelivery;
  var inputFormat = DateFormat("dd-MM-yyyy");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _singleDelivery = DeliveryInController.getSingleDeliveryIn(id: widget.existingDeliveryId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return AppWidget(
      appBarOnBack: () => Get.to(const ExistingDeliveries()),
      appBarTitle:
          "${widget.existingDeliveryInDatum!.deliveryInId}/${inputFormat.format(widget.existingDeliveryInDatum!.date!)}/${widget.existingDeliveryInDatum!.supplier!.name}-${widget.existingDeliveryInDatum!.measurement!.name}",
      textSize: 15,
      body: FutureBuilder<SingleDeliveryInModel>(
          future: _singleDelivery,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: AppLoader(),
              );
            } else if (snapshot.hasData) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Center(
                      child: Text(
                        "Total Weight",
                        style: TextStyle(fontSize: 15, color: AppColor.textColor, fontWeight: FontWeight.w300),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        "${snapshot.data!.data!.productWeight?.toStringAsFixed(2) ?? "0.00"} ",
                        style: const TextStyle(fontSize: 30, color: AppColor.black, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        "${snapshot.data!.data!.delivery!.measurement!.name}",
                        style: const TextStyle(fontSize: 15, color: AppColor.textColor, fontWeight: FontWeight.w300),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    //// transactions
                    InkWell(
                      onTap: () => Get.to(
                        () => Transactions(
                          singleDeliveryInModel: snapshot.data!,
                          existingDeliveryInDatum: widget.existingDeliveryInDatum,
                        ),
                      ),
                      child: Container(
                        width: 200,
                        height: 250,
                        decoration: BoxDecoration(
                            gradient: AppWidgets.buildLinearGradient(), borderRadius: BorderRadius.circular(10)),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.shirt,
                              size: 50,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Transactions",
                              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () async {
                        await Get.to(CreateNewCageBox(
                          existingDeliveryInDatum: widget.existingDeliveryInDatum,
                          deliveryId: snapshot.data!.data!.delivery!.id.toString(),
                        ));

                        setState(() {
                          _singleDelivery =
                              DeliveryInController.getSingleDeliveryIn(id: widget.existingDeliveryId.toString());
                        });
                      },
                      child: Container(
                        width: 200,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: AppWidgets.buildLinearGradient(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "Add New",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // SizedBox(height: 20,),
                    // InkWell(
                    //   onTap: ()=>Get.to(EditTransactions()),
                    //   child: Container(
                    //     width: 200,
                    //     height: 60,
                    //     decoration: BoxDecoration(
                    //         gradient: AppWidgets.buildLinearGradient(),
                    //         borderRadius: BorderRadius.circular(10)
                    //     ),
                    //     child: Center(
                    //       child: Text("Edit",
                    //         style: TextStyle(
                    //             fontWeight: FontWeight.w400,
                    //             color: Colors.white,
                    //             fontSize: 16
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () => _deleteDeliveryIn(),
                      child: Container(
                        width: 200,
                        height: 60,
                        decoration: BoxDecoration(
                            gradient: AppWidgets.buildRedLinearGradient(), borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Delete",
                                  style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white, fontSize: 16),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            } else {
              return const Center(
                child: Text("Something went wrong."),
              );
            }
          }),
    );
  }

  bool isLoading = false;
  void _deleteDeliveryIn() async {
    setState(() => isLoading = true);
    var res = await DeliveryInController.deleteDeliveryIn(id: widget.existingDeliveryInDatum!.id!.toString());
    if (res.statusCode == 200) {
      Get.to(const ExistingDeliveries());
      AppSnackbar.appSnackbar("Delivery in deleted success.", Colors.green, context);
    } else {
      AppSnackbar.appSnackbar("Something went wrong.", Colors.red, context);
    }
    setState(() => isLoading = false);
  }
}

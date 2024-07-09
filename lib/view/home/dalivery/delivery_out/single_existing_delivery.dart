import 'package:crm/controller/delivery_controller%20/out_controller/delivery_out_controller.dart';
import 'package:crm/model/delivery_model/out_model/SingleExistingDeliveryOutModel.dart';
import 'package:crm/model/delivery_model/out_model/existing_delivery_out_model.dart';
import 'package:crm/utility/utility.dart';
import 'package:crm/view/home/dalivery/delivery_out/existing_delivery_out_list.dart';
import 'package:crm/view/home/dalivery/delivery_out/single_delivery_outs_tr_list.dart';
import 'package:crm/view/home/dalivery/delivery_out/single_exsiting_tr_create.dart';
import 'package:crm/view_controller/appWidgets.dart';
import 'package:crm/view_controller/commonWidget.dart';
import 'package:crm/view_controller/loader.dart';
import 'package:crm/view_controller/snackbar_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../model/delivery_model/in_model/deliveryin_model.dart';

class SingleExistingDeliveriesOuts extends StatefulWidget {
  final ExistingDeliveryInDatum? existingDeliveryInDatum;
  final ExistingDeliveryOutDatum? existingDeliveryOutDatum;
  final String? existingDeliveryId;
  const SingleExistingDeliveriesOuts(
      {super.key, this.existingDeliveryInDatum, this.existingDeliveryId, this.existingDeliveryOutDatum});

  @override
  State<SingleExistingDeliveriesOuts> createState() => _SingleExistingDeliveriesOutsState();
}

class _SingleExistingDeliveriesOutsState extends State<SingleExistingDeliveriesOuts> {
  Future<SingleExistingDeliveryOutModel>? _singleDelivery;
  var inputFormat = DateFormat("dd-MM-yyyy");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _singleDelivery = DeliveryOutController.getSingleDeliveryOut(id: widget.existingDeliveryId.toString());

    print("widget!.existingDeliveryId.toString()  ${widget.existingDeliveryId.toString()}");
  }

  Future<void> _refresh() async {
    _singleDelivery = DeliveryOutController.getSingleDeliveryOut(id: widget.existingDeliveryId.toString());
    await _singleDelivery;
  }

  @override
  Widget build(BuildContext context) {
    return AppWidget(
      appBarOnBack: () => Get.to(const ExistingDeliveriesOuts()),
      appBarTitle:
          "${widget.existingDeliveryOutDatum?.deliveryOutId}/${inputFormat.format(widget.existingDeliveryOutDatum?.date ?? DateTime.now())}/${widget.existingDeliveryOutDatum?.measurement?.name}",
      textSize: 15,
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<SingleExistingDeliveryOutModel>(
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
                          "${snapshot.data!.data!.weight ?? "0"} ",
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
                        onTap: () => Get.to(DeliveryOutsTransactionsList(
                          singleDeliveryOutModel: snapshot.data!,
                          existingDeliveryOutDatum: widget.existingDeliveryOutDatum,
                        )),
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
                          await Get.to(CreateSingleTr(
                            existingDeliveryInDatum: widget.existingDeliveryOutDatum,
                            existingDeliveryId: snapshot.data!.data!.delivery!.id.toString(),
                          ));
                          setState(() {
                            _singleDelivery =
                                DeliveryOutController.getSingleDeliveryOut(id: widget.existingDeliveryId.toString());
                          });
                        },
                        child: Container(
                          width: 200,
                          height: 60,
                          decoration: BoxDecoration(
                              gradient: AppWidgets.buildLinearGradient(), borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Text(
                              "Add New",
                              style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white, fontSize: 16),
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
              } else {
                return const Center(
                  child: Text("Something went wrong."),
                );
              }
            }),
      ),
    );
  }

  bool isLoading = false;
  void _deleteDeliveryIn() async {
    setState(() => isLoading = true);
    var res = await DeliveryOutController.deleteDeliveryOut(id: widget.existingDeliveryInDatum!.id!.toString());
    if (res.statusCode == 200) {
      Get.to(const ExistingDeliveriesOuts());
      AppSnackbar.appSnackbar("Delivery Out deleted success.", Colors.green, context);
    } else {
      AppSnackbar.appSnackbar("Something went wrong.", Colors.red, context);
    }
    setState(() => isLoading = false);
  }
}

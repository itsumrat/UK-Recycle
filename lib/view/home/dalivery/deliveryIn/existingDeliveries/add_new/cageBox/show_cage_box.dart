import 'package:crm/controller/delivery_controller%20/in_controller/exstingDeliveryController.dart';
import 'package:crm/model/delivery_model/in_model/deliveryin_model.dart';
import 'package:crm/model/delivery_model/in_model/single_deliveryin_model.dart';
import 'package:crm/utility/app_const.dart';
import 'package:crm/view/home/dalivery/deliveryIn/deliveryIn.dart';
import 'package:crm/view/home/dalivery/deliveryIn/existingDeliveries/singleExistingDeliveries.dart';
import 'package:crm/view_controller/appWidgets.dart';
import 'package:crm/view_controller/commonWidget.dart';
import 'package:crm/view_controller/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ShowCageBox extends StatefulWidget {
  final String? deliveryId;
  const ShowCageBox({super.key, this.deliveryId});

  @override
  State<ShowCageBox> createState() => _ShowCageBoxState();
}

class _ShowCageBoxState extends State<ShowCageBox> {
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  String? selectedValue;
  Future<SingleDeliveryInModel>? _getSingleDeliveryIn;
  @override
  void initState() {
    super.initState();
    print("delivery id === ${widget.deliveryId.toString()}");
    _getSingleDeliveryIn = DeliveryInController.getSingleDeliveryIn(id: widget.deliveryId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return AppWidget(
      appBarTitle: "NEW Delivery In Created",
      appBarOnBack: () => Get.back(),
      body: FutureBuilder<SingleDeliveryInModel>(
          future: _getSingleDeliveryIn,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: AppLoader(),
              );
            } else if (snapshot.hasData) {
              return SingleChildScrollView(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 50, top: 20),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "${snapshot.data!.data!.delivery!.deliveryInId}"
                        "/${DateFormat('dd-MM-yyyy').format(snapshot.data!.data!.delivery!.date!)}"
                        "/${snapshot.data!.data!.delivery!.supplier!.name}"
                        "/${snapshot.data!.data!.delivery!.measurement!.name}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "User ID: ",
                            style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 15),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            flex: 2,
                            child: Text(
                              "${snapshot.data!.data!.delivery!.user!.uid}",
                              style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 18),
                            ))
                      ],
                    ),

                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "User Name: ",
                            style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 15),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            flex: 2,
                            child: Text(
                              "${snapshot.data!.data!.delivery!.user!.name}",
                              style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 18),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Delivery In ID",
                            style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 15),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            flex: 2,
                            child: Text(
                              "${snapshot.data!.data!.delivery!.deliveryInId}",
                              style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 18),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Date: ",
                            style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 15),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            flex: 2,
                            child: Text(
                              AppConst.formetData("${snapshot.data!.data!.delivery!.date}"),
                              style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 18),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),

                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Suppliers Name: ",
                            style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 15),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            flex: 2,
                            child: Text(
                              "${snapshot.data!.data!.delivery!.supplier!.name}",
                              style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 18),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Measurement Type: ",
                            style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 15),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            flex: 2,
                            child: Text(
                              "${snapshot.data!.data!.delivery!.measurement!.name}",
                              style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 18),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Product Type: ",
                            style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black, fontSize: 15),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            flex: 2,
                            child: Text(
                              "${snapshot.data!.data!.delivery!.categories!.name}",
                              style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.w400, fontSize: 18),
                            ))
                      ],
                    ),

                    // snapshot.data!.data!.delivery!.measurement!.name == "Cage" ? Column(
                    //   children: [
                    //     SizedBox(height: 40,),
                    //     Row(
                    //       children: [
                    //         Expanded(
                    //           child: Text("Cage No: ",
                    //             style: TextStyle(
                    //                 fontWeight: FontWeight.w400,
                    //                 color: Colors.black,
                    //                 fontSize: 15
                    //             ),
                    //           ),
                    //         ),
                    //         SizedBox(width: 20,),
                    //         Expanded(
                    //             flex: 2,
                    //             child: Text("${snapshot.data!.data!.delivery!.caseId}",
                    //               style: TextStyle(
                    //                   color: Colors.black54,
                    //                   fontWeight: FontWeight.w400,
                    //                   fontSize: 18
                    //               ),
                    //             )
                    //         )
                    //       ],
                    //     ),
                    //   ],
                    // ) : Center(),

                    // SizedBox(height: 70,),
                    // InkWell(
                    //   onTap: ()=>Get.to(ExistingDeliveries(isIn: true)),
                    //   child: Container(
                    //     width: 200,
                    //     height: 60,
                    //     decoration: BoxDecoration(
                    //         gradient: AppWidgets.buildLinearGradient(),
                    //         borderRadius: BorderRadius.circular(10)
                    //     ),
                    //     child: Center(
                    //       child: Text("Add More",
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
                      onTap: () => Get.to(const DeliveryIn()),
                      child: Container(
                        width: 200,
                        height: 60,
                        decoration: BoxDecoration(
                            gradient: AppWidgets.buildLinearGradient(), borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Text(
                            "Back",
                            style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FutureBuilder<ExsitingDeliveryinModel>(
                      future: DeliveryInController.getExstingDeliveryIn(),
                      builder: (context, AsyncSnapshot<ExsitingDeliveryinModel> snapshot) {
                        if (snapshot.hasData) {
                          return InkWell(
                            onTap: () => Get.to(SingleExistingDeliveries(
                              existingDeliveryId: snapshot.data!.data!
                                  .where((element) => element.id.toString() == widget.deliveryId)
                                  .first
                                  .id
                                  .toString(),
                              existingDeliveryInDatum: snapshot.data!.data!
                                  .where((element) => element.id.toString() == widget.deliveryId)
                                  .first,
                            )),
                            child: Container(
                              width: 200,
                              height: 60,
                              decoration: BoxDecoration(
                                  gradient: AppWidgets.buildLinearGradient(), borderRadius: BorderRadius.circular(10)),
                              child: const Center(
                                child: Text(
                                  "Transactions",
                                  style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 70,
                    ),
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



import 'package:crm/controller/delivery_controller%20/out_controller/delivery_out_controller.dart';
import 'package:crm/model/delivery_model/out_model/existing_delivery_out_model.dart';
import 'package:crm/model/delivery_model/out_model/single_delveryout_trx_momdel.dart';
import 'package:crm/utility/app_const.dart';
import 'package:crm/view/home/dalivery/delivery_out/single_existing_delivery.dart';
import 'package:crm/view/home/dalivery/delivery_out/single_exsiting_tr_create.dart';
import 'package:crm/view_controller/appWidgets.dart';
import 'package:crm/view_controller/commonWidget.dart';
import 'package:crm/view_controller/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ShowNewlyCreateDeliveryOutSingleTrx extends StatefulWidget {
  final String? trxId;
  final ExistingDeliveryOutDatum?  existingDeliveryInDatum;
  final String? existingDeliveryId;

  const ShowNewlyCreateDeliveryOutSingleTrx({super.key, this.trxId, this.existingDeliveryInDatum, this.existingDeliveryId});

  @override
  State<ShowNewlyCreateDeliveryOutSingleTrx> createState() => _ShowNewlyCreateDeliveryOutSingleTrxState();
}

class _ShowNewlyCreateDeliveryOutSingleTrxState extends State<ShowNewlyCreateDeliveryOutSingleTrx> {

  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  String? selectedValue;
  Future<SingleDeliveryOutTrxModel>? _getSingleDeliveryOut;
  @override
  void initState() {
    super.initState();
    print("delivery id === ${widget.trxId.toString()}");
    _getSingleDeliveryOut = DeliveryOutController.getSingleDeliveryOutTrx(id: widget.trxId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return AppWidget(
      appBarTitle: "NEW Deliveries Out Created",
      appBarOnBack: ()=>Get.back(),
      body:  FutureBuilder<SingleDeliveryOutTrxModel>(
          future: _getSingleDeliveryOut,
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child:  AppLoader(),);
            }else if(snapshot.hasData){
              return SingleChildScrollView(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 50, top: 20),
                child: Column(
                  children: [
                    Center(
                      child: Text("New UD Create ${widget.existingDeliveryInDatum!.deliveryOutId}/${widget.trxId}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    Row(
                      children: [
                        const Expanded(
                          child: Text("User ID: ",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: 15
                            ),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        Expanded(
                            flex: 2,
                            child: Text("${snapshot.data!.data!.user!.id}",
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18
                              ),
                            )
                        )
                      ],
                    ),

                    const SizedBox(height: 40,),
                    Row(
                      children: [
                        const Expanded(
                          child: Text("User Name: ",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: 15
                            ),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        Expanded(
                            flex: 2,
                            child: Text("${snapshot.data!.data!.user!.name}",
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18
                              ),
                            )
                        )
                      ],
                    ),
                    const SizedBox(height: 40,),
                    Row(
                      children: [
                        const Expanded(
                          child: Text("TRX ID",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: 15
                            ),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        Expanded(
                            flex: 2,
                            child: Text("${widget.trxId}",
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18
                              ),
                            )
                        )
                      ],
                    ),
                    const SizedBox(height: 40,),
                    Row(
                      children: [
                        const Expanded(
                          child: Text("Date: ",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: 15
                            ),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        Expanded(
                            flex: 2,
                            child: Text(AppConst.formetData("${snapshot.data!.data!.date}"),
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18
                              ),
                            )
                        )
                      ],
                    ),
                    const SizedBox(height: 40,),

                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Text("Suppliers Name: ",
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
                    //         child: Text("${snapshot.data!.data!.delivery!.customer!.name}",
                    //           style: TextStyle(
                    //               color: Colors.black54,
                    //               fontWeight: FontWeight.w400,
                    //               fontSize: 18
                    //           ),
                    //         )
                    //     )
                    //   ],
                    // ),
                    // SizedBox(height: 40,),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Text("Delivery Type: ",
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
                    //         child: Text("${snapshot.data!.data!.delivery!.deliveryType}",
                    //           style: TextStyle(
                    //               color: Colors.black54,
                    //               fontWeight: FontWeight.w400,
                    //               fontSize: 18
                    //           ),
                    //         )
                    //     )
                    //   ],
                    // ),
                    // SizedBox(height: 40,),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Text("Product Type: ",
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
                    //         child: Text("${snapshot.data!.data!.delivery!.categories!.name}",
                    //           style: TextStyle(
                    //               color: Colors.black54,
                    //               fontWeight: FontWeight.w400,
                    //               fontSize: 18
                    //           ),
                    //         )
                    //     )
                    //   ],
                    // ),
                    //
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
                    // SizedBox(height: 40,),
                    Row(
                      children: [
                        const Expanded(
                          child: Text("Weight: ",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: 15
                            ),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        Expanded(
                            flex: 2,
                            child: Text("${snapshot.data!.data!.weight} ${snapshot.data!.data!.measurements!.name}",
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18
                              ),
                            )
                        )
                      ],
                    ),

                    const SizedBox(height: 70,),
                    InkWell(
                      onTap: ()=>Get.to(CreateSingleTr(existingDeliveryInDatum: widget.existingDeliveryInDatum, existingDeliveryId:widget.existingDeliveryId)),
                      child: Container(
                        width: 200,
                        height: 60,
                        decoration: BoxDecoration(
                            gradient: AppWidgets.buildLinearGradient(),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: const Center(
                          child: Text("Add More",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontSize: 16
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    InkWell(
                      onTap: ()=>Get.to(SingleExistingDeliveriesOuts(existingDeliveryOutDatum: widget.existingDeliveryInDatum, existingDeliveryId: widget.existingDeliveryId,)),
                      child: Container(
                        width: 200,
                        height: 60,
                        decoration: BoxDecoration(
                            gradient: AppWidgets.buildLinearGradient(),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: const Center(
                          child: Text("Back",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontSize: 16
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 70,),
                  ],
                ),
              );
            }else{
              return const Center(child: Text("No data found."),);
            }

          }
      ),
    );

  }
}

import 'package:crm/controller/delivery_controller%20/in_controller/exstingDeliveryController.dart';
import 'package:crm/model/delivery_model/in_model/deliveryin_model.dart';
import 'package:crm/model/delivery_model/in_model/single_deliveryin_model.dart';
import 'package:crm/model/delivery_model/in_model/single_deliveryin_transaction_model.dart';
import 'package:crm/utility/app_const.dart';
import 'package:crm/utility/utility.dart';
import 'package:crm/view/home/dalivery/deliveryIn/existingDeliveries/editTransactiopns.dart';
import 'package:crm/view_controller/commonWidget.dart';
import 'package:crm/view_controller/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'singleExistingDeliveries.dart';

class Transactions extends StatefulWidget {
  final SingleDeliveryInModel? singleDeliveryInModel;
  final ExistingDeliveryInDatum? existingDeliveryInDatum;

  const Transactions({super.key, this.singleDeliveryInModel, this.existingDeliveryInDatum});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  final List<Transaction> _transcationList = [];
  final List<Transaction> _searchTranscationList = [];
  String query = "";
  bool isLoading = false;
  var role;
  getTranscationList() async {
    setState(() => isLoading = true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      role = pref.getString("role");
    });
    var res = await DeliveryInController.getSingleExistingDeliveryInTransactions(
        id: widget.singleDeliveryInModel!.data!.delivery!.id.toString());
    for (var i in res.data!.transaction!) {
      setState(() {
        _transcationList.add(i);
      });
    }
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTranscationList();
    print("existingDeliveryInDatum tr  === ${widget.existingDeliveryInDatum}");
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AppWidget(
      //appBarOnBack: ()=>Get.back(),
      appBarOnBack: () => Get.to(SingleExistingDeliveries(
        existingDeliveryInDatum: widget.existingDeliveryInDatum,
        existingDeliveryId: widget.singleDeliveryInModel!.data!.delivery!.id.toString(),
      )),
      appBarTitle: "Transaction",
      body: isLoading
          ? const Center(
              child: AppLoader(),
            )
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                        onChanged: (v) {
                          // _search(v.toString());
                          setState(() {
                            query = v;
                          });
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            border: const OutlineInputBorder(borderSide: BorderSide.none),
                            hintText: "Search"),
                      )),
                      // const SizedBox(
                      //   width: 15,
                      // ),
                      // Container(
                      //   width: 100,
                      //   height: 60,
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(5), gradient: AppWidgets.buildLinearGradient()),
                      //   child: const Center(
                      //     child: Text(
                      //       "Search",
                      //       style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child:
                          // _searchTranscationList.isNotEmpty
                          // ? ListView.builder(
                          //     itemCount: _searchTranscationList.length,
                          //     itemBuilder: (_, index) {
                          //       final transaction = _searchTranscationList[index];
                          //       return InkWell(
                          //         //onTap: ()=>Get.to(SingleExistingDeliveries()),
                          //         child: Container(
                          //           //height: 50,
                          //           padding: const EdgeInsets.all(15),
                          //           child: Row(
                          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //             children: [
                          //               SizedBox(
                          //                 width: size.width * .30,
                          //                 child: Text(
                          //                   "${widget.singleDeliveryInModel!.data!.delivery!.deliveryInId}/${_searchTranscationList[index].id}",
                          //                   style: const TextStyle(
                          //                       fontWeight: FontWeight.w400, color: Colors.black, fontSize: 16),
                          //                 ),
                          //               ),
                          //               SizedBox(
                          //                 child: Container(
                          //                   padding: const EdgeInsets.all(4),
                          //                   decoration: BoxDecoration(
                          //                       color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5)),
                          //                   child: Text(
                          //                     transaction.category?.name ?? 'N\\A',
                          //                     style: const TextStyle(
                          //                         fontWeight: FontWeight.w400, color: AppColor.textColor, fontSize: 16),
                          //                   ),
                          //                 ),
                          //               ),
                          //               const SizedBox(
                          //                 width: 10,
                          //               ),
                          //               SizedBox(
                          //                 child: Container(
                          //                   padding: const EdgeInsets.all(4),
                          //                   decoration: BoxDecoration(
                          //                       color: Colors.grey.shade300, borderRadius: BorderRadius.circular(5)),
                          //                   child: Text(
                          //                     "${_searchTranscationList[index].productWeight} ${widget.singleDeliveryInModel!.data!.delivery!.measurement!.name}",
                          //                     style: const TextStyle(
                          //                         fontWeight: FontWeight.w400, color: Colors.black, fontSize: 16),
                          //                   ),
                          //                 ),
                          //               ),
                          //               const SizedBox(
                          //                 width: 10,
                          //               ),
                          //               SizedBox(
                          //                 child: InkWell(
                          //                   onTap: () => Get.to(EditTranscation(
                          //                     existingDeliveryInDatum: widget.existingDeliveryInDatum,
                          //                     singleDelivery: widget.singleDeliveryInModel!,
                          //                     singleTransaction: _searchTranscationList[index],
                          //                   )),
                          //                   child: Container(
                          //                     padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
                          //                     decoration: BoxDecoration(
                          //                         color: AppColor.mainColor, borderRadius: BorderRadius.circular(5)),
                          //                     child: const Text(
                          //                       "Edit",
                          //                       style: TextStyle(
                          //                           fontWeight: FontWeight.w400, color: Colors.white, fontSize: 16),
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       );
                          //     })
                          // :
                          _transcationList.isEmpty
                              ? const Center(child: Text("No data found."))
                              : ListView.builder(
                                  itemCount: _transcationList.length,
                                  itemBuilder: (_, index) {
                                    final transaction = _transcationList[index];
                                    if (!"${widget.singleDeliveryInModel!.data!.delivery!.deliveryInId}/${index + 1}/${transaction.category?.name ?? 'N\\A'}/${_transcationList[index].productWeight?.toStringAsFixed(2)}"
                                        .toLowerCase()
                                        .contains(query.toLowerCase())) {
                                      return const SizedBox();
                                    }
                                    return InkWell(
                                      //onTap: ()=>Get.to(SingleExistingDeliveries()),
                                      child: Container(
                                        //height: 50,
                                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: size.width * .28,
                                              child: Text(
                                                "${widget.singleDeliveryInModel!.data!.delivery!.deliveryInId}/${index + 1}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w400, color: Colors.black, fontSize: 16),
                                              ),
                                            ),
                                            SizedBox(
                                              child: Container(
                                                padding: const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade200,
                                                    borderRadius: BorderRadius.circular(5)),
                                                child: Text(
                                                  transaction.category?.name ?? 'N\\A',
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      color: AppColor.textColor,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            SizedBox(
                                              child: Container(
                                                padding: const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade300,
                                                    borderRadius: BorderRadius.circular(5)),
                                                child: Text(
                                                  "${_transcationList[index].productWeight?.toStringAsFixed(2)} ${widget.singleDeliveryInModel!.data!.delivery!.measurement!.name}",
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.w400, color: Colors.black, fontSize: 16),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            role == AppConst.supervisorRole
                                                ? SizedBox(
                                                    child: InkWell(
                                                      onTap: () => Get.to(EditTranscation(
                                                        existingDeliveryInDatum: widget.existingDeliveryInDatum,
                                                        singleDelivery: widget.singleDeliveryInModel!,
                                                        singleTransaction: _transcationList[index],
                                                        existingCage: _transcationList[index].cage,
                                                      )),
                                                      child: Container(
                                                        padding: const EdgeInsets.only(
                                                            left: 15, right: 15, bottom: 5, top: 5),
                                                        decoration: BoxDecoration(
                                                            color: AppColor.mainColor,
                                                            borderRadius: BorderRadius.circular(5)),
                                                        child: const Text(
                                                          "Edit",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w400,
                                                              color: Colors.white,
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : const Center(),
                                          ],
                                        ),
                                      ),
                                    );
                                  })),
                ],
              ),
            ),
    );
  }

  //search list
  void _search(String query) {
    print("query == $query");
    setState(() {
      _searchTranscationList.clear();
    });
    if (query.isNotEmpty) {
      for (var i in _transcationList) {
        if (i.id!.toString().contains(query)) {
          print("i === ${i.id}");
          setState(() {
            _searchTranscationList.add(i);
          });
        }
      }
    } else {
      setState(() {
        _searchTranscationList.clear();
      });
    }

    print("_searchTranscationList   == ${_searchTranscationList[0].id}");

    print("_searchTranscationList ${_searchTranscationList.length}");
  }
}

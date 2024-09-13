import 'package:crm/controller/delivery_controller%20/out_controller/delivery_out_controller.dart';
import 'package:crm/model/delivery_model/out_model/SingleExistingDeliveryOutModel.dart';
import 'package:crm/model/delivery_model/out_model/deliveryOutTsListModel.dart';
import 'package:crm/model/delivery_model/out_model/existing_delivery_out_model.dart';
import 'package:crm/utility/app_const.dart';
import 'package:crm/utility/utility.dart';
import 'package:crm/view/home/dalivery/delivery_out/edit_single_tr.dart';
import 'package:crm/view/home/dalivery/delivery_out/single_existing_delivery.dart';
import 'package:crm/view_controller/appWidgets.dart';
import 'package:crm/view_controller/commonWidget.dart';
import 'package:crm/view_controller/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeliveryOutsTransactionsList extends StatefulWidget {
  final SingleExistingDeliveryOutModel? singleDeliveryOutModel;
  final ExistingDeliveryOutDatum? existingDeliveryOutDatum;

  const DeliveryOutsTransactionsList({super.key, this.singleDeliveryOutModel, this.existingDeliveryOutDatum});

  @override
  State<DeliveryOutsTransactionsList> createState() => _DeliveryOutsTransactionsListState();
}

class _DeliveryOutsTransactionsListState extends State<DeliveryOutsTransactionsList> {
  final List<Transaction> _transcationList = [];
  final List<Transaction> _searchTranscationList = [];
  bool isLoading = false;
  var role;
  getTranscationList() async {
    setState(() => isLoading = true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      role = pref.getString("role");
    });
    var res = await DeliveryOutController.getSingleDeliveryOutTrList(
        id: widget.singleDeliveryOutModel!.data!.delivery!.id.toString());
    for (var i in res.data!.transaction!) {
      setState(() {
        _transcationList.add(i);
      });
    }
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    getTranscationList();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AppWidget(
      //appBarOnBack: ()=>Get.back(),
      appBarOnBack: () => Get.to(SingleExistingDeliveriesOuts(
        existingDeliveryOutDatum: widget.existingDeliveryOutDatum,
        existingDeliveryId: widget.singleDeliveryOutModel!.data!.delivery!.id.toString(),
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
                            _search(v.toLowerCase());
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            border: const OutlineInputBorder(borderSide: BorderSide.none),
                            hintText: "Search",
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Container(
                        width: 100,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5), gradient: AppWidgets.buildLinearGradient()),
                        child: const Center(
                          child: Text(
                            "Search",
                            style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: _searchTranscationList.isNotEmpty
                        ? ListView.builder(
                            itemCount: _searchTranscationList.length,
                            itemBuilder: (_, index) {
                              final transaction = _searchTranscationList[index];
                              return InkWell(
                                //onTap: ()=>Get.to(SingleExistingDeliveries()),
                                child: Container(
                                  //height: 50,
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: size.width * .30,
                                        child: Text(
                                          "${widget.singleDeliveryOutModel!.data!.delivery!.deliveryOutId}/${_searchTranscationList[index].id}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400, color: Colors.black, fontSize: 16),
                                        ),
                                      ),
                                      SizedBox(
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5)),
                                          child: Text(
                                            transaction.category?.name ?? 'N\\A',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400, color: AppColor.textColor, fontSize: 16),
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
                                              color: Colors.grey.shade300, borderRadius: BorderRadius.circular(5)),
                                          child: Text(
                                            "${_searchTranscationList[index].weight} ${widget.singleDeliveryOutModel!.data!.delivery!.measurement!.name}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400, color: Colors.black, fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        child: InkWell(
                                          onTap: () => Get.to(EditDeliveryOutTranscation(
                                            existingDeliveryOutDatum: widget.existingDeliveryOutDatum,
                                            singleDelivery: widget.singleDeliveryOutModel!,
                                            singleTransaction: _searchTranscationList[index],
                                          )),
                                          child: Container(
                                            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
                                            decoration: BoxDecoration(
                                                color: AppColor.mainColor, borderRadius: BorderRadius.circular(5)),
                                            child: const Text(
                                              "Edit",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400, color: Colors.white, fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            })
                        : _transcationList.isEmpty
                            ? const Center(
                                child: Text("No Transaction Found."),
                              )
                            : ListView.builder(
                                itemCount: _transcationList.length,
                                itemBuilder: (_, index) {
                                  final transaction = _transcationList[index];
                                  return InkWell(
                                    //onTap: ()=>Get.to(SingleExistingDeliveries()),
                                    child: Container(
                                      //height: 50,
                                      padding: const EdgeInsets.all(15),
                                      child: FittedBox(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: size.width * .30,
                                              child: Text(
                                                "${widget.singleDeliveryOutModel!.data!.delivery!.deliveryOutId}/${_transcationList[index].id}",
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
                                                  "${_transcationList[index].productWeight} ${widget.singleDeliveryOutModel!.data!.delivery!.measurement!.name}",
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
                                                      onTap: () => Get.to(EditDeliveryOutTranscation(
                                                        existingDeliveryOutDatum: widget.existingDeliveryOutDatum,
                                                        singleDelivery: widget.singleDeliveryOutModel!,
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
                                    ),
                                  );
                                },
                              ),
                  ),
                ],
              ),
            ),
    );
  }

  //search list
  void _search(String query) {
    print("query == $query");
    _searchTranscationList.clear();
    if (query.isNotEmpty) {
      for (var i in _transcationList) {
        if (i.id!.toString().contains(query)) {
          setState(() {
            _searchTranscationList.add(i);
          });
        }
      }
    }

    print("_searchTranscationList ${_searchTranscationList.length}");
  }
}

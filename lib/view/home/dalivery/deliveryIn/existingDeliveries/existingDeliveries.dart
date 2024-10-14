import 'package:crm/controller/delivery_controller%20/in_controller/exstingDeliveryController.dart';
import 'package:crm/utility/utility.dart';
import 'package:crm/view/home/dalivery/deliveryIn/deliveryIn.dart';
import 'package:crm/view/home/dalivery/deliveryIn/existingDeliveries/singleExistingDeliveries.dart';
import 'package:crm/view_controller/commonWidget.dart';
import 'package:crm/view_controller/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../model/delivery_model/in_model/deliveryin_model.dart';

enum ListFilter { today, all }

class ExistingDeliveries extends StatefulWidget {
  final bool? isIn;
  const ExistingDeliveries({super.key, this.isIn = true});

  @override
  State<ExistingDeliveries> createState() => _ExistingDeliveriesState();
}

class _ExistingDeliveriesState extends State<ExistingDeliveries> {
  var inputFormat = DateFormat("dd-MM-yyyy");
  var filter = ListFilter.today;
  String query = "";

  @override
  void initState() {
    super.initState();
    _getExstingData();
  }

  @override
  Widget build(BuildContext context) {
    return AppWidget(
      appBarOnBack: () => Get.to(const DeliveryIn()),
      appBarTitle: "Delivery ${widget.isIn! ? "In" : "Out"}",
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onChanged: (v) {
                      // _search(v.toLowerCase());
                      setState(() {
                        query = v;
                      });
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      border: const OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: "Search",
                    ),
                  ),
                ),
                // const SizedBox(
                //   width: 15,
                // ),
                // Container(
                //   width: 100,
                //   height: 60,
                //   decoration:
                //       BoxDecoration(borderRadius: BorderRadius.circular(5), gradient: AppWidgets.buildLinearGradient()),
                //   child: const Center(
                //     child: Text(
                //       "Search",
                //       style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
                //     ),
                //   ),
                // ),
                const SizedBox(
                  width: 15,
                ),
                PopupMenuButton(
                  child: Row(
                    children: [
                      Text(
                        filter == ListFilter.today ? "Today" : "All",
                        style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Icon(
                        Icons.filter_alt,
                        size: 30,
                      ),
                    ],
                  ),
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        value: ListFilter.today,
                        child: Text("Today"),
                      ),
                      const PopupMenuItem(
                        value: ListFilter.all,
                        child: Text("All"),
                      ),
                    ];
                  },
                  onSelected: (ListFilter value) {
                    setState(() {
                      filter = value;
                    });
                    _getExstingData();
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: isLoading
                  ? const AppLoader()
                  // : _searchExistingDeliveryInList.isNotEmpty
                  //     ? ListView.builder(
                  //         itemCount: _searchExistingDeliveryInList.length,
                  //         itemBuilder: (_, index) {
                  //           var data = _searchExistingDeliveryInList[index];
                  //           return InkWell(
                  //             onTap: () => Get.to(SingleExistingDeliveries(
                  //               existingDeliveryInDatum: data,
                  //               existingDeliveryId: data.id.toString(),
                  //             )),
                  //             child: Container(
                  //               //height: 50,
                  //               padding: const EdgeInsets.all(20),
                  //               decoration: BoxDecoration(
                  //                   //borderRadius: BorderRadius.circular(5),
                  //                   border: Border(
                  //                 top: const BorderSide(width: 1, color: AppColor.borderColor),
                  //                 left: const BorderSide(width: 1, color: AppColor.borderColor),
                  //                 right: const BorderSide(width: 1, color: AppColor.borderColor),
                  //                 bottom: _searchExistingDeliveryInList.length == 1
                  //                     ? const BorderSide(width: 1, color: AppColor.borderColor)
                  //                     : const BorderSide(width: 0, color: AppColor.white),
                  //               )),
                  //               child: Text(
                  //                 "${data.deliveryInId}/${inputFormat.format(data.date!)}/${data.supplier!.name}/${data.measurement!.name}",
                  //                 style:
                  //                     const TextStyle(fontWeight: FontWeight.w500, color: Colors.black54, fontSize: 16),
                  //               ),
                  //             ),
                  //           );
                  //         })
                  : ListView.builder(
                      itemCount: _existingDeliveryInList.length,
                      itemBuilder: (_, index) {
                        var data = _existingDeliveryInList[index];
                        if (!"${data.deliveryInId}/${inputFormat.format(data.date!)}/${data.supplier?.name}/${data.measurement!.name}"
                            .toLowerCase()
                            .contains(query.toLowerCase())) {
                          return const SizedBox();
                        }
                        return InkWell(
                          onTap: () => Get.to(
                            SingleExistingDeliveries(
                              existingDeliveryInDatum: data,
                              existingDeliveryId: data.id.toString(),
                            ),
                          ),
                          child: Container(
                            //height: 50,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                //borderRadius: BorderRadius.circular(5),
                                border: Border(
                              top: const BorderSide(width: 1, color: AppColor.borderColor),
                              left: const BorderSide(width: 1, color: AppColor.borderColor),
                              right: const BorderSide(width: 1, color: AppColor.borderColor),
                              bottom: _existingDeliveryInList.length != 1
                                  ? const BorderSide(width: 1, color: AppColor.borderColor)
                                  : const BorderSide(width: 0, color: AppColor.white),
                            )),
                            child: Text(
                              "${data.deliveryInId}/${inputFormat.format(data.date!)}/${data.supplier?.name}/${data.measurement!.name}",
                              style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black54, fontSize: 16),
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

  //===== existing data
  bool isLoading = true;
  final List<ExistingDeliveryInDatum> _existingDeliveryInList = [];
  final List<ExistingDeliveryInDatum> _searchExistingDeliveryInList = [];
  void _getExstingData() async {
    _existingDeliveryInList.clear();
    _searchExistingDeliveryInList.clear();

    setState(() => isLoading = true);
    if (widget.isIn!) {
      //check if its from Delivery in screen, then run this block of code.
      try {
        var res = await DeliveryInController.getExstingDeliveryIn();
        for (var i in res.data!) {
          _existingDeliveryInList.add(i);
        }
        if (filter == ListFilter.today) {
          _existingDeliveryInList.removeWhere((element) => element.date?.day != DateTime.now().day);
        }
        setState(() => isLoading = false);
      } catch (e) {
        print("existing delivery in response error $e}");
        setState(() => isLoading = false);
      }
    } else {
      //otherwise this one.
    }
  }

  //search list
  void _search(String query) {
    print("query == $query");
    _searchExistingDeliveryInList.clear();
    if (query.isNotEmpty) {
      for (var i in _existingDeliveryInList) {
        if (i.deliveryInId!.toLowerCase().contains(query)) {
          setState(() {
            _searchExistingDeliveryInList.add(i);
          });
        }
      }

      if (filter == ListFilter.today) {
        _searchExistingDeliveryInList.removeWhere((element) => element.date?.day != DateTime.now().day);
      }
    } else {
      _searchExistingDeliveryInList.clear();
    }
    setState(() {});
  }
}

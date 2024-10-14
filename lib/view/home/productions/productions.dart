import 'package:crm/controller/production_controller/production_controller.dart';
import 'package:crm/model/production_model/all_production_model.dart';
import 'package:crm/utility/utility.dart';
import 'package:crm/view/home/home.dart';
import 'package:crm/view/home/productions/singleProductions.dart';
import 'package:crm/view_controller/commonWidget.dart';
import 'package:crm/view_controller/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

enum ListFilter { today, all }

class Productoins extends StatefulWidget {
  const Productoins({super.key});

  @override
  State<Productoins> createState() => _ProductoinsState();
}

class _ProductoinsState extends State<Productoins> {
  final List<AllProductionDatum> _allProductionList = [];
  final List<AllProductionDatum> _allSearchProductionList = [];
  var filter = ListFilter.today;
  String query = "";
  bool isLoading = false;
  Future<void> _getAllProductionList() async {
    _allProductionList.clear();
    _allSearchProductionList.clear();
    setState(() => isLoading = true);
    var allProduction = await ProductionController.getAllProduction();
    for (var i in allProduction.data!) {
      setState(() {
        _allProductionList.add(i);
      });
    }
    if (filter == ListFilter.today) {
      _allProductionList.removeWhere((element) => element.productionDate?.day != DateTime.now().day);
    }
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllProductionList();
  }

  @override
  Widget build(BuildContext context) {
    return AppWidget(
      appBarOnBack: () => Get.to(const Home()),
      appBarTitle: "Productions",
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
                      hintText: "Search"),
                )),
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
                    _getAllProductionList();
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: isLoading
                  ? const Center(
                      child: AppLoader(),
                    )
                  // : _allSearchProductionList.isNotEmpty
                  //     ? ListView.builder(
                  //         itemCount: _allSearchProductionList.length,
                  //         itemBuilder: (_, index) {
                  //           var data = _allSearchProductionList[index];
                  //           return InkWell(
                  //             onTap: () => Get.to(SingleProductions(
                  //               productionModel: data,
                  //               id: data.id.toString(),
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
                  //                 bottom: _allProductionList.length == 1
                  //                     ? const BorderSide(width: 1, color: AppColor.borderColor)
                  //                     : BorderSide.none,
                  //               )),
                  //               child: Text(
                  //                 "${data.productionId}",
                  //                 style: const TextStyle(
                  //                     fontWeight: FontWeight.w500, color: Colors.black54, fontSize: 16),
                  //               ),
                  //             ),
                  //           );
                  //         })
                  : _allProductionList.isNotEmpty
                      ? ListView.builder(
                          itemCount: _allProductionList.length,
                          itemBuilder: (_, index) {
                            var data = _allProductionList[index];
                            if (!"${data.productionId}/${data.createdAt != null ? DateFormat("dd-MM-yyyy").format(data.createdAt!) : "N\\A"}/${data.assignedTo?.name}/${data.tables!.name}"
                                .toLowerCase()
                                .contains(query.toLowerCase())) {
                              return const SizedBox();
                            }
                            return InkWell(
                              onTap: () => Get.to(SingleProductions(
                                productionModel: data,
                                id: data.id.toString(),
                              )),
                              child: Container(
                                //height: 50,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    //borderRadius: BorderRadius.circular(5),
                                    border: Border(
                                  top: const BorderSide(width: 1, color: AppColor.borderColor),
                                  left: const BorderSide(width: 1, color: AppColor.borderColor),
                                  right: const BorderSide(width: 1, color: AppColor.borderColor),
                                  bottom: _allProductionList.length == 1
                                      ? const BorderSide(width: 1, color: AppColor.borderColor)
                                      : BorderSide.none,
                                )),
                                child: Text(
                                  "${data.productionId}/${data.createdAt != null ? DateFormat("dd-MM-yyyy").format(data.createdAt!) : "N\\A"}/${data.assignedTo?.name}/${data.tables!.name}",
                                  style:
                                      const TextStyle(fontWeight: FontWeight.w500, color: Colors.black54, fontSize: 16),
                                ),
                              ),
                            );
                          })
                      : const Center(
                          child: Text("No production found."),
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
    _allSearchProductionList.clear();
    if (query.isNotEmpty) {
      for (var i in _allProductionList) {
        if (i.productionId!.toLowerCase().contains(query)) {
          setState(() {
            _allSearchProductionList.add(i);
          });
        }
      }
      if (filter == ListFilter.today) {
        _allSearchProductionList.removeWhere((element) => element.productionDate?.day != DateTime.now().day);
      }
      print("_allSearchProductionList == ${_allSearchProductionList.length}");
    } else {
      _allSearchProductionList.clear();
    }
    setState(() {});
  }
}

import 'package:crm/controller/delivery_controller%20/out_controller/delivery_out_controller.dart';
import 'package:crm/model/delivery_model/out_model/existing_delivery_out_model.dart';
import 'package:crm/utility/utility.dart';
import 'package:crm/view_controller/appWidgets.dart';
import 'package:crm/view_controller/commonWidget.dart';
import 'package:crm/view_controller/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'deliveryOut.dart';
import 'single_existing_delivery.dart';


class ExistingDeliveriesOuts extends StatefulWidget {
  final bool? isIn;
  const ExistingDeliveriesOuts({Key? key,  this.isIn = true}) : super(key: key);

  @override
  State<ExistingDeliveriesOuts> createState() => _ExistingDeliveriesOutsState();
}

class _ExistingDeliveriesOutsState extends State<ExistingDeliveriesOuts> {
  var inputFormat = DateFormat("dd-MM-yyyy");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getExstingData();
  }

  @override
  Widget build(BuildContext context) {
    return AppWidget(
      appBarOnBack: ()=>Get.to(const DeliveryOut()),
      appBarTitle: "Delivery Out ",
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child:  TextFormField(
                      onChanged: (v){
                        _search(v.toLowerCase());
                      },
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none
                          ),
                          hintText: "Search by ID"
                      ),
                    )
                ),
                const SizedBox(width: 15,),
                Container(
                  width: 100,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: AppWidgets.buildLinearGradient()
                  ),
                  child: const Center(
                    child: Text("Search",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ),

              ],
            ),
            const SizedBox(height: 20,),
            Expanded(
                child: isLoading
                    ? const AppLoader()
                    : _searchExistingDeliveryInList.isNotEmpty
                    ? ListView.builder(
                    itemCount: _searchExistingDeliveryInList.length,
                    itemBuilder: (_, index){
                      var data = _searchExistingDeliveryInList[index];
                      return InkWell(
                        onTap: ()=>Get.to(SingleExistingDeliveriesOuts(existingDeliveryOutDatum: data, existingDeliveryId: data.id.toString(),)),
                        child: Container(
                          //height: 50,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            //borderRadius: BorderRadius.circular(5),
                              border: Border(
                                top: const BorderSide(width: 1, color: AppColor.borderColor),
                                left: const BorderSide(width: 1, color: AppColor.borderColor),
                                right: const BorderSide(width: 1, color: AppColor.borderColor),
                                bottom: _searchExistingDeliveryInList.length ==1 ? const BorderSide(width: 1, color: AppColor.borderColor) : const BorderSide(width: 0, color: AppColor.white) ,
                              )
                          ),
                          child: Text("${data.deliveryOutId}/${inputFormat.format(data.date!)}-${data.measurement!.name}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                                fontSize: 16
                            ),
                          ),
                        ),
                      );
                    }
                )
                    : ListView.builder(
                    itemCount: _existingDeliveryInList.length,
                    itemBuilder: (_, index){
                      var data = _existingDeliveryInList[index];
                      return InkWell(
                        onTap: ()=>Get.to(SingleExistingDeliveriesOuts(existingDeliveryOutDatum: data, existingDeliveryId: data.id.toString(),)),
                        child: Container(
                          //height: 50,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            //borderRadius: BorderRadius.circular(5),
                              border: Border(
                                top: const BorderSide(width: 1, color: AppColor.borderColor),
                                left: const BorderSide(width: 1, color: AppColor.borderColor),
                                right: const BorderSide(width: 1, color: AppColor.borderColor),
                                bottom: _existingDeliveryInList.length !=1 ? const BorderSide(width: 1, color: AppColor.borderColor) : const BorderSide(width: 0, color: AppColor.white) ,
                              )
                          ),
                          child: Text("${data.deliveryOutId}/${inputFormat.format(data.date ?? DateTime.now())}/${data.measurement?.name ?? "N/A"}/${data.customer?.name??"N/A"}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                                fontSize: 16
                            ),
                          ),
                        ),
                      );
                    }
                )
            ),
          ],
        ),
      ),
    );
  }

  //===== existing data
  bool isLoading = true;
  final List<ExistingDeliveryOutDatum> _existingDeliveryInList = [];
  final List<ExistingDeliveryOutDatum> _searchExistingDeliveryInList = [];
  void _getExstingData() async{
    setState(() =>isLoading = true);
    if(widget.isIn! == false){ //check if its from Delivery in screen, then run this block of code.
      try{
        var res = await DeliveryOutController.getExistingDelidyOutList();
        for(var i in res.data!){
          _existingDeliveryInList.add(i);
        }
        setState(() =>isLoading = false);
      }catch(e){
        print("existing delivery in response error $e}");
        setState(() =>isLoading = false);
      }
    }else{ //otherwise this one.

    }
  }


  //search list
  void _search(String query) {
    print("query == $query");
    _searchExistingDeliveryInList.clear();
    if(query.isNotEmpty){
      for(var i in _existingDeliveryInList){
        if(i.deliveryOutId!.toLowerCase().contains(query)){
          setState(() {
            _searchExistingDeliveryInList.add(i);
          });
        }
      }
    }else{
      _searchExistingDeliveryInList.clear();
    }
    setState(() {

    });
  }
}

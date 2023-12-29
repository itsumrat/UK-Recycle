import 'package:crm/controller/delivery_controller%20/out_controller/delivery_out_controller.dart';
import 'package:crm/model/delivery_model/in_model/deliveryin_model.dart';
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

import '../deliveryIn/existingDeliveries/singleExistingDeliveries.dart';



class DeliveryOutsTransactionsList extends StatefulWidget {
  final SingleExistingDeliveryOutModel? singleDeliveryOutModel;
  final ExistingDeliveryOutDatum?  existingDeliveryOutDatum;

  const DeliveryOutsTransactionsList({Key? key, this.singleDeliveryOutModel, this.existingDeliveryOutDatum}) : super(key: key);

  @override
  State<DeliveryOutsTransactionsList> createState() => _DeliveryOutsTransactionsListState();
}

class _DeliveryOutsTransactionsListState extends State<DeliveryOutsTransactionsList> {

  List<Transaction> _transcationList = [];
  List<Transaction> _searchTranscationList = [];
  bool isLoading = false;
  var role;
  getTranscationList()async{
    setState(() =>isLoading = true);
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      role = _pref.getString("role");
    });
    var res = await DeliveryOutController.getSingleDeliveryOutTrList(id: widget.singleDeliveryOutModel!.data!.delivery!.id.toString());
    print("res.data!.transaction! === ${res.data!.transaction!}");
    for(var i in res.data!.transaction!){
      setState(() {
        _transcationList?.add(i);
      });
    }
    setState(() =>isLoading = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTranscationList();

    print("came from erdit ${widget.existingDeliveryOutDatum}");
;  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AppWidget(
       //appBarOnBack: ()=>Get.back(),
      appBarOnBack: ()=>Get.to(SingleExistingDeliveriesOuts(existingDeliveryOutDatum: widget.existingDeliveryOutDatum,  existingDeliveryId: widget.singleDeliveryOutModel!.data!.delivery!.id.toString(),)),
      appBarTitle: "Transaction",
      body: isLoading? Center(child: AppLoader(),) :  Padding(
        padding: EdgeInsets.all(20),
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
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none
                          ),
                          hintText: "Search"
                      ),
                    )
                ),
                SizedBox(width: 15,),
                Container(
                  width: 100,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: AppWidgets.buildLinearGradient()
                  ),
                  child: Center(
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
            SizedBox(height: 20,),
            Expanded(
                child: _searchTranscationList.isNotEmpty
                    ? ListView.builder(
                    itemCount: _searchTranscationList.length,
                    itemBuilder: (_, index){
                      return InkWell(
                        //onTap: ()=>Get.to(SingleExistingDeliveries()),
                        child: Container(
                          //height: 50,
                          padding: EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: size.width*.30,
                                child: Text("${widget.singleDeliveryOutModel!.data!.delivery!.deliveryOutId}/${_searchTranscationList[index]!.id}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      fontSize: 16
                                  ),
                                ),
                              ),

                              SizedBox(
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Text("${widget.singleDeliveryOutModel!.data!.delivery!.categories!.name}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.textColor,
                                        fontSize: 16
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10,),
                              SizedBox(
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Text("${_searchTranscationList[index]!.weight} ${widget.singleDeliveryOutModel!.data!.delivery!.measurement!.name}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        fontSize: 16
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10,),
                              SizedBox(
                                child: InkWell(
                                  onTap: ()=>Get.to(EditDeliveryOutTranscation(existingDeliveryOutDatum: widget.existingDeliveryOutDatum, singleDelivery: widget.singleDeliveryOutModel!, singleTransaction: _searchTranscationList![index]!,)),
                                  child: Container(
                                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
                                    decoration: BoxDecoration(
                                        color: AppColor.mainColor,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Text("Edit",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                          fontSize: 16
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                )
                    : _transcationList.isEmpty ? const Center(child: Text("No Transaction Found."),) : ListView.builder(
                    itemCount: _transcationList.length,
                    itemBuilder: (_, index){
                      return InkWell(
                        //onTap: ()=>Get.to(SingleExistingDeliveries()),
                        child: Container(
                          //height: 50,
                          padding: EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: size.width*.30,
                                child: Text("${widget.singleDeliveryOutModel!.data!.delivery!.deliveryOutId}/${_transcationList[index]!.id}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      fontSize: 16
                                  ),
                                ),
                              ),

                              SizedBox(
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Text("${widget.singleDeliveryOutModel!.data!.delivery!.categories!.name}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.textColor,
                                        fontSize: 16
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10,),
                              SizedBox(
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Text("${_transcationList[index]!.weight} ${widget.singleDeliveryOutModel!.data!.delivery!.measurement!.name}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        fontSize: 16
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10,),
                              role == AppConst.supervisorRole ? SizedBox(
                                child: InkWell(
                                  onTap: ()=>Get.to(EditDeliveryOutTranscation(existingDeliveryOutDatum: widget.existingDeliveryOutDatum, singleDelivery: widget.singleDeliveryOutModel!, singleTransaction: _transcationList[index],)),
                                  child: Container(
                                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
                                    decoration: BoxDecoration(
                                        color: AppColor.mainColor,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Text("Edit",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                          fontSize: 16
                                      ),
                                    ),
                                  ),
                                ),
                              ) : Center(),
                            ],
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

  //search list
  void _search(String query) {
    print("query == $query");
    _searchTranscationList.clear();
    if(query.isNotEmpty){
      for(var i in _transcationList!){
        if(i.id!.toString()!.contains(query)){
          setState(() {
            _searchTranscationList.add(i);
          });
        }
      }
    }

    print("_searchTranscationList ${_searchTranscationList.length}");
  }
}

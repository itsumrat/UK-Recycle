import 'package:crm/controller/production_controller/production_controller.dart';
import 'package:crm/view/home/productions/singleProductionInput.dart';
import 'package:crm/view_controller/commonWidget.dart';
import 'package:crm/view_controller/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/production_model/all_production_model.dart';
import '../../../model/production_model/transaction_by_production_id_model.dart';
import '../../../utility/utility.dart';
import '../../../view_controller/appWidgets.dart';

class EditProductionsTranslation extends StatefulWidget {
  final AllProductionDatum? productionModel;
  const EditProductionsTranslation({Key? key, required this.productionModel}) : super(key: key);

  @override
  State<EditProductionsTranslation> createState() => _EditProductionsTranslationState();
}

class _EditProductionsTranslationState extends State<EditProductionsTranslation> {


  List<TransactionDatum> _allTransactionByProductionList = [];
  List<TransactionDatum> _allSearchTransactionByProductionList = [];
  bool isLoading = false;
  Future<void> _getTransactionByProduction()async{
    setState(() =>isLoading = true);
    var transactionByProduction = await ProductionController.getTransactionByProduction(id: widget.productionModel!.id.toString());
    for(var i in transactionByProduction.data!){
      setState(() {
        _allTransactionByProductionList.add(i);
      });
    }
    setState(() =>isLoading = false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTransactionByProduction();
  }

  @override
  Widget build(BuildContext context) {
    return AppWidget(
      appBarTitle: "Translation List ewrw",
      appBarOnBack: ()=>Get.back(),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child:  TextFormField(
                      onChanged: (v){
                        _search(v);
                      },
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none
                          ),
                          hintText: "Search "
                      ),
                    )
                ),
                SizedBox(width: 15,),
                InkWell(
                 // onTap: ()=>Get.to(AddNewGrade()),
                  child: Container(
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
                ),

              ],
            ),
            SizedBox(height: 20,),
            Expanded(
                child: isLoading
                    ? AppLoader()
                    : _allSearchTransactionByProductionList.isNotEmpty
                    ? ListView.builder(
                    itemCount: _allSearchTransactionByProductionList.length,
                    itemBuilder:(_, index){
                      var data = _allSearchTransactionByProductionList[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: MediaQuery.of(context).size.width*.35,
                              child: Text("${widget.productionModel!.productionId}/${data.id.toString()}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            SizedBox(
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Text("${data.grades!.name}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey
                                    ),
                                  ),
                                )

                            ),
                            SizedBox(width: 10,),
                            SizedBox(
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Text("${data.weight}KG",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey
                                    ),
                                  ),
                                )

                            ),
                            SizedBox(width: 10,),
                            SizedBox(
                                child: InkWell(
                                  onTap:()=>Get.to(SingleProductionInput(transactionID: data.id.toString(), production: widget.productionModel, existingWeight: data.weight.toString(), existingGrade: data.grades!.name, existingGradeId: data.grades!.id.toString(),)),
                                  child: Container(
                                    padding: EdgeInsets.only(left: 13, right: 13, top: 5, bottom: 5),
                                    decoration: BoxDecoration(
                                        color: AppColor.mainColor,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Text("Edit",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white
                                      ),
                                    ),
                                  ),
                                )

                            )
                          ],
                        ),
                      );
                    }
                )
                    : _allTransactionByProductionList.isNotEmpty
                    ? ListView.builder(
                        itemCount: _allTransactionByProductionList.length,
                        itemBuilder:(_, index){
                          var data = _allTransactionByProductionList[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: MediaQuery.of(context).size.width*.35,
                                  child: Text("${widget.productionModel!.productionId}/${data.id.toString()}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                SizedBox(
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: Text("${data.grades!.name}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey
                                        ),
                                      ),
                                    )

                                ),
                                SizedBox(width: 10,),
                                SizedBox(
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Text("${data.weight}KG",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey
                                      ),
                                    ),
                                  )

                                ),
                                SizedBox(width: 10,),
                                SizedBox(
                                    child: InkWell(
                                      onTap:()=>Get.to(SingleProductionInput(transactionID: data.id.toString(), production: widget.productionModel, existingWeight: data.weight.toString(), existingGrade: data.grades!.name, existingGradeId: data.grades!.id.toString(),)),
                                      child: Container(
                                        padding: EdgeInsets.only(left: 13, right: 13, top: 5, bottom: 5),
                                        decoration: BoxDecoration(
                                            color: AppColor.mainColor,
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Text("Edit",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white
                                          ),
                                        ),
                                      ),
                                    )

                                )
                              ],
                            ),
                          );
                        }
                    )
                    : Center(child: Text("Data not found."),)
            ),
          ],
        ),
      ),
    );
  }


  //search list
  void _search(String query) {
    print("query == $query");
    _allSearchTransactionByProductionList!.clear();
    if(query.isNotEmpty){
      for(var i in _allTransactionByProductionList!){
        if("${widget.productionModel!.productionId}/${i.id.toString()}".toLowerCase().contains(query)){
          setState(() {
            _allSearchTransactionByProductionList?.add(i);
          });
        }
      }
      print("_allSearchProductionList == ${_allSearchTransactionByProductionList.length}");
    }else{
    _allSearchTransactionByProductionList!.clear();
    }
    setState(() {

    });
  }
}

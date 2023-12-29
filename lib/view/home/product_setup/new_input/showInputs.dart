import 'package:crm/controller/production_controller/production_controller.dart';
import 'package:crm/model/production_model/single_production_list.dart';
import 'package:crm/utility/app_const.dart';
import 'package:crm/view/home/product_setup/new_input/new_inputs.dart';
import 'package:crm/view/home/product_setup/product_setup.dart';
import 'package:crm/view_controller/appWidgets.dart';
import 'package:crm/view_controller/commonWidget.dart';
import 'package:crm/view_controller/detailsTextSideBySide.dart';
import 'package:crm/view_controller/loader.dart';
import 'package:crm/widgets/app_title_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowNewlyCretaeProduction extends StatefulWidget {
  final String pId;
  const ShowNewlyCretaeProduction({Key? key, required this.pId}) : super(key: key);

  @override
  State<ShowNewlyCretaeProduction> createState() => _ShowNewlyCretaeProductionState();
}

class _ShowNewlyCretaeProductionState extends State<ShowNewlyCretaeProduction> {

  Future<SingleProductionModel>? _getSingleProduction;

  var userId, userName, date;

  getLogInfo()async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      userId = _pref.getString("user_id")!;
      userName = _pref.getString("user_name")!;
      date = AppConst.currentData();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLogInfo();
    _getSingleProduction = ProductionController.getSingleProduction(id: widget.pId);
  }


  @override
  Widget build(BuildContext context) {
    return AppWidget(
        appBarOnBack: ()=>Get.back(),
        appBarTitle: "Production",
        body: FutureBuilder<SingleProductionModel>(
          future: _getSingleProduction,
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: AppLoader(),);
            }else if(snapshot.hasData){
              var data = snapshot.data!.data!;
              return SingleChildScrollView(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    Center(
                      child: AppTitleText(text: "Production Created ${data.production!.productionId}"),
                    ),
                    SizedBox(height: 40,),
                    Padding(padding: EdgeInsets.only(left: 40, right: 40),
                      child: Column(
                        children: [

                          AppSideBySIdeText(leftText: "Assign to:  ", rightText: "${data.production!.assignedTo!.name}"),
                          SizedBox(height: 20,),
                          AppSideBySIdeText(leftText: "Production ID:  ", rightText: "${data.production!.productionId}"),
                          SizedBox(height: 20,),
                          AppSideBySIdeText(leftText: "Date: ", rightText: "${AppConst.formetData(data.production!.createdAt)}"),
                          SizedBox(height: 20,),
                          AppSideBySIdeText(leftText: "User: ", rightText: "${userName}"),
                          SizedBox(height: 20,),
                          AppSideBySIdeText(leftText: "user Id: ", rightText: "${userId}"),

                          SizedBox(height: 50,),
                          Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: ()=>Get.to(NewInputs()),
                              child: Container(
                                width: 180,
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: AppWidgets.buildLinearGradient(),
                                ),
                                child: Center(
                                  child: Text("New Input",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 17
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: ()=>Get.to(ProductSetup()),
                              child: Container(
                                width: 180,
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: AppWidgets.buildLinearGradient(),
                                ),
                                child: Center(
                                  child: Text("Back",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 17
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }else{
              return Center(child: Text("Something went wrong."),);
            }
          }
        )
    );
  }
}


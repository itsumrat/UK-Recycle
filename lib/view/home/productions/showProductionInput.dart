import 'package:crm/controller/production_controller/production_controller.dart';
import 'package:crm/model/production_model/all_production_model.dart';
import 'package:crm/model/production_model/single_production_trx.dart';
import 'package:crm/view/home/productions/singleProductionInput.dart';
import 'package:crm/view/home/productions/singleProductions.dart';
import 'package:crm/view_controller/appWidgets.dart';
import 'package:crm/view_controller/commonWidget.dart';
import 'package:crm/view_controller/detailsTextSideBySide.dart';
import 'package:crm/view_controller/loader.dart';
import 'package:crm/widgets/app_title_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowProductionsInputs extends StatefulWidget {
  final String weight;
  final String grade;
  final String date;
  final AllProductionDatum? production;
  final String? transactionID;
  const ShowProductionsInputs(
      {super.key, required this.weight, required this.grade, this.production, required this.date, this.transactionID});

  @override
  State<ShowProductionsInputs> createState() => _ShowProductionsInputsState();
}

class _ShowProductionsInputsState extends State<ShowProductionsInputs> {
  Future<SingleProductionTrx>? getSingleTransactionByProduction;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSingleTransactionByProduction =
        ProductionController.getSingleTransactionByProduction(id: widget.production!.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return AppWidget(
        appBarOnBack: () => Get.back(),
        appBarTitle: "Production ID: ${widget.production?.productionId}",
        body: FutureBuilder<SingleProductionTrx>(
            future: getSingleTransactionByProduction,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: AppLoader(),
                );
              } else if (snapshot.hasData) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Center(
                        child: AppTitleText(
                            text: "Transaction Created ${widget.production!.productionId}/${widget.transactionID}"),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [
                            // AppSideBySIdeText(leftText: "Super Id: ", rightText: "${widget.production!.su}"),
                            // SizedBox(height: 20,),
                            // AppSideBySIdeText(
                            //     leftText: "Assigned to:  ", rightText: "${widget.production!.assignedTo!.name}"),
                            // const SizedBox(
                            //   height: 20,
                            // ),
                            AppSideBySIdeText(
                                leftText: "Production trx:  ",
                                rightText: "${widget.production!.productionId}/${widget.transactionID}"),
                            const SizedBox(
                              height: 20,
                            ),
                            AppSideBySIdeText(leftText: "Date: ", rightText: widget.date),
                            const SizedBox(
                              height: 20,
                            ),
                            AppSideBySIdeText(leftText: "Grade: ", rightText: widget.grade),
                            const SizedBox(
                              height: 20,
                            ),
                            AppSideBySIdeText(leftText: "Weight: ", rightText: widget.weight),

                            const SizedBox(
                              height: 50,
                            ),

                            Align(
                              alignment: Alignment.center,
                              child: InkWell(
                                // onTap: (){
                                //   print(" snapshot.data!.data!.weight == ${widget.weight}");
                                // },
                                onTap: () => Get.to(SingleProductionInput(
                                  transactionID: widget.transactionID,
                                  existingWeight: widget.weight.toString(),
                                  existingGrade: snapshot.data!.data?.grades?.name,
                                  existingGradeId: snapshot.data!.data?.grades?.id?.toString(),
                                  production: widget.production,
                                )),
                                child: Container(
                                  width: 180,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: AppWidgets.buildLinearGradient(),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Edit",
                                      style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 17),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () => Get.to(SingleProductionInput(
                                  production: widget.production,
                                  transactionID: widget.transactionID,
                                )),
                                child: Container(
                                  width: 180,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: AppWidgets.buildLinearGradient(),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Add More",
                                      style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 17),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: InkWell(
                                // onTap:()=> Get.back(),
                                onTap: () => Get.to(SingleProductions(
                                  productionModel: widget.production,
                                  id: widget.production!.id.toString(),
                                )),
                                child: Container(
                                  width: 180,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: AppWidgets.buildLinearGradient(),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Back",
                                      style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 17),
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
              } else {
                return const Center(
                  child: Text("Something went wrong"),
                );
              }
            }));
  }
}

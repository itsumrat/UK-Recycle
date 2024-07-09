import 'package:crm/view_controller/appWidgets.dart';
import 'package:crm/view_controller/commonWidget.dart';
import 'package:crm/view_controller/detailsTextSideBySide.dart';
import 'package:crm/widgets/app_title_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewGrade extends StatefulWidget {
  const AddNewGrade({super.key});

  @override
  State<AddNewGrade> createState() => _AddNewGradeState();
}

class _AddNewGradeState extends State<AddNewGrade> {


  @override
  Widget build(BuildContext context) {
    return AppWidget(
        appBarOnBack: ()=>Get.back(),
        appBarTitle: "Production setup",
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              const Center(
                child: AppTitleText(text: "New Production"),
              ),
              const SizedBox(height: 40,),
              Padding(padding: const EdgeInsets.only(left: 40, right: 40),
                child: Column(
                  children: [
                    const AppSideBySIdeText(leftText: "Super Id: ", rightText: "Supper 01"),
                    const SizedBox(height: 20,),
                    const AppSideBySIdeText(leftText: "Assign by:  ", rightText: "Mr Nayon"),
                    const SizedBox(height: 20,),
                    const AppSideBySIdeText(leftText: "Date: ", rightText: "28/06/2022"),
                    const SizedBox(height: 20,),
                    const AppSideBySIdeText(leftText: "Time: ", rightText: "10:30 AM"),
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        const Expanded(
                          child: Text("Grade",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontSize: 15
                            ),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        Expanded(
                            child:  TextFormField(
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade200,
                                  filled: true,
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide.none
                                  ),
                                  hintText: "Input"
                              ),
                            )
                        ),

                      ],
                    ),
                    const SizedBox(height: 50,),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: ()=>Get.back(),
                        child: Container(
                          width: 180,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: AppWidgets.buildLinearGradient(),
                          ),
                          child: const Center(
                            child: Text("Add",
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

                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}


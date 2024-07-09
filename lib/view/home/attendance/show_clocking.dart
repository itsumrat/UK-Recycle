import 'package:crm/view/home/attendance/attendacer.dart';
import 'package:crm/view_controller/commonWidget.dart';
import 'package:crm/view_controller/detailsTextSideBySide.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../view_controller/appWidgets.dart';
import 'clockIn.dart';

class ShowClockIn extends StatefulWidget {
  const ShowClockIn({super.key});

  @override
  State<ShowClockIn> createState() => _ShowClockInState();
}

class _ShowClockInState extends State<ShowClockIn> {
  @override
  Widget build(BuildContext context) {
    return AppWidget(
      appBarTitle: "Check In",
      appBarOnBack: ()=>Get.back(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(60),
        child: Column(
          children: [
            const AppSideBySIdeText(leftText: "User Type : ", rightText: "Super User"),
            const SizedBox(height: 30,),
            const AppSideBySIdeText(leftText: "User Name: ", rightText: "User Name"),
            const SizedBox(height: 30,),
            const AppSideBySIdeText(leftText: "Date: ", rightText: "28/10/2023"),
            const SizedBox(height: 30,),
            const AppSideBySIdeText(leftText: "Time: ", rightText: "09:45PM"),
            const SizedBox(height: 70,),
            InkWell(
              onTap: ()=>Get.to(const Attendance()),
              child: Container(
                width: 200,
                height: 60,
                decoration: BoxDecoration(
                    gradient: AppWidgets.buildLinearGradient(),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: const Center(
                  child: Text("Back",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 16
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30,),
            InkWell(
              onTap: ()=>Get.to(const Clicking()),
              child: Container(
                width: 200,
                height: 60,
                decoration: BoxDecoration(
                    gradient: AppWidgets.buildLinearGradient(),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: const Center(
                  child: Text("New",
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
}

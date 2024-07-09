import 'package:crm/view/home/attendance/attendance_list.dart';
import 'package:crm/view/home/attendance/clockIn.dart';
import 'package:crm/view/home/attendance/clockOut.dart';
import 'package:crm/view_controller/appWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../view_controller/commonWidget.dart';


class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  @override
  Widget build(BuildContext context) {
    return AppWidget(
      appBarOnBack: ()=>Get.back(),
      appBarTitle: "Attendance",
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: ()=>Get.to(const Clicking()),
                child: Container(
                  width: 200,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: AppWidgets.buildLinearGradient(),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Center(
                    child: Text("Clock In",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30,),
            InkWell(
              onTap: ()=>Get.to(const ClockOut()),
              child: Container(
                width: 200,
                height: 60,
                decoration: BoxDecoration(
                    gradient: AppWidgets.buildLinearGradient(),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: const Center(
                  child: Text("Clock Out",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30,),
            InkWell(
              onTap: ()=>Get.to(const AttendanceList()),
              child: Container(
                width: 200,
                height: 60,
                decoration: BoxDecoration(
                    gradient: AppWidgets.buildLinearGradient(),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: const Center(
                  child: Text("Attendance",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),

      ),
    );
  }
}

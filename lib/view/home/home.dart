import 'package:crm/utility/app_const.dart';
import 'package:crm/view/appBottomNavigationBar.dart';
import 'package:crm/view/home/product_setup/product_setup.dart';
import 'package:crm/view_controller/appWidgets.dart';
import 'package:crm/widgets/app_boxes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'attendance/attendacer.dart';
import 'attendance/attendance_list.dart';
import 'dalivery/deliveryIn/deliveryIn.dart';
import 'dalivery/delivery_out/deliveryOut.dart';
import 'productions/productions.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRole(); //get role here..
  }

  //=== get role method
  getRole() async {
    print("dafadsf");
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      role = pref.getString("role").toString();
    });
  }

  //=== role store variable
  var role = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const AppBottomNavigation(pageIndex: 0),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$role Dashboard",
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w400, color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              role == AppConst.attendantRole
                  ? const AttendanceForStaf()
                  : Column(
                      children: [
                        Column(
                          children: [
                            const DeliveryInOutHomeScreen(),
                            const SizedBox(
                              height: 20,
                            ),
                            role == AppConst.supervisorRole ? const ProductionSetUpHomeScreen() : const Center(),
                            const ProductionHomeScreen(),
                          ],
                        ),
                        role == AppConst.supervisorRole ? const AttendanceListHome() : const Center(),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}

class AttendanceHomeScreen extends StatelessWidget {
  const AttendanceHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(const Attendance()),
      child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.only(left: 20, bottom: 20, top: 20, right: 20),
          decoration: BoxDecoration(
              gradient: AppWidgets.buildLinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(15)),
          child: const ListTile(
            leading: FaIcon(
              FontAwesomeIcons.shirt,
              size: 30,
              color: Colors.white,
            ),
            title: Text(
              "Attendance",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400, color: Colors.white),
            ),
          )),
    );
  }
}

class AttendanceListHome extends StatelessWidget {
  const AttendanceListHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(const AttendanceList()),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(left: 20, bottom: 20, top: 20, right: 20),
        decoration: BoxDecoration(
            gradient: AppWidgets.buildLinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(15)),
        child: const ListTile(
          leading: FaIcon(
            FontAwesomeIcons.shirt,
            size: 30,
            color: Colors.white,
          ),
          title: Text(
            "Attendance List",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class AttendanceForStaf extends StatelessWidget {
  const AttendanceForStaf({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(const Attendance()),
      child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.only(left: 20, bottom: 20, top: 20, right: 20),
          decoration: BoxDecoration(
              gradient: AppWidgets.buildLinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(15)),
          child: const ListTile(
            leading: FaIcon(
              FontAwesomeIcons.shirt,
              size: 30,
              color: Colors.white,
            ),
            title: Text(
              "Attendance List",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400, color: Colors.white),
            ),
          )),
    );
  }
}

class ProductionHomeScreen extends StatelessWidget {
  const ProductionHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(const Productoins()),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(left: 20, bottom: 20, top: 20, right: 20),
        decoration: BoxDecoration(
            gradient: AppWidgets.buildLinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(15)),
        child: const ListTile(
          leading: FaIcon(
            FontAwesomeIcons.gear,
            size: 30,
            color: Colors.white,
          ),
          title: Text(
            "Production",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class ProductionSetUpHomeScreen extends StatelessWidget {
  const ProductionSetUpHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(const ProductSetup()),
      child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.only(left: 20, bottom: 20, top: 20, right: 20),
          decoration: BoxDecoration(
              gradient: AppWidgets.buildLinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(15)),
          child: const ListTile(
            leading: FaIcon(
              FontAwesomeIcons.arrowsRotate,
              size: 30,
              color: Colors.white,
            ),
            title: Text(
              "Production Setup",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400, color: Colors.white),
            ),
          )),
    );
  }
}

class DeliveryInOutHomeScreen extends StatelessWidget {
  const DeliveryInOutHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /////Delivery in
        Expanded(
          child: InkWell(
            onTap: () => Get.to(const DeliveryIn()),
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                  gradient: AppWidgets.buildLinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(15)),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.shirt,
                    size: 45,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Delivery In",
                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 18),
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: AppBox(
            title: "Delivery Out",
            onClick: () => Get.to(const DeliveryOut()),
            height: 220,
            width: double.infinity,
          ),
        )
      ],
    );
  }
}

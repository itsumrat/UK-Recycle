import 'package:crm/controller/auth_controller/auth_controller.dart';
import 'package:crm/view/appBottomNavigationBar.dart';
import 'package:crm/view/profile/profile.dart';
import 'package:crm/view/setting/change_password.dart';
import 'package:crm/view_controller/appWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const AppBottomNavigation(pageIndex: 1,),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Setting",
                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 30),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () => Get.to(const Profile()),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                          gradient: AppWidgets.buildLinearGradient(), borderRadius: BorderRadius.circular(10)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 35,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Profile Setting",
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () => Get.to(const ChangePassword()),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                          gradient: AppWidgets.buildLinearGradient(), borderRadius: BorderRadius.circular(10)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 35,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Password Change",
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () => AuthController.logout(),
                    child: Container(
                      height: 100,
                      margin: const EdgeInsets.only(left: 70, right: 70),
                      decoration: BoxDecoration(
                          gradient: AppWidgets.buildRedLinearGradient(), borderRadius: BorderRadius.circular(10)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 35,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Logout",
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

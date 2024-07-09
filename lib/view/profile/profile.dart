import 'package:crm/controller/auth_controller/profile_controller.dart';
import 'package:crm/utility/utility.dart';
import 'package:crm/view/appBottomNavigationBar.dart';
import 'package:crm/view/profile/edit_profile.dart';
import 'package:crm/view_controller/detailsTextSideBySide.dart';
import 'package:crm/view_controller/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/profile_model/profile_info_model.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<ProfileInfoModel>? profileInfoFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileInfoFuture = ProfileController.getProfileInfo();

    ///TODO: change it when login api get user id
  }

  //profile info controller call and user id get from local database

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: const AppBottomNavigation(pageIndex: 2),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: FutureBuilder<ProfileInfoModel>(
                future: profileInfoFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: AppLoader(),
                    );
                  } else if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Center(
                            child: Text(
                              "Profile",
                              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 30),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          // Center(
                          //   child: Container(
                          //     width: 180,
                          //     height: 180,
                          //     padding: const EdgeInsets.all(20),
                          //     decoration:
                          //         BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(100)),
                          //     child: const Column(
                          //       children: [
                          //         Icon(
                          //           Icons.person,
                          //           color: Colors.black,
                          //           size: 100,
                          //         ),
                          //         Text("Upload your image")
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 30,
                          // ),
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                              child: AppSideBySIdeText(
                                  leftText: "User Id: ", rightText: "${snapshot.data?.data?.userId}")),
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                              child: AppSideBySIdeText(
                                  leftText: "User Name: ", rightText: "${snapshot.data?.data?.name}")),
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                              child:
                                  AppSideBySIdeText(leftText: "Email: ", rightText: "${snapshot.data?.data?.email}")),
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                              child: AppSideBySIdeText(
                                  leftText: "Address: ", rightText: "${snapshot.data?.data?.address}")),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: InkWell(
                              onTap: () => Get.to(const EditProfile()),
                              child: Container(
                                width: 100,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: AppColor.mainColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text("Please check you internet connection."),
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }
}

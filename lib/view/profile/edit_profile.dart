// ignore_for_file: use_build_context_synchronously

import 'package:crm/controller/auth_controller/auth_controller.dart';
import 'package:crm/controller/auth_controller/profile_controller.dart';
import 'package:crm/utility/utility.dart';
import 'package:crm/view/home/home.dart';
import 'package:crm/view_controller/detailsTextSideBySide.dart';
import 'package:crm/view_controller/loader.dart';
import 'package:crm/view_controller/snackbar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/profile_model/profile_info_model.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  Future<ProfileInfoModel>? profileInfoFuture;

  final userName = TextEditingController();
  final email = TextEditingController();
  final address = TextEditingController();

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
                    userName.text = snapshot.data!.data!.name!;
                    email.text = snapshot.data!.data!.email!;
                    address.text = snapshot.data!.data!.address!;
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
                              "Edit Profile",
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "User Name",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: userName,
                                  decoration: InputDecoration(
                                    hintText: "User Name",
                                    contentPadding: const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(width: 1, color: AppColor.borderColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(width: 1, color: AppColor.borderSelectColor),
                                    ),
                                  ),
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return "Username must not be empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Email",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: email,
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    contentPadding: const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(width: 1, color: AppColor.borderColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(width: 1, color: AppColor.borderSelectColor),
                                    ),
                                  ),
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return "Email must not be empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Address",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: address,
                                  decoration: InputDecoration(
                                    hintText: "Address",
                                    contentPadding: const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(width: 1, color: AppColor.borderColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(width: 1, color: AppColor.borderSelectColor),
                                    ),
                                  ),
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return "Address must not be empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: InkWell(
                              onTap: () => _updateInfo(),
                              child: Container(
                                width: 100,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: AppColor.mainColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Center(
                                        child: Text(
                                          "Save",
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

  bool isLoading = false;
  void _updateInfo() async {
    setState(() => isLoading = true);
    var res = await AuthController.updateProfile(name: userName.text, email: email.text, address: address.text);
    if (res.statusCode == 200) {
      AppSnackbar.appSnackbar("Profile Information updated.", Colors.green, context);
      Get.to(() => const Home());
    } else {
      AppSnackbar.appSnackbar("Something went wrong.", Colors.red, context);
    }
    setState(() => isLoading = false);
  }
}

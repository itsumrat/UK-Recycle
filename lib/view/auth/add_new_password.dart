import 'package:crm/utility/utility.dart';
import 'package:crm/view/home/home.dart';
import 'package:crm/view_controller/appWidgets.dart';
import 'package:crm/view_controller/commonWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewPassword extends StatefulWidget {
  const AddNewPassword({super.key});

  @override
  State<AddNewPassword> createState() => _AddNewPasswordState();
}

class _AddNewPasswordState extends State<AddNewPassword> {
  final password = TextEditingController();
  final c_pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AppWidget(
      appBarOnBack: () => Get.back(),
      appBarTitle: "Add new password",
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .07,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * .70,
                child: const Center(
                  child: Text(
                    "Please enter your email address and we will send you a code to your phoen to rest the password.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black, fontSize: 16),
                  ),
                )),
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Password",
                  contentPadding: const EdgeInsets.only(left: 25, right: 25, top: 17, bottom: 17),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(width: 1, color: AppColor.borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(width: 1, color: AppColor.borderSelectColor),
                  ),
                  suffixIcon: const Icon(Icons.key)),
              validator: (v) {
                if (v!.isEmpty) {
                  return "Enter your email";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: c_pass,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Confirm Password",
                  contentPadding: const EdgeInsets.only(left: 25, right: 25, top: 17, bottom: 17),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(width: 1, color: AppColor.borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(width: 1, color: AppColor.borderSelectColor),
                  ),
                  suffixIcon: const Icon(Icons.key)),
              validator: (v) {
                if (v!.isEmpty) {
                  return "Enter your email";
                } else {
                  return null;
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () => Get.to(const Home()),
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            gradient: AppWidgets.buildLinearGradient(),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 43,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .60,
                child: const Center(
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColor.white,
                    ),
                  ),
                ),
              ),
              Container(
                width: 43,
                height: 43,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColor.secColor.withOpacity(0.4),
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: AppColor.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

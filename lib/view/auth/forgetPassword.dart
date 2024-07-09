import 'dart:developer';

import 'package:crm/controller/auth_controller/auth_controller.dart';
import 'package:crm/utility/utility.dart';
import 'package:crm/view/auth/signin.dart';
import 'package:crm/view_controller/appWidgets.dart';
import 'package:crm/view_controller/commonWidget.dart';
import 'package:crm/view_controller/snackbar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AppWidget(
      appBarOnBack: () => Get.back(),
      appBarTitle: "Forget password",
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
                    "Please enter your email address and we will send you a code to your email to reset the password.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black, fontSize: 16),
                  ),
                )),
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: email,
              decoration: InputDecoration(
                  hintText: "Enter your email address",
                  contentPadding: const EdgeInsets.only(left: 25, right: 25, top: 17, bottom: 17),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(width: 1, color: AppColor.borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: const BorderSide(width: 1, color: AppColor.borderSelectColor),
                  ),
                  suffixIcon: const Icon(Icons.email_outlined)),
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
        onTap: () => _forgetPassword(),
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
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Icon(
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

  bool isLoading = false;
  void _forgetPassword() async {
    setState(() => isLoading = true);
    var res = await AuthController.forgetPasswordEmailSend(email: email.text);
    log(res.body);
    if (res.statusCode == 200) {
      _showMyDialog();
    } else {
      AppSnackbar.appSnackbar("Something went wrong.", Colors.red, context);
    }
    setState(() => isLoading = false);
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reset link send.'),
          content: const SingleChildScrollView(
              child: Center(
            child: Text('Please check your email address and we will send you a '
                'link to your email to reset the password '),
          )),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context, MaterialPageRoute(builder: (context) => const SignIn()), (route) => false);
              },
            ),
          ],
        );
      },
    );
  }
}

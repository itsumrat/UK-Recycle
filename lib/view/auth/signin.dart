// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:crm/controller/auth_controller/auth_controller.dart';
import 'package:crm/utility/app_const.dart';
import 'package:crm/utility/utility.dart';
import 'package:crm/view/auth/forgetPassword.dart';
import 'package:crm/view/home/home.dart';
import 'package:crm/view_controller/appWidgets.dart';
import 'package:crm/view_controller/commonWidget.dart';
import 'package:crm/view_controller/snackbar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _signInKey = GlobalKey<FormState>();

  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppWidget(
        appBarOnBack: () {},
        showBottomBar: false,
        appBarTitle: "Sign In",
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _signInKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 140,
                    height: 140,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset("assets/images/logo.png"),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                      hintText: "Email",
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
                      return "Username must not be empty";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  obscureText: true,
                  controller: password,
                  decoration: InputDecoration(
                      hintText: "Enter your password",
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
                      return "Enter your password.";
                    } else {
                      return null;
                    }
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Get.to(const ForgetPassword()),
                    child: const Text(
                      "Forget password?",
                      style: TextStyle(fontSize: 14, color: AppColor.borderColor, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () => _login(),
                  child: Container(
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
                              "Login",
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
                          child: loading
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
                )
              ],
            ),
          ),
        ));
  }

  //bool for loading
  bool loading = false;
  _login() async {
    if (_signInKey.currentState!.validate()) {
      try {
        setState(() => loading = true);
        var res = await AuthController.login(email: email.text, password: password.text);
        if (res.statusCode == 200) {
          if (jsonDecode(res.body)["type"] == AppConst.adminRole) {
            setState(() => loading = false);
            AppSnackbar.appSnackbar("Admin can not login.", Colors.red, context);
          } else {
            Get.to(const Home());
            AppSnackbar.appSnackbar("You are login as a ${jsonDecode(res.body)["type"]}", Colors.green, context);
          }
        } else {
          AppSnackbar.appSnackbar("${jsonDecode(res.body)["message"]}", Colors.red, context);
        }
      } catch (e) {
        AppSnackbar.appSnackbar("$e", Colors.red, context);
        print(e);
        setState(() => loading = false);
      }
      setState(() => loading = false);
    }
  }
}

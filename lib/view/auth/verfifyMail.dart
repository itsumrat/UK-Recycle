import 'package:crm/utility/utility.dart';
import 'package:crm/view_controller/appWidgets.dart';
import 'package:crm/view_controller/commonWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'add_new_password.dart';

class VerifiyEmail extends StatefulWidget {
  const VerifiyEmail({super.key});

  @override
  State<VerifiyEmail> createState() => _VerifiyEmailState();
}

class _VerifiyEmailState extends State<VerifiyEmail> {
  final email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AppWidget(
      appBarOnBack: ()=>Get.back(),
      appBarTitle: "Forget password",
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children:  [
            SizedBox(height: MediaQuery.of(context).size.height*.07,),
            SizedBox(
                width: MediaQuery.of(context).size.width*.70,
                child: const Center(
                  child: Text("Please enter your email address and we will send you a code to your phoen to rest the password.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                        fontSize: 16
                    ),
                  ),
                )),

            const SizedBox(height: 50,),
            PinCodeTextField(
              length: 4,
              obscureText: false,
              animationType: AnimationType.fade,
              keyboardType: TextInputType.number,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                borderWidth: 1,
                fieldHeight: 66,
                fieldWidth: 58,
                activeFillColor: Colors.white,
                inactiveFillColor: const Color(0xffEDEDED).withOpacity(0.61),
                inactiveColor:const Color(0xffEDEDED).withOpacity(0.61),
                activeColor: Colors.white,
                selectedFillColor: Colors.white,
                selectedBorderWidth: 1,
                selectedColor: AppColor.mainColor,
              ),
              animationDuration: const Duration(milliseconds: 300),
              backgroundColor: Colors.white,
              enableActiveFill: true,
              cursorColor: Colors.black,
              validator: (String? value) {
                if (value?.isEmpty ?? true) {
                  return 'Enter OTP here';
                }
                return null;
              },
              onCompleted: (v) {
                print("Completed $v");

              },
              onChanged: (value) {
                print(value);
                setState(() {});
              },
              beforeTextPaste: (text) {
                print("Allowing to paste $text");
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
              appContext: context,
            ),
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: ()=>Get.to(const AddNewPassword()),
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
              const SizedBox(width: 43,),
              SizedBox(
                width: MediaQuery.of(context).size.width*.60,
                child: const Center(
                  child: Text("Continue",
                    style: TextStyle(
                      fontSize: 16, color: AppColor.white,
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
                child:  const Icon(Icons.arrow_forward, color: AppColor.white,),
              )
            ],
          ),
        ),
      ),
    );
  }
}


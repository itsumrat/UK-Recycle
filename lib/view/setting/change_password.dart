import 'package:crm/controller/auth_controller/auth_controller.dart';import 'package:crm/utility/utility.dart';import 'package:crm/view/appBottomNavigationBar.dart';import 'package:crm/view/auth/signin.dart';import 'package:crm/view/profile/profile.dart';import 'package:crm/view_controller/appWidgets.dart';import 'package:crm/view_controller/snackbar_controller.dart';import 'package:flutter/material.dart';import 'package:get/get.dart';class ChangePassword extends StatefulWidget {  const ChangePassword({Key? key}) : super(key: key);  @override  State<ChangePassword> createState() => _ChangePasswordState();}class _ChangePasswordState extends State<ChangePassword> {  final current_password = TextEditingController();  final new_password = TextEditingController();  @override  Widget build(BuildContext context) {    return Container(      color: Colors.white,      child: SafeArea(        child: Scaffold(          backgroundColor: Colors.white,          body: SingleChildScrollView(            padding: EdgeInsets.all(20),            child: Column(              children: [                SizedBox(height: 20,),                Text("Change Password",                  style: TextStyle(                      fontWeight: FontWeight.w600,                      color: Colors.black,                      fontSize: 30                  ),                ),                SizedBox(height: 30,),                Padding(                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),                  child: Column(                    mainAxisAlignment: MainAxisAlignment.start,                    crossAxisAlignment: CrossAxisAlignment.start,                    children: [                      Text("Current Password",                        style: TextStyle(                            fontSize: 14,                            fontWeight: FontWeight.w600                        ),                      ),                      SizedBox(height: 10,),                      TextFormField(                        obscureText: true,                        controller: current_password,                        decoration: InputDecoration(                          hintText: "Current Password",                          contentPadding: EdgeInsets.only(left:                          25, right: 25, top: 10, bottom: 10),                          enabledBorder: OutlineInputBorder(                            borderRadius: BorderRadius.circular(5),                            borderSide: BorderSide(width: 1, color: AppColor.borderColor),                          ),                          focusedBorder: OutlineInputBorder(                            borderRadius: BorderRadius.circular(5),                            borderSide: BorderSide(width: 1, color: AppColor.borderSelectColor),                          ),                        ),                        validator: (v){                          if(v!.isEmpty){                            return "Address must not be empty";                          }else                            return null;                        },                      ),                    ],                  ),                ),                Padding(                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),                  child: Column(                    mainAxisAlignment: MainAxisAlignment.start,                    crossAxisAlignment: CrossAxisAlignment.start,                    children: [                      Text("New Password",                        style: TextStyle(                            fontSize: 14,                            fontWeight: FontWeight.w600                        ),                      ),                      SizedBox(height: 10,),                      TextFormField(                        obscureText: true,                        controller: new_password,                        decoration: InputDecoration(                          hintText: "New Password",                          contentPadding: EdgeInsets.only(left:                          25, right: 25, top: 10, bottom: 10),                          enabledBorder: OutlineInputBorder(                            borderRadius: BorderRadius.circular(5),                            borderSide: BorderSide(width: 1, color: AppColor.borderColor),                          ),                          focusedBorder: OutlineInputBorder(                            borderRadius: BorderRadius.circular(5),                            borderSide: BorderSide(width: 1, color: AppColor.borderSelectColor),                          ),                        ),                        validator: (v){                          if(v!.isEmpty){                            return "Address must not be empty";                          }else                            return null;                        },                      ),                    ],                  ),                ),                SizedBox(height: 50,),                InkWell(                  onTap: ()=>_changePassword(),                  child: Container(                    height: 50,                    margin: EdgeInsets.only(left: 70, right: 70),                    decoration: BoxDecoration(                        gradient: AppWidgets.buildRedLinearGradient(),                        borderRadius: BorderRadius.circular(10)                    ),                    child: Row(                      mainAxisAlignment: MainAxisAlignment.center,                      children: [                        isLoading? CircularProgressIndicator(color: Colors                            .white,) : Text                          ("Change "                          "Password",                          style: TextStyle(                              fontSize: 17, color: Colors.white                          ),                        ),                      ],                    ),                  ),                ),              ],            ),          ),        ),      ),    );  }  bool isLoading = false;  _changePassword() async{    setState(() => isLoading = true);    var res = await AuthController.changePassword(current_password:    current_password.text, new_password: new_password.text);    if(res.statusCode == 200){      AppSnackbar.appSnackbar("Password changed.", Colors.green, context);      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SignIn()), (route) => false);    }else{      AppSnackbar.appSnackbar("Old password invalid.", Colors.red, context);    }    setState(() => isLoading = false);  }}
import 'package:crm/utility/utility.dart';
import 'package:crm/view/flash_screen/sFalsh_screen.dart';
import 'package:crm/view/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlashScreen extends StatefulWidget {
  const FlashScreen({super.key});

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkToken();
  }

  void _checkToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString("token") != null) {
      Get.offAll(const Home());
    } else {
      Future.delayed(const Duration(milliseconds: 1500), () {
        // 5s over, navigate to a new page
        Get.offAll(const SFlashScreen());
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.white,
          body: Center(
            child: Image.asset(
              "assets/images/logo.png",
              height: 200,
              width: 200,
            ),
          ),

          // body: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Center(child: Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 120,)),
          //     SizedBox(height: 10,),
          //     Text("UK TEXTILE AND RECYCLING",
          //       style: TextStyle(
          //         fontSize: 30,
          //         fontWeight: FontWeight.w600,
          //         color: Colors.white
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ),
    );
  }
}

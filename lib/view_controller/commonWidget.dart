import 'package:crm/utility/utility.dart';
import 'package:crm/view/appBottomNavigationBar.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final String? appBarTitle;
  final VoidCallback? appBarOnBack;
  final double? textSize;
  final bool showBottomBar;
  const AppWidget({
    super.key,
    required this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.appBarTitle,
    this.appBarOnBack,
    this.textSize = 16,
    this.showBottomBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColor.white,
            appBar: AppBar(
              backgroundColor: AppColor.white,
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                onPressed: appBarOnBack,
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColor.black,
                ),
              ),
              title: Text(
                "$appBarTitle",
                style: TextStyle(fontSize: textSize, color: AppColor.black, fontWeight: FontWeight.w500),
              ),
            ),
            body: body,
            bottomNavigationBar: showBottomBar
                ? bottomNavigationBar ??
                    const AppBottomNavigation(
                      pageIndex: 0,
                    )
                : null,
            floatingActionButton: floatingActionButton,
          ),
        ),
      ),
    );
  }
}

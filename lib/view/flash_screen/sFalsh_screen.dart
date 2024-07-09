import 'package:crm/utility/utility.dart';
import 'package:crm/view/auth/signin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboarding/onboarding.dart';

class SFlashScreen extends StatefulWidget {
  const SFlashScreen({super.key});

  @override
  State<SFlashScreen> createState() => _SFlashScreenState();
}

class _SFlashScreenState extends State<SFlashScreen> {
  late Material materialButton;
  late int index;
  final onboardingPagesList = [];

  @override
  void initState() {
    super.initState();
    index = 0;
  }

  InkWell _skipButton({void Function(int)? setIndex}) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Get.offAll(const SignIn());
      },
      child: const Text(
        'Skip',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: Colors.black),
      ),
    );
  }

  Material get _signupButton {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColor.mainColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {},
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Sign up',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Onboarding(
        swipeableBody: [
          buildPageModel(
              context: context,
              title: "Title comes here",
              subTitile: "Don't miss out our flash sale and daily spclais with great discounts.",
              image: 'assets/images/sf1.jpg'),
          buildPageModel(
              context: context,
              title: "Title comes here",
              subTitile: "Don't miss out our flash sale and daily spclais with great discounts.",
              image: 'assets/images/sf2.jpg'),
          buildPageModel(
              context: context,
              title: "Title comes here",
              subTitile: "Don't miss out our flash sale and daily spclais with great discounts.",
              image: 'assets/images/sf3.jpg'),
        ],
        onPageChanges: (_, __, pageIndex, ___) {
          index = pageIndex;
        },
        startIndex: 0,
        buildFooter: (context, netDragDistance, pagesLength, currentIndex, setIndex, slideDirection) {
          return DecoratedBox(
            position: DecorationPosition.background,
            decoration: BoxDecoration(
              color: AppColor.white,
              border: Border.all(
                width: 0.0,
                color: AppColor.white,
              ),
            ),
            child: ColoredBox(
              color: AppColor.white,
              child: Padding(
                padding: const EdgeInsets.all(45.0),
                child: index == pagesLength - 1
                    ? InkWell(
                        onTap: () => Get.offAll(const SignIn()),
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          margin: const EdgeInsets.only(left: 50, right: 50),
                          decoration: BoxDecoration(color: AppColor.mainColor, borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Text(
                              "Sign In",
                              style: TextStyle(fontSize: 17, color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          index != pagesLength - 1 ? _skipButton(setIndex: setIndex) : const Center(),
                          // Indic(
                          //   netDragPercent: dragDistance,
                          //   pagesLength: pagesLength,
                          //   indicator: Indicator(
                          //     activeIndicator: const ActiveIndicator(
                          //       color: AppColor.mainColor,
                          //     ),
                          //     indicatorDesign: IndicatorDesign.polygon(
                          //       polygonDesign: PolygonDesign(
                          //         polygon: DesignType.polygon_circle,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          Indicator<LinePainter>(
                            painter: LinePainter(
                              slideDirection: slideDirection,
                              currentPageIndex: currentIndex,
                              pagesLength: pagesLength,
                              netDragPercent: netDragDistance,
                              activePainter: Paint()..color = AppColor.mainColor,
                              inactivePainter: Paint()..color = AppColor.mainColor.withOpacity(0.5),
                              lineWidth: 20,
                              translate: false,
                            ),
                          ),
                          const SizedBox(
                            width: 50,
                          )
                        ],
                      ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildPageModel({
    required BuildContext context,
    required String title,
    required String subTitile,
    required String image,
  }) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(
          width: 0.0,
          color: AppColor.mainColor,
        ),
      ),
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 300,
              decoration: const BoxDecoration(),
              child: Container(
                height: 200,
                padding: const EdgeInsets.all(30),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    )),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 45.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          title,
                          style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 30),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 20.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          subTitile,
                          //"Don't miss out our flash sale and daily spclais with great discounts.",
                          style: const TextStyle(fontWeight: FontWeight.w300, color: Colors.black, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

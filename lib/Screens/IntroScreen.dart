import 'package:javizen/Helpers/ColorHelpers.dart';
import 'package:javizen/Screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  int? page;
  String text =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries";
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelpers.backGroundColor,
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 5,
              child: PageView(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (page) {
                  setState(() {
                    this.page = page;
                  });
                  tabController.animateTo(page,
                      duration: const Duration(milliseconds: 175),
                      curve: Curves.easeIn);
                },
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset("assets/anim/98896-forex-chart.json"),
                      SizedBox(
                        height: Get.height * .05,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * .05),
                        child: Text(
                          text,
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                          "assets/anim/88385-cryptocurrency-investement.json"),
                      SizedBox(
                        height: Get.height * .05,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * .05),
                        child: Text(
                          text,
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset("assets/anim/86719-cryptocurrency.json"),
                      SizedBox(
                        height: Get.height * .05,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * .05),
                        child: Text(
                          text,
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: TabPageSelector(
                color: Colors.white,
                indicatorSize: Get.width * .025,
                controller: tabController,
                selectedColor: Colors.yellow,
              ),
            ),
            (page != 2)
                ? Flexible(flex: 1, child: Container())
                : Flexible(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          Get.off(const HomeScreen(),
                              transition: Transition.fadeIn,
                              duration: const Duration(milliseconds: 500));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              top: Get.height * .05, right: Get.width * .05),
                          height: Get.height * .05,
                          width: Get.width * .3,
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Center(
                            child: Text(
                              "Done",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

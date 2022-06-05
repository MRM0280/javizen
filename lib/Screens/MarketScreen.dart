import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javizen/Controllers/MarketController.dart';
import 'package:javizen/Helpers/ColorHelpers.dart';

import '../Controllers/MainController.dart';
import 'DerivativesScreen.dart';

class MarketScreen extends StatelessWidget {
  MarketScreen({Key? key}) : super(key: key);
  MarketController controller = Get.put(MarketController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorHelpers.backGroundColor,
        body: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Obx(
            () {
              return Column(
                children: [
                  SizedBox(
                    height: Get.height * .05,
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.sticky_note_2_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: Get.width * .025,
                          ),
                          const Icon(
                            Icons.search,
                             color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  _buildTabBar(),
                  _buildTabBarView(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  _buildTabBar() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: SizedBox(
        height: Get.height * .05,
        width: Get.width * .55,
        child: TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          controller: controller.tabController,
          indicatorColor: Colors.orange,
          unselectedLabelColor: Colors.white,
          unselectedLabelStyle: const TextStyle(color: Colors.white),
          tabs: const [
            Text(
              "Derivatives",
              style: TextStyle(color: Colors.orange),
            ),
            Text(
              "Spot",
              style: TextStyle(color: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }

  _buildTabBarView() {
    return Expanded(
      child: TabBarView(
        controller: controller.tabController,
        children: [
          _buildSubTabBar(),
          _buildSubTabBar(),
        ],
      ),
    );
  }

  _buildSubTabBar() {
    if (Get.find<MainController>().loading.isFalse) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.orange,
        ),
      );
    }
    return Column(
      children: [
        // _buildSubCategory(),
        const Divider(
          color: Colors.white,
        ),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: Get.find<MainController>().coinList.length,
            itemBuilder: itemBuilder,
          ),
        ),
      ],
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    var item = Get.find<MainController>().coinList[index];
    return Container(
      height: Get.height * .065,
      width: Get.width,
      margin: EdgeInsets.symmetric(vertical: Get.height * .005),
      padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
      child: TextButton(
        onPressed: () {
          Get.to(DerivativesScreen());
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                  SizedBox(
                    width: Get.width * .05,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name!,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      const Text(
                        "spot",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.last!,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                  ),
                  Text(
                    item.volume!.split(".").first,
                    style: const TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: Get.width * .08,
            ),
            Container(
              height: Get.height * .04,
              width: Get.width * .15,
              decoration: BoxDecoration(
                color: item.change!.startsWith("-") ? Colors.red : Colors.green,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                  child: AutoSizeText(
                item.change!,
                minFontSize: 6,
                maxFontSize: 12,
                style: const TextStyle(color: Colors.white),
              )),
            ),
          ],
        ),
      ),
    );
  }
}

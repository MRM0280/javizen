import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javizen/Controllers/MainController.dart';
import 'package:javizen/Helpers/ColorHelpers.dart';
import 'package:javizen/Helpers/PrefHelpers.dart';
import 'package:javizen/Helpers/ViewHelpers.dart';
import 'package:javizen/Widgets/ChartWidget.dart';
import 'package:javizen/bloc/ProfileBloc.dart';

import 'DerivativesScreen.dart';
import 'Login&RegisterScreen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  MainController controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorHelpers.backGroundColor,
        body: _buildMainPage(),
      ),
    );
  }

  _buildAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Get.width * .025, vertical: 1),
      height: Get.height * .05,
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () async {
              if (await PrefHelpers.getToken() != null) {
                _buildProfileModal();
              } else {
                ViewHelper.showErrorDialog(Get.context!, "Please login to app");
              }
            },
            child: const CircleAvatar(
              backgroundImage: AssetImage("assets/images/image.png"),
            ),
          ),
          _buildSearchField(),
          Icon(
            Icons.email,
            color: Colors.white12,
            size: Get.width * .08,
          ),
        ],
      ),
    );
  }

  _buildSearchField() {
    return SizedBox(
      height: Get.height * .05,
      width: Get.width * .6,
      child: TextFormField(
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            fillColor: Colors.white12,
            filled: true,
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.grey,
            ),
            hintText: "Search coin",
            hintStyle: const TextStyle(color: Colors.grey),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.orange, width: 1),
            )),
      ),
    );
  }

  _buildBody() {
    return GetBuilder<MainController>(
      builder: (context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(top: Get.height * .05),
            child: SizedBox(
              height: Get.height,
              width: double.maxFinite,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: Get.height * .03),
                    height: Get.height * .25,
                    width: Get.width,
                    child: const LineChartSample7(),
                  ),
                  if (getProfileBlocInstance.profile?.user?.email != null)
                    SizedBox(
                      height: Get.height * .025,
                    )
                  else
                    _buildLoginBtn(),
                  _buildTabBarCoinList(),
                  _buildTabBarView(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _buildTabBarCoinList() {
    return Container(
      height: Get.height * .05,
      width: Get.width,
      color: Colors.white12,
      child: TabBar(
        controller: controller.tabController,
        indicatorColor: Colors.orange,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: const [
          Text(
            "Hot",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "Gainers",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "New",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  _buildTabBarView() {
    return Expanded(
      child: Obx(() {
        return TabBarView(
          controller: controller.tabController,
          children: [
            _buildSubTabBar(),
            _buildSubTabBar(),
            _buildSubTabBar(),
          ],
        );
      }),
    );
  }

  _buildSubTabBar() {
    if (controller.loading.isFalse) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.orange,
        ),
      );
    }
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: controller.coinList.length,
            itemBuilder: itemBuilder,
          ),
        ),
      ],
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    var item = controller.coinList[index];
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name!,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  const Text(
                    "spot",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            SizedBox(width: Get.width * .15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.last!,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  Text(
                    item.volume!.split(".").first,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
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

  _buildMainPage() {
    return Stack(
      children: [
        _buildAppBar(),
        _buildBody(),
      ],
    );
  }

  _buildSubCategory() {
    return SizedBox(
      height: Get.height * .05,
      width: Get.width,
      child: GetBuilder<MainController>(
        builder: (category) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: category.listOfCat.length,
            itemBuilder: (_, index) {
              CatModel item = category.listOfCat[index];
              return GestureDetector(
                onTap: () {
                  for (var element in category.listOfCat) {
                    element.isSelected?.value = false;
                  }
                  item.isSelected?.value = true;
                  category.update();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width * .05, vertical: 5),
                      child: Text(
                        item.title!,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    item.isSelected?.value != true
                        ? Container()
                        : AnimatedContainer(
                            duration: const Duration(milliseconds: 275),
                            height: 2,
                            width: Get.width * .2,
                            color: Colors.orange,
                          ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  _buildLoginBtn() {
    return GestureDetector(
      onTap: () {
        Get.to(LoginAndRegisterScreen());
      },
      child: Container(
        height: Get.height * .05,
        width: Get.width,
        margin: EdgeInsets.symmetric(
            horizontal: Get.width * .05, vertical: Get.height * .015),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Register / Sing in to get bonus!"),
            SizedBox(
              width: Get.width * .03,
            ),
            const Icon(Icons.arrow_forward)
          ],
        ),
      ),
    );
  }

  _buildProfileModal() {
    return showCupertinoModalPopup<void>(
      context: Get.context!,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Profile Settings'),
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.red),
          ),
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Edit Profile'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              PrefHelpers.logOut();
            },
            child: const Text('Log Out'),
          )
        ],
      ),
    );
  }
}

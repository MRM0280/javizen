import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:javizen/Helpers/ViewHelpers.dart';
import 'package:javizen/Models/DepositModel.dart';
import 'package:javizen/Models/WalletModel.dart';
import 'package:javizen/Plugins/loading/src/widgets/indicator.dart';
import 'package:javizen/Screens/WithdrawScreen.dart';

import '../Controllers/AssetsController.dart';
import '../Helpers/ColorHelpers.dart';

class AssetsScreen extends StatelessWidget {
  AssetsScreen({Key? key}) : super(key: key);

  AssetsController controller = Get.put(AssetsController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorHelpers.backGroundColor,
        body: Container(
          height: Get.height,
          width: Get.width,
          child: Column(
            children: [
              SizedBox(
                height: Get.height * .025,
              ),
              _buildTabBar(),
              _buildTabView(),
            ],
          ),
        ),
      ),
    );
  }

  _buildTabBar() {
    return SizedBox(
      height: Get.height * .05,
      width: double.maxFinite,
      child: TabBar(
        physics: const BouncingScrollPhysics(),
        indicatorSize: TabBarIndicatorSize.tab,
        controller: controller.tabController,
        indicatorColor: Colors.orange,
        tabs: [
          Text(
            "Wallet",
            style: TextStyle(color: Colors.orange, fontSize: Get.width * .04),
          ),
          Text(
            "History",
            style: TextStyle(color: Colors.orange, fontSize: Get.width * .04),
          ),
        ],
      ),
    );
  }

  _buildTabView() {
    return Expanded(
      child: TabBarView(
        physics: const BouncingScrollPhysics(),
        controller: controller.tabController,
        children: [
          walletTab(),
          historyTab(),
        ],
      ),
    );
  }

  walletTab() {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Obx(() {
        if (controller.loading.isFalse) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.orange,
            ),
          );
        }
        return Column(
          children: [
            SizedBox(
              height: Get.height * .025,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: controller.walletList.length,
                itemBuilder: walletItemBuilder,
              ),
            ),
          ],
        );
      }),
    );
  }

  historyTab() {
    return SizedBox(
        height: Get.height,
        width: Get.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Deposit',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.orange,
                  ),
                ],
              ),
              Obx(() {
                if (controller.depositLoading.isFalse) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      const Center(
                        child: CircularProgressIndicator(
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  );
                }
                return controller.depositList.isEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Empty',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white.withOpacity(0.2)),
                          ),
                        ],
                      )
                    : ListView.builder(
                        itemCount: controller.depositList.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => historyItemBuilder(
                            context, controller.depositList[index]),
                      );
              }),
              SizedBox(
                height: Get.height * 0.05,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Withdraw',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.orange,
                  ),
                ],
              ),
              Obx(() {
                if (controller.withdrawLoading.isFalse) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      const Center(
                        child: CircularProgressIndicator(
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  );
                }
                return controller.withdrawList.isEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Empty',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white.withOpacity(0.2)),
                          ),
                        ],
                      )
                    : ListView.builder(
                        itemCount: controller.withdrawList.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => historyItemBuilder(
                            context, controller.withdrawList[index]),
                      );
              }),
            ],
          ),
        ));
  }

  Widget historyItemBuilder(BuildContext context, item) {
    return Container(
      height: Get.height * .07,
      width: Get.width,
      margin: EdgeInsets.symmetric(
        vertical: Get.height * .005,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(item.logo),
                    ),
                    SizedBox(
                      width: Get.width * .025,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.symbol,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          item.currency,
                          style: const TextStyle(
                              color: Colors.white54, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.amount.toString(),
                    style: TextStyle(fontSize: Get.width * .03),
                  ),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  item.status == 'confirmed'
                      ? Container(
                          height: Get.height * .035,
                          width: Get.width * .15,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5)),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 20,
                          ),
                        )
                      : Container(
                          height: Get.height * .035,
                          width: Get.width * .15,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(5)),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                ],
              ),
            ],
          ),
          const Divider(color: Colors.white),
        ],
      ),
    );
  }

  Widget walletItemBuilder(BuildContext context, int index) {
    WalletModel item = controller.walletList[index];
    return Container(
      height: Get.height * .07,
      width: Get.width,
      margin: EdgeInsets.symmetric(
        horizontal: Get.width * .02,
        vertical: Get.height * .005,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(item.logo!),
                    ),
                    SizedBox(
                      width: Get.width * .025,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.symbol!,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          item.currency!,
                          style: const TextStyle(
                              color: Colors.white54, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      item.balanceInWalletUsdt!,
                      style: TextStyle(fontSize: Get.width * .03),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Container(
                      height: Get.height * .035,
                      width: Get.width * .15,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(5)),
                      child: TextButton(
                        style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.black38)),
                        onPressed: () {
                          controller.getAddress(item.symbol!);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: Get.height,
                                    width: Get.width,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            height: Get.height * .05,
                                            width: Get.width * .2,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color:
                                                  ColorHelpers.backGroundColor,
                                            ),
                                            child: FittedBox(
                                              child: SpinKitThreeBounce(
                                                  color: Colors.orange),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                          Future.delayed(Duration(seconds: 5)).then((value) {
                            Navigator.pop(context);
                            if (controller.address.isNotEmpty) {
                              showAddress(context, controller.address.value);
                            } else {
                              ViewHelper.showErrorDialog(
                                  context, 'Please try again');
                            }
                          });
                        },
                        child: Center(
                          child: Text(
                            "Deposit",
                            style: TextStyle(
                                color: Colors.white, fontSize: Get.width * .03),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * .015,
                    ),
                    Container(
                      height: Get.height * .035,
                      width: Get.width * .15,
                      decoration: BoxDecoration(
                          color:
                              item.address == null ? Colors.grey : Colors.red,
                          borderRadius: BorderRadius.circular(5)),
                      child: TextButton(
                        style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.black38)),
                        onPressed: () {
                          // if (item.address != null) {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) => WithdrawScreen(
                          //             symbol: item.symbol!,
                          //             address: item.address!),
                          //       ));
                          // }

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WithdrawScreen(
                                    symbol: item.symbol!,
                                    address: 'dgrfgfdgf'),
                              ));
                        },
                        child: Center(
                          child: Text(
                            "Withdraw",
                            style: TextStyle(
                                color: Colors.white, fontSize: Get.width * .03),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(color: Colors.white),
        ],
      ),
    );
  }

  void showAddress(BuildContext context, String address) {
    showModalBottomSheet(
        context: context,
        backgroundColor: ColorHelpers.backGroundColor,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  address,
                  style: const TextStyle(color: Colors.orange, fontSize: 15),
                ),
                InkWell(
                  onTap: () {
                    Clipboard.setData(new ClipboardData(text: address));
                    Navigator.pop(context);
                    ViewHelper.showSuccessDialog(context, 'Address Copied');
                  },
                  child: Icon(
                    Icons.copy,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          );
        });
  }
}

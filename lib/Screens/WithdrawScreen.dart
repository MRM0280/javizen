import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:javizen/Helpers/WidgetHelpers.dart';

import '../Controllers/AssetsController.dart';
import '../Helpers/ColorHelpers.dart';
import '../Helpers/ViewHelpers.dart';

class WithdrawScreen extends StatelessWidget {
  final String symbol;
  final String address;

  WithdrawScreen({this.symbol = '', this.address = ''});

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * .02,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Withdraw',
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: Get.height * .01,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  color: Colors.orange,
                  thickness: 2,
                ),
              ),
              SizedBox(
                height: Get.height * .06,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Amount',
                  style: TextStyle(
                      fontSize: 14, color: Colors.white.withOpacity(0.6)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              WidgetHelpers.buildTextField(
                  controller: controller.amountController,
                  textType: TextInputType.number),
              SizedBox(
                height: Get.height * .1,
              ),
              Container(
                height: Get.height * .06,
                width: Get.width,
                margin: EdgeInsets.symmetric(
                    horizontal: Get.width * .05, vertical: Get.height * .015),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  onPressed: () {
                    controller.withdraw(address, symbol);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              height: Get.height,
                              width: Get.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      height: Get.height * .05,
                                      width: Get.width * .2,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: ColorHelpers.backGroundColor,
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
                      if (controller.withdrawPostLoading.isTrue) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        ViewHelper.showSuccessDialog(context, 'Withdraw done');
                      } else {
                        Navigator.pop(context);
                        ViewHelper.showErrorDialog(context, 'Please try again');
                      }
                    });
                  },
                  child: const Center(
                    child: Text(
                      "Continue",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

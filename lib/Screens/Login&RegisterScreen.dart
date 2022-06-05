import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:get/get.dart';
import 'package:javizen/Controllers/LoginAndRegisterController.dart';
import 'package:javizen/Helpers/ColorHelpers.dart';
import 'package:javizen/Helpers/ViewHelpers.dart';
import 'package:javizen/Helpers/WidgetHelpers.dart';

import '../Plugins/loading/src/easy_loading.dart';

class LoginAndRegisterScreen extends StatelessWidget {
  LoginAndRegisterScreen({Key? key}) : super(key: key);

  LoginAndRegisterController controller = Get.put(LoginAndRegisterController());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorHelpers.backGroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildAppBar(),
              SizedBox(
                height: Get.height * .025,
              ),
              _buildTabBar(),
              SizedBox(
                height: Get.height * .06,
              ),
              SizedBox(
                height: Get.height,
                width: Get.width,
                // padding: EdgeInsets.only(top: Get.height * .02),
                child:
                    TabBarView(controller: controller.tabController, children: [
                  _buildBody(),
                  _buildLogin(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildBody() {
    return Obx(() {
      return Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(
              height: Get.height * .02,
            ),
            WidgetHelpers.buildTextField(
                text: "Email",
                onChange: (value) {},
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your email";
                  } else if (!GetUtils.isEmail(value)) {
                    return "Please enter valid email";
                  }
                },
                controller: controller.emailController),
            SizedBox(
              height: Get.height * .05,
            ),
            WidgetHelpers.buildTextField(
                focusNode: (hasFocus) {
                  if (hasFocus) {
                    controller.passwordCheckerIsOpen.value = true;
                  } else if (controller.passController.text.isEmpty) {
                    controller.passwordCheckerIsOpen.value = false;
                  }
                },
                text: "Password",
                onChange: (value) {},
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your password";
                  }
                },
                controller: controller.passController),
            controller.passwordCheckerIsOpen.isFalse
                ? Container()
                : _buildPasswordChecker(),
            SizedBox(
              height: Get.height * .05,
            ),
            WidgetHelpers.buildTextField(
                text: "Confirm Password",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your Password Confirmation";
                  } else if (controller.passController.text != value) {
                    return "Password Confirmation is Incorrect";
                  }
                },
                controller: controller.pass2Controller),
            SizedBox(
              height: Get.height * .05,
            ),
            _buildCheckBox(),
            SizedBox(
              height: Get.height * .01,
            ),
            _buildBtn(),
          ],
        ),
      );
    });
  }

  _buildTabBar() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: SizedBox(
        height: Get.height * .05,
        width: Get.width * .5,
        child: TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          controller: controller.tabController,
          indicatorColor: Colors.orange,
          unselectedLabelColor: Colors.white,
          unselectedLabelStyle: const TextStyle(color: Colors.white),
          tabs: const [
            Text(
              "Sing Up",
              style: TextStyle(color: Colors.orange),
            ),
            Text(
              "Sing In",
              style: TextStyle(color: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }

  _buildAppBar() {
    return Container(
      height: Get.height * .15,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: Get.height * .01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Sign in",
                    style: TextStyle(color: Colors.orange, fontSize: 18),
                  ))
            ],
          ),
          const Spacer(),
          const Text(
            "Let's get started",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ],
      ),
    );
  }

  _buildBtn() {
    return Container(
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
          if (controller.isCheck.isFalse &&
              formKey.currentState!.validate()) {
            ViewHelper.showErrorDialog(Get.context!, "Please accept the rules");
          } else if (formKey.currentState!.validate()) {
            controller.register();
            EasyLoading.show();
          }
        },
        child: const Center(
            child: Text(
          "Continue",
          style: TextStyle(color: Colors.black, fontSize: 16),
        )),
      ),
    );
  }

  _buildCheckBox() {
    return Obx(() {
      return Row(
        children: [
          SizedBox(
            width: Get.width * .02,
          ),
          Checkbox(
            checkColor: Colors.black,
            value: controller.isCheck.value,
            onChanged: (value) {
              controller.isCheck.value = value!;
            },
            fillColor: MaterialStateProperty.resolveWith(controller.getColor),
          ),
          const Text(
            "I have read and agree terms of service\n and privacy policy",
            maxLines: 2,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      );
    });
  }

  _buildPasswordChecker() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: Get.width * .05, top: Get.height * .02),
        child: FlutterPwValidator(
          controller: controller.passController,
          minLength: 6,
          uppercaseCharCount: 2,
          numericCharCount: 3,
          specialCharCount: 2,
          width: Get.width * .6,
          normalCharCount: 4,
          successColor: Colors.green,
          height: Get.height * .1,
          onFail: () {
            controller.passwordChecker.value = false;
          },
          onSuccess: () {
            controller.passwordCheckerIsOpen.value = true;
            controller.passwordChecker.value = true;
          },
          // onSuccess: yourCallbackFunction,
          // onFail: yourCallbackFunction
        ),
      ),
    );
  }

  _buildLogin() {
    return Form(
      key: formKey2,
      child: Column(
        children: [
          SizedBox(
            height: Get.height * .02,
          ),
          WidgetHelpers.buildTextField(
              text: "Email",
              onChange: (value) {},
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your email";
                }
              },
              controller: controller.emailLoginController),
          SizedBox(
            height: Get.height * .05,
          ),
          WidgetHelpers.buildTextField(
              text: "Password",
              onChange: (value) {},
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your password";
                }
              },
              controller: controller.passLoginController),
          SizedBox(
            height: Get.height * .05,
          ),
          _buildLoginBtn(),
        ],
      ),
    );
  }

  _buildLoginBtn() {
    return Container(
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
          if (formKey2.currentState!.validate()) {
            controller.getTokenAndLogin2();
            EasyLoading.show();
          }
        },
        child: const Center(
          child: Text(
            "Continue",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
      ),
    );
  }
}

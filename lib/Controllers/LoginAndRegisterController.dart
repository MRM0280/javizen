import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javizen/Helpers/PrefHelpers.dart';
import 'package:javizen/Helpers/RequestHelper.dart';
import 'package:javizen/Helpers/ViewHelpers.dart';
import 'package:javizen/Models/LoginModel.dart';

import '../Plugins/loading/src/easy_loading.dart';
import '../bloc/ProfileBloc.dart';

class LoginAndRegisterController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  RxBool isCheck = false.obs;
  RxBool passwordChecker = false.obs;
  RxBool passwordCheckerNode = false.obs;
  RxBool passwordCheckerIsOpen = false.obs;

  LoginModel? loginModel;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController pass2Controller = TextEditingController();
  TextEditingController emailLoginController = TextEditingController();
  TextEditingController passLoginController = TextEditingController();

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.orange;
    }
    return Colors.orange;
  }

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  @override
  void dispose() {
    tabController.dispose();
    emailController.clear();
    passController.clear();
    pass2Controller.clear();
    emailController.dispose();
    passController.dispose();
    pass2Controller.dispose();
    isCheck.value = false;
    passwordChecker.value = false;
    passwordCheckerNode.value = false;
    passwordCheckerIsOpen.value = false;
    isCheck.close();
    passwordCheckerIsOpen.close();
    passwordChecker.close();
    passwordCheckerNode.close();
    super.dispose();
  }

  register() {
    RequestHelper.register(
            email: emailController.text,
            password: passController.text,
            password_confirmation: pass2Controller.text,
            terms: isCheck.toString())
        .then(
      (value) {
        if (value.statusCode == 201) {
          getTokenAndLogin();
        } else {
          ViewHelper.showErrorDialog(
              Get.context!, "Please check the entered data");
        }
      },
    );
  }

  getTokenAndLogin() {
    RequestHelper.getTokenAndLogin(
            password: passController.text, email: emailController.text)
        .then(
      (value) {
        EasyLoading.dismiss();
        if (value.statusCode == 200) {
          getProfileBlocInstance.getProfile(LoginModel.fromJson(value.data2));
          PrefHelpers.setPassword(passController.text);
          PrefHelpers.setEmail(emailController.text);
          PrefHelpers.setToken(value.data2['token']);
          Get.offAllNamed("/homeScreen");
          ViewHelper.showSuccessDialog(Get.context!, "You have registered");
          update();
        } else {
          ViewHelper.showErrorDialog(Get.context!, "Please try again!");
          update();
        }
      },
    );
  }

  getTokenAndLogin2() {
    RequestHelper.getTokenAndLogin(
            password: passLoginController.text,
            email: emailLoginController.text)
        .then(
      (value) {
        EasyLoading.dismiss();
        if (value.statusCode == 200) {
          getProfileBlocInstance.getProfile(LoginModel.fromJson(value.data2));
          PrefHelpers.setPassword(passLoginController.text);
          PrefHelpers.setEmail(emailLoginController.text);
          PrefHelpers.setToken(value.data2['token']);
          Get.offAllNamed("/homeScreen");
          ViewHelper.showSuccessDialog(Get.context!, "You have registered");
          update();
        } else {
          ViewHelper.showErrorDialog(Get.context!, "Please try again!");
          update();
        }
      },
    );
  }
}
// 123456AAaa!!

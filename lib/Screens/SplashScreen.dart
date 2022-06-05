import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javizen/Helpers/ColorHelpers.dart';
import 'package:javizen/Helpers/PrefHelpers.dart';
import 'package:javizen/Helpers/ViewHelpers.dart';
import 'package:javizen/Models/LoginModel.dart';
import 'package:javizen/bloc/ProfileBloc.dart';
import 'package:lottie/lottie.dart';

import '../Helpers/RequestHelper.dart';
import '../Plugins/loading/src/easy_loading.dart';
import 'IntroScreen.dart';
import 'Login&RegisterScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    Future.delayed(const Duration(seconds: 2)).then((value)async {
      getDate();
    });
    super.initState();
  }

  getDate() async{
    if (await PrefHelpers.getToken() != null) {
      getTokenAndLogin();
    } else {
      Get.off(const IntroScreen(),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 500));
    }
  }

  getTokenAndLogin() async {
    RequestHelper.getTokenAndLogin(
            password: await PrefHelpers.getPassword(),
            email: await PrefHelpers.getEmail())
        .then(
      (value) {
        EasyLoading?.dismiss();
        if (value.statusCode == 200) {
          getProfileBlocInstance.getProfile(LoginModel.fromJson(value.data2));
          PrefHelpers.setToken(value.data2['token']);
          Get.offAllNamed("/homeScreen");
        } else {
          ViewHelper.showErrorDialog(Get.context!, "Please try again!");
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        color: ColorHelpers.backGroundColor,
        child: FadeTransition(
          opacity: _animation,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset("assets/images/logo.png"),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Lottie.asset("assets/anim/loading.json",
                    width: Get.width * .4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

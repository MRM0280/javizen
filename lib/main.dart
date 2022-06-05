import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:javizen/Screens/HomeScreen.dart';
import 'package:javizen/Screens/SplashScreen.dart';

import 'Plugins/loading/src/easy_loading.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  runApp(
    MediaQuery(
      data: const MediaQueryData(),
      child: GetMaterialApp(
        getPages: [
          GetPage(name: "/homeScreen", page: () => HomeScreen()),
        ],
        theme: ThemeData.dark(),
        defaultTransition: Transition.cupertino,
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        // home: HomeScreen(),
        home: const SplashScreen(),
      ),
    ),
  );
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle = EasyLoadingStyle.custom
    ..radius = 10.0
    ..userInteractions = false
    ..dismissOnTap = false
    ..indicatorSize = 30.0
    ..fontSize = 18.0
    ..progressColor = Colors.red
    ..backgroundColor = Colors.black54
    ..indicatorColor = Colors.orange
    ..textColor = Colors.black
    ..maskColor = Colors.orange
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = true
    ..dismissOnTap = true
    ..lineWidth = 50;
}

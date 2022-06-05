import 'package:bottom_navigation_view/bottom_navigation_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javizen/Helpers/ColorHelpers.dart';
import 'package:javizen/Helpers/PrefHelpers.dart';
import 'package:javizen/Screens/AssetsScreen.dart';
import 'package:javizen/Screens/Login&RegisterScreen.dart';

import 'DerivativesScreen.dart';
import 'MainScreen.dart';
import 'MarketScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final BottomNavigationController _controller;
  int selectedIndex = 0;

  @override
  void initState() {
    _controller = BottomNavigationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: _buildNavBar(),
        backgroundColor: ColorHelpers.backGroundColor,
        body: BottomNavigationView(
          controller: _controller,
          transitionType: BottomNavigationTransitionType.none,
          children: [
            MainScreen(),
            MarketScreen(),
            DerivativesScreen(),
            const Text("3"),
            AssetsScreen(),
          ],
        ),
      ),
    );
  }

  _buildNavBar() {
    return BottomNavigationIndexedBuilder(
      controller: _controller,
      builder: (context, index, child) {
        return BottomNavigationBar(
          backgroundColor: ColorHelpers.textFieldColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.orange,
          currentIndex: index,
          onTap: (index) async {
            if (await PrefHelpers.getToken() == null && index == 4) {
              Get.to(LoginAndRegisterScreen());
            } else {
              _controller.goTo(index);
            }
          },
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                label: 'Home', icon: Icon(Icons.home_outlined)),
            BottomNavigationBarItem(
                label: 'Markets', icon: Icon(Icons.shopping_cart_outlined)),
            BottomNavigationBarItem(
                label: 'Derivatives', icon: Icon(Icons.add_chart)),
            BottomNavigationBarItem(
                label: 'Trade', icon: Icon(Icons.dynamic_feed_outlined)),
            BottomNavigationBarItem(
                label: 'Assets', icon: Icon(Icons.wallet_giftcard_outlined)),
          ],
        );
      },
    );
  }
}

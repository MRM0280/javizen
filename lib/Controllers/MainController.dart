import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:javizen/Helpers/RequestHelper.dart';
import 'package:javizen/Models/CoinModel.dart';

class MainController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  RxInt selectedIndex = 0.obs;
  RxBool loading = false.obs;
  RxList<CoinModel> coinList = <CoinModel>[].obs;
  PageController pageController = PageController();
  RxList<CatModel> listOfCat = <CatModel>[
    CatModel(id: 1, title: "Spot", isSelected: true.obs),
    CatModel(id: 2, title: "USDT Perpetual", isSelected: false.obs),
    CatModel(id: 3, title: "Inverse Perpetual", isSelected: false.obs),
    CatModel(id: 4, title: "Inverse Futures", isSelected: false.obs),
  ].obs;

  @override
  void onInit() {
    getCoinList();
    tabController = TabController(length: 3, vsync: this);
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  getCoinList() {
    RequestHelper.getCoinList().then(
      (value) {
        if (value.statusCode == 200) {
          for (var i in value.data) {
            coinList.add(CoinModel.fromJson(i));
          }
          loading.value = true;
        } else {
          loading.value = false;
        }
      },
    );
  }
}

class CatModel {
  int? id;
  String? title;
  RxBool? isSelected;

  CatModel({this.id, this.title, this.isSelected});
}


import 'package:javizen/Models/test.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DerivativesController extends GetxController
    with GetSingleTickerProviderStateMixin {
  List<Candle> candles = [];
  late TabController tabController;

  WebViewController? controller;
  var url =
      "https://javizen.com/market/TRXUSDT";


  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    fetchCandles().then((value) {
      print(value.length);
      candles = value;
    });
    super.onInit();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Future<List<Candle>> fetchCandles() async {
    return (Ali.list)
        .map((e) => Candle.fromJson(e))
        .toList()
        .reversed
        .toList();
  }
}

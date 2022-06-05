import 'package:javizen/Controllers/DerivativesController.dart';
import 'package:javizen/Helpers/ColorHelpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DerivativesScreen extends StatelessWidget {
  DerivativesScreen({Key? key}) : super(key: key);
  DerivativesController Controller = Get.put(DerivativesController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // bottomNavigationBar: SizedBox(
        //   height: Get.height * .08,
        //   width: Get.width,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: [
        //       Container(
        //         height: Get.height * .055,
        //         width: Get.width * .35,
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(5),
        //             color: Colors.green,
        //             boxShadow: const [
        //               BoxShadow(
        //                   color: Colors.white12,
        //                   spreadRadius: 2,
        //                   blurRadius: 5),
        //             ]),
        //         child: const Center(
        //             child: Text(
        //           "Long",
        //           style: TextStyle(
        //               color: Colors.white,
        //               fontSize: 18,
        //               fontWeight: FontWeight.bold),
        //         )),
        //       ),
        //       Container(
        //         height: Get.height * .055,
        //         width: Get.width * .35,
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(5),
        //             color: Colors.red,
        //             boxShadow: const [
        //               BoxShadow(
        //                   color: Colors.white12,
        //                   spreadRadius: 2,
        //                   blurRadius: 5),
        //             ]),
        //         child: const Center(
        //             child: Text(
        //           "Short",
        //           style: TextStyle(
        //               color: Colors.white,
        //               fontSize: 18,
        //               fontWeight: FontWeight.bold),
        //         )),
        //       ),
        //     ],
        //   ),
        // ),
        backgroundColor: ColorHelpers.backGroundColor,
        body: SizedBox(
          width: Get.width,
          height: Get.height,
          child: WebView(
            allowsInlineMediaPlayback: true,
            // key: _key,
              zoomEnabled: true,
              gestureNavigationEnabled: true,
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: Controller.url,
              onWebViewCreated: (WebViewController webViewController) {
                Controller.controller = webViewController;
              }),
        ),
      ),
    );
  }

  _buildTabBarCoinList() {
    return Container(
      height: Get.height * .05,
      width: Get.width,
      color: Colors.white12,
      child: TabBar(
        physics: const NeverScrollableScrollPhysics(),
        controller: Controller.tabController,
        indicatorColor: Colors.orange,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: const [
          Text(
            "Charts",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "Trade",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  _buildTabBarView() {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: Controller.tabController,
        children: [
          _buildChartsTab(),
          _buildChartsTab(),
        ],
      ),
    );
  }

  _buildChartsTab() {
    return Column(
      children: [
        SizedBox(
          height: Get.height * .02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: Get.width * .45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.segment,
                    color: Colors.white,
                  ),
                  Text(
                    "BTC/USDT",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Text(
                    "-1.45%",
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: Get.width * .3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                  Icon(
                    Icons.screen_share,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: Get.height * .015,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "\$38,463.50",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: Get.height * .01,
                      ),
                      const Text(
                        "Market Price: \$38,353.50",
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    children: [
                      const Text(
                        "24h High                39,452.53",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      SizedBox(
                        height: Get.height * .015,
                      ),
                      const Text(
                        "24h High                39,452.53",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      SizedBox(
                        height: Get.height * .015,
                      ),
                      const Text(
                        "24h High                39,452.53",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: Get.height * .02,
        ),
        // SizedBox(
        //   height: Get.height * .35,
        //   width: Get.width,
        //   child: Candlesticks(
        //     candles: Controller.candles,
        //   ),
        // ),
        SizedBox(
          height: Get.height * .4,
          width: Get.width,
        ),
        SizedBox(
          height: Get.height * .025,
          width: Get.width,
        ),
        const StackedBar100Chart(),
      ],
    );
  }
}

/// Renders the stacked bar 100 chart sample.
class StackedBar100Chart extends StatefulWidget {
  const StackedBar100Chart({Key? key}) : super(key: key);

  @override
  _StackedBar100ChartState createState() => _StackedBar100ChartState();
}

class _StackedBar100ChartState extends State<StackedBar100Chart> {
  List<_ChartData>? chartData;

  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior =
        TooltipBehavior(enable: true, header: '', canShowMarker: false);
    chartData = <_ChartData>[
      _ChartData('1', 6, 6, 1),
      _ChartData('2', 8, 8, 1.5),
      _ChartData('3', 12, 11, 2),
      _ChartData('11', 12, 11, 2),
      _ChartData('22', 15.5, 16, 2.5),
      _ChartData('4', 15.5, 16, 2.5),
      _ChartData('5', 20, 21, 3),
      _ChartData('6', 24, 25, 3.5),
      _ChartData('7', 10, 15, 7.5),
      _ChartData('33', 10, 15, 7.5),
      _ChartData('55', 10, 15, 7.5),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: _buildStackedBar100Chart(),
    );
  }

  SfCartesianChart _buildStackedBar100Chart() {
    return SfCartesianChart(
      // plotAreaBorderWidth: 1,
      legend: Legend(isVisible: false),
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          rangePadding: ChartRangePadding.none,
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(size: 0)),
      series: _getStackedBarSeries(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  List<ChartSeries<_ChartData, String>> _getStackedBarSeries() {
    return <ChartSeries<_ChartData, String>>[
      StackedBar100Series<_ChartData, String>(
          dataSource: chartData!,
          color: Colors.green,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.apple,
          name: 'Apple'),
      StackedBar100Series<_ChartData, String>(
          dataSource: chartData!,
          color: Colors.red,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.orange,
          name: 'Orange'),
    ];
  }

  @override
  void dispose() {
    chartData!.clear();
    super.dispose();
  }
}

class _ChartData {
  _ChartData(this.x, this.apple, this.orange, this.wastage);

  final String x;
  final num apple;
  final num orange;
  final num wastage;
}

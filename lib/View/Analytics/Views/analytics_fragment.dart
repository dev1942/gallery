import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/Analytics/Controllers/analytics_controller.dart';
import 'package:otobucks/View/Analytics/Controllers/statices_analytics_controller.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/widgets/round_dot.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../../widgets/custom_ui/loader/circle.dart';

class AnalyticsFragment extends StatefulWidget {
  const AnalyticsFragment({Key? key}) : super(key: key);

  @override
  AnalyticsFragmentState createState() => AnalyticsFragmentState();
}

class AnalyticsFragmentState extends State<AnalyticsFragment> {
  var controller = Get.put(AnalyticsController());
  var staticscontroller = Get.put(StaticesAnalyticsController());
  double promotionBookings = 0;
  double serviceBookings = 0;
  double totalAmountSpent = 0;
  double invites = 0;

  @override
  void initState() {
    controller.getAllData();
    setState(() {
      apiData();
    });
    super.initState();
  }

  Future<void> apiData() async {
    log("------my data-----1--------");
    var apidata = await staticscontroller.fetchdata();
    log("------my data--------2-----");
    setState(() {
      promotionBookings =
          double.parse(apidata!.result!.promotionBookings!.toString());
      serviceBookings =
          double.parse(apidata.result!.serviceBookings!.toString());
      invites=double.parse(apidata.result!.invites!.toString());
      totalAmountSpent=double.parse(apidata.result!.totalAmountSpent!.toString());
      log(promotionBookings.toString());
      log(serviceBookings.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    apiData();
    Widget widgetM = Container();
    List<Color> colorList = [
      Colors.cyan.shade400,
      AppColors.colorPrimary,
      Colors.blue.shade500,
      AppColors.colorYellowShade
    ];
    widgetM = SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   margin: const EdgeInsets.only(top: AppDimens.dimens_10, left: AppDimens.dimens_18, right: AppDimens.dimens_18),
          //   alignment: Alignment.centerLeft,
          //   child: Text(
          //     Constants.TXT_MY_EARNINGS,
          //     style: AppStyle.textViewStyleNormalSubtitle2(context: context, color: AppColors.colorBlack, fontSizeDelta: 0, fontWeightDelta: 1),
          //   ),
          // ),
          // Container(
          //   margin: const EdgeInsets.all(AppDimens.dimens_10),
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Expanded(
          //           child: Card(
          //         child: Container(
          //           padding: const EdgeInsets.all(AppDimens.dimens_8),
          //           alignment: Alignment.center,
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               // Row(
          //               //   crossAxisAlignment: CrossAxisAlignment.center,
          //               //   mainAxisAlignment: MainAxisAlignment.start,
          //               //   children: [
          //               //     RoundDot(mColor: AppColors.colorGreen, size: AppDimens.dimens_8),
          //               //     Expanded(
          //               //       child: GetBuilder<AnalyticsController>(builder: (value) {
          //               //         return AppViews.getSetDataCustomLoader(
          //               //             context,
          //               //             value.loadingWalletBalance,
          //               //             Container(
          //               //               margin: const EdgeInsets.only(left: AppDimens.dimens_4),
          //               //               child: Text(
          //               //                 Global.replaceCurrencySign(value.mWalletModel.currency) +
          //               //                     double.parse(value.mWalletModel.balance).toStringAsFixed(2),
          //               //                 style: AppStyle.textViewStyleNormalSubtitle2(
          //               //                     context: context, color: AppColors.colorGreen, fontSizeDelta: 2, fontWeightDelta: 3),
          //               //               ),
          //               //             ),
          //               //             SpinKitCircle(
          //               //               color: AppColors.colorAccent,
          //               //               size: AppDimens.dimens_20,
          //               //               key: const ValueKey('value'),
          //               //             ),
          //               //             '0');
          //               //       }),
          //               //     ),
          //               //   ],
          //               // ),
          //               // Container(
          //               //   margin: const EdgeInsets.only(top: AppDimens.dimens_5),
          //               //   child: Text(Constants.TXT_TOTAL_WALLET_BALANCE,
          //               //       style: AppStyle.textViewStyleSmall(context: context, color: AppColors.colorBlack, fontSizeDelta: -2)),
          //               // )
          //             ],
          //           ),
          //         ),
          //       )),
          //       const SizedBox(width: AppDimens.dimens_5, height: 0),
          //       // Expanded(
          //       //     child: Card(
          //       //   child: Container(
          //       //     padding: const EdgeInsets.all(AppDimens.dimens_8),
          //       //     alignment: Alignment.center,
          //       //     child: Column(
          //       //       crossAxisAlignment: CrossAxisAlignment.start,
          //       //       mainAxisAlignment: MainAxisAlignment.center,
          //       //       children: [
          //       //         // Row(
          //       //         //   crossAxisAlignment: CrossAxisAlignment.center,
          //       //         //   mainAxisAlignment: MainAxisAlignment.start,
          //       //         //   children: [
          //       //         //     RoundDot(
          //       //         //         mColor: AppColors.colorOrange,
          //       //         //         size: AppDimens.dimens_8),
          //       //         //     Expanded(
          //       //         //       child: GetBuilder<AnalyticsController>(
          //       //         //           builder: (value) {
          //       //         //         return AppViews.getSetDataCustomLoader(
          //       //         //             context,
          //       //         //             value.loadingWalletBalance,
          //       //         //             Container(
          //       //         //               margin: const EdgeInsets.only(
          //       //         //                   left: AppDimens.dimens_4),
          //       //         //               child: Text(
          //       //         //                 Global.replaceCurrencySign(
          //       //         //                         value.mWalletModel.currency) +
          //       //         //                     value.mWalletModel.earning,
          //       //         //                 style: AppStyle
          //       //         //                     .textViewStyleNormalSubtitle2(
          //       //         //                         context: context,
          //       //         //                         color: AppColors.colorOrange,
          //       //         //                         fontSizeDelta: 2,
          //       //         //                         fontWeightDelta: 3),
          //       //         //               ),
          //       //         //             ),
          //       //         //             SpinKitCircle(
          //       //         //               color: AppColors.colorAccent,
          //       //         //               size: AppDimens.dimens_20,
          //       //         //               key: const ValueKey('value'),
          //       //         //             ),
          //       //         //             '0');
          //       //         //       }),
          //       //         //     ),
          //       //         //   ],
          //       //         // ),
          //       //         // Container(
          //       //         //   margin:
          //       //         //       const EdgeInsets.only(top: AppDimens.dimens_5),
          //       //         //   child: Text(Constants.TXT_TOTAL_EARNINGS,
          //       //         //       style: AppStyle.textViewStyleSmall(
          //       //         //           context: context,
          //       //         //           color: AppColors.colorBlack,
          //       //         //           fontSizeDelta: -2)),
          //       //         // )
          //       //       ],
          //       //     ),
          //       //   ),
          //       // )),
          //     ],
          //   ),
          // ),

          // card show
          // Container(
          //   margin: const EdgeInsets.only(top: AppDimens.dimens_20, left: AppDimens.dimens_18, right: AppDimens.dimens_18),
          //   alignment: Alignment.centerLeft,
          //   child: Text(
          //     Constants.TXT_TOTAL_EARNINGS,
          //     style: AppStyle.textViewStyleNormalSubtitle2(context: context, color: AppColors.colorBlack, fontSizeDelta: 0, fontWeightDelta: 1),
          //   ),
          // ),
          addVerticleSpace(90),
          Padding(
            padding: const EdgeInsets.all(16),
            child: AspectRatio(
              aspectRatio: 11 / 9,
              child: PieChart(
                dataMap: //dataMap,
                    {
                  "Promotion Bookings": promotionBookings.toDouble(),
                  "Service Bookings": serviceBookings.toDouble(),
                  "Invites": invites.toDouble(),
                      "Amount Spent":totalAmountSpent.toDouble()/100.0
                },
                animationDuration: const Duration(milliseconds: 800),
                chartLegendSpacing: 100,
                chartRadius: MediaQuery.of(context).size.width / 3,
                colorList: colorList,
                initialAngleInDegree: 0,
                chartType: ChartType.ring,
                ringStrokeWidth: 150,
                centerText: "OTOBUCKS",
                legendOptions: const LegendOptions(
                  showLegendsInRow: false,
                  legendPosition: LegendPosition.bottom,
                  showLegends: true,
                  legendShape: BoxShape.circle,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: const ChartValuesOptions(
                  showChartValueBackground: true,
                  showChartValues: true,
                  showChartValuesInPercentage: true,
                  showChartValuesOutside: true,
                  decimalPlaces: 0,
                ),
                // gradientList: ---To add gradient colors---
                // emptyColorGradient: ---Empty Color gradient---
              ),
            ),
          ),
        ],
      ),
    );

    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: AppColors.getMainBgColor(),
            body: Stack(
              children: [
                Container(
                  color: AppColors.colorBlueStart,
                  //height: AppDimens.dimens_120,
                  height: 0,
                ),
                // Container(height: size.height, child: widgetM),
                widgetM,
                // AppViews.showLoadingWithStatus(isShowLoader)
              ],
            )));
  }
}

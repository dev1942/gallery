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
  var apidata;

  @override
  void initState() {
    //controller.getAllData();
    apiData();
    super.initState();
  }

  Future<void> apiData() async {
    print("------my data-----1--------");
    var apidata = await staticscontroller.fetchdata();
    print("------my data--------2-----");
    print(apidata!.result!.promotionBookings);
    print(apidata!.result!.serviceBookings);
  }

  @override
  Widget build(BuildContext context) {
    Widget widgetM = Container();
    // Map<String, double> dataMap = {
    //   "January":apidata !=null?apidata!.result!.promotionBookings: 10,
    //   "February": apidata !=null?apidata!.result!.serviceBookings: 6,
    //   "March": 2,
    //   "April": 2,
    // };

    List<Color> colorList = [
      AppColors.colorYellowShade,
      AppColors.colorPrimary,
      Colors.teal,
      Colors.pink
    ];
    widgetM = SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(
                top: AppDimens.dimens_10,
                left: AppDimens.dimens_18,
                right: AppDimens.dimens_18),
            alignment: Alignment.centerLeft,
            child: Text(
              Constants.TXT_MY_EARNINGS,
              style: AppStyle.textViewStyleNormalSubtitle2(
                  context: context,
                  color: AppColors.colorBlack,
                  fontSizeDelta: 0,
                  fontWeightDelta: 1),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(AppDimens.dimens_10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Card(
                  child: Container(
                    padding: const EdgeInsets.all(AppDimens.dimens_8),
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RoundDot(
                                mColor: AppColors.colorGreen,
                                size: AppDimens.dimens_8),
                            Expanded(
                              child: GetBuilder<AnalyticsController>(
                                  builder: (value) {
                                return AppViews.getSetDataCustomLoader(
                                    context,
                                    value.loadingWalletBalance,
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: AppDimens.dimens_4),
                                      child: Text(
                                        Global.replaceCurrencySign(
                                                value.mWalletModel.currency) +
                                            double.parse(
                                                    value.mWalletModel.balance)
                                                .toStringAsFixed(2),
                                        style: AppStyle
                                            .textViewStyleNormalSubtitle2(
                                                context: context,
                                                color: AppColors.colorGreen,
                                                fontSizeDelta: 2,
                                                fontWeightDelta: 3),
                                      ),
                                    ),
                                    SpinKitCircle(
                                      color: AppColors.colorAccent,
                                      size: AppDimens.dimens_20,
                                      key: const ValueKey('value'),
                                    ),
                                    '0');
                              }),
                            ),
                          ],
                        ),
                        Container(
                          margin:
                              const EdgeInsets.only(top: AppDimens.dimens_5),
                          child: Text(Constants.TXT_TOTAL_WALLET_BALANCE,
                              style: AppStyle.textViewStyleSmall(
                                  context: context,
                                  color: AppColors.colorBlack,
                                  fontSizeDelta: -2)),
                        )
                      ],
                    ),
                  ),
                )),
                const SizedBox(width: AppDimens.dimens_5, height: 0),
                Expanded(
                    child: Card(
                  child: Container(
                    padding: const EdgeInsets.all(AppDimens.dimens_8),
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RoundDot(
                                mColor: AppColors.colorOrange,
                                size: AppDimens.dimens_8),
                            Expanded(
                              child: GetBuilder<AnalyticsController>(
                                  builder: (value) {
                                return AppViews.getSetDataCustomLoader(
                                    context,
                                    value.loadingWalletBalance,
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: AppDimens.dimens_4),
                                      child: Text(
                                        Global.replaceCurrencySign(
                                                value.mWalletModel.currency) +
                                            value.mWalletModel.earning,
                                        style: AppStyle
                                            .textViewStyleNormalSubtitle2(
                                                context: context,
                                                color: AppColors.colorOrange,
                                                fontSizeDelta: 2,
                                                fontWeightDelta: 3),
                                      ),
                                    ),
                                    SpinKitCircle(
                                      color: AppColors.colorAccent,
                                      size: AppDimens.dimens_20,
                                      key: const ValueKey('value'),
                                    ),
                                    '0');
                              }),
                            ),
                          ],
                        ),
                        Container(
                          margin:
                              const EdgeInsets.only(top: AppDimens.dimens_5),
                          child: Text(Constants.TXT_TOTAL_EARNINGS,
                              style: AppStyle.textViewStyleSmall(
                                  context: context,
                                  color: AppColors.colorBlack,
                                  fontSizeDelta: -2)),
                        )
                      ],
                    ),
                  ),
                )),
              ],
            ),
          ),

          // card show
          Container(
            margin: const EdgeInsets.only(
                top: AppDimens.dimens_20,
                left: AppDimens.dimens_18,
                right: AppDimens.dimens_18),
            alignment: Alignment.centerLeft,
            child: Text(
              Constants.TXT_TOTAL_EARNINGS,
              style: AppStyle.textViewStyleNormalSubtitle2(
                  context: context,
                  color: AppColors.colorBlack,
                  fontSizeDelta: 0,
                  fontWeightDelta: 1),
            ),
          ),
          addVerticleSpace(90),
          Padding(
            padding: const EdgeInsets.all(16),
            child: AspectRatio(
              aspectRatio: 14 / 9,
              child: PieChart(
                dataMap: //dataMap,

                    {
                  "Promotion Bookings":
                      apidata != null ? apidata!.result!.promotionBookings : 10,
                  "Service Bookings":
                      apidata != null ? apidata!.result!.serviceBookings : 6,
                  "Invites": 0,
                },
                animationDuration: Duration(milliseconds: 800),
                chartLegendSpacing: 80,
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
                  decimalPlaces: 1,
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

import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/controllers/analytics_controller.dart';
import 'package:otobucks/custom_ui/loader/circle.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/widgets/round_dot.dart';

class AnalyticsFragment extends StatefulWidget {
  const AnalyticsFragment({Key? key}) : super(key: key);

  @override
  AnalyticsFragmentState createState() => AnalyticsFragmentState();
}

class AnalyticsFragmentState extends State<AnalyticsFragment> {
  var controller = Get.put(AnalyticsController());

  @override
  void initState() {
    controller.getAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget widgetM = Container();

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
          // Container(
          //   margin: const EdgeInsets.all(AppDimens.dimens_10),
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Flexible(
          //           child: Card(
          //         child: Container(
          //           padding: const EdgeInsets.all(AppDimens.dimens_8),
          //           alignment: Alignment.center,
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             children: [
          //               Container(
          //                 alignment: Alignment.centerLeft,
          //                 child: Row(
          //                   crossAxisAlignment: CrossAxisAlignment.center,
          //                   mainAxisAlignment: MainAxisAlignment.start,
          //                   children: [
          //                     RoundDot(
          //                         mColor: AppColors.colorGreen,
          //                         size: AppDimens.dimens_8),
          //                     Container(
          //                       margin: const EdgeInsets.only(
          //                           left: AppDimens.dimens_4),
          //                       child: Text(
          //                         "150",
          //                         style: AppStyle.textViewStyleNormalSubtitle2(
          //                             context: context,
          //                             color: AppColors.colorOrange,
          //                             fontSizeDelta: 2,
          //                             fontWeightDelta: 3),
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //               Container(
          //                 margin:
          //                     const EdgeInsets.only(top: AppDimens.dimens_5),
          //                 child: Text(Constants.TXT_TOTAL_INVITE_PEOPLES,
          //                     style: AppStyle.textViewStyleSmall(
          //                         context: context,
          //                         color: AppColors.colorBlack,
          //                         fontSizeDelta: -2)),
          //               )
          //             ],
          //           ),
          //         ),
          //       )),
          //       const SizedBox(width: AppDimens.dimens_5, height: 0),
          //       Flexible(
          //           child: Card(
          //         child: Container(
          //           padding: const EdgeInsets.all(AppDimens.dimens_8),
          //           alignment: Alignment.center,
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Row(
          //                 crossAxisAlignment: CrossAxisAlignment.center,
          //                 mainAxisAlignment: MainAxisAlignment.start,
          //                 children: [
          //                   RoundDot(
          //                       mColor: AppColors.colorOrange,
          //                       size: AppDimens.dimens_8),
          //                   Container(
          //                     margin: const EdgeInsets.only(
          //                         left: AppDimens.dimens_4),
          //                     child: Text(
          //                       "25",
          //                       style: AppStyle.textViewStyleNormalSubtitle2(
          //                           context: context,
          //                           color: AppColors.colorOrange,
          //                           fontSizeDelta: 2,
          //                           fontWeightDelta: 3),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //               Container(
          //                 margin:
          //                     const EdgeInsets.only(top: AppDimens.dimens_5),
          //                 child: Text(Constants.TXT_TOTAL_BUY_PRODUCTS,
          //                     style: AppStyle.textViewStyleSmall(
          //                         context: context,
          //                         color: AppColors.colorBlack,
          //                         fontSizeDelta: -2)),
          //               )
          //             ],
          //           ),
          //         ),
          //       )),
          //     ],
          //   ),
          // ),
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: DChartLine(
                data: const [
                  {
                    'id': 'Line',
                    'data': [
                      {'domain': 0, 'measure': 100},
                      {'domain': 1, 'measure': 200},
                      {'domain': 3, 'measure': 300},
                      {'domain': 9, 'measure': 400},
                    ],
                  },
                ],
                includePoints: false,
                lineColor: (lineData, index, id) => AppColors.colorBlueEnd,
              ),
            ),
          ),
          // Container(
          //   margin: const EdgeInsets.only(
          //       top: AppDimens.dimens_15,
          //       left: AppDimens.dimens_18,
          //       right: AppDimens.dimens_18),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Text(
          //         Constants.TXT_BUY_PRODUCTS,
          //         style: AppStyle.textViewStyleNormalSubtitle2(
          //             context: context,
          //             color: AppColors.colorBlack,
          //             fontSizeDelta: 0,
          //             fontWeightDelta: 1),
          //       ),
          //       InkWell(
          //         child: Text(
          //           Constants.TXT_VIEW_ALL,
          //           style: AppStyle.textViewStyleSmall(
          //               context: context,
          //               color: AppColors.colorBlueEnd,
          //               fontWeightDelta: 2,
          //               fontSizeDelta: 0),
          //         ),
          //         onTap: () {
          //           // todo View More
          //         },
          //       )
          //     ],
          //   ),
          // ),

          // ListView.builder(
          //     shrinkWrap: true,
          //     physics: const NeverScrollableScrollPhysics(),
          //     padding: const EdgeInsets.all(AppDimens.dimens_13),
          //     itemBuilder: (BuildContext contextM, index) {
          //       // EstimatesModel mEstimatesModel = alEstimates[index];

          //       return Container(
          //         margin: const EdgeInsets.only(bottom: AppDimens.dimens_14),
          //         color: Colors.transparent,
          //         child: Card(
          //             elevation: AppDimens.dimens_1,
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(AppDimens.dimens_5),
          //             ),
          //             child: InkWell(
          //               child: Container(
          //                 alignment: Alignment.center,
          //                 height: AppDimens.dimens_90,
          //                 padding: const EdgeInsets.only(
          //                   right: AppDimens.dimens_10,
          //                 ),
          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Container(
          //                       margin: const EdgeInsets.only(
          //                         right: AppDimens.dimens_10,
          //                       ),
          //                       child: ClipRRect(
          //                         borderRadius:
          //                             BorderRadius.circular(AppDimens.dimens_5),
          //                         child: const NetworkImageCustom(
          //                             image:
          //                                 "https://5.imimg.com/data5/EY/EU/XV/SELLER-90798665/small-tractor-tires-500x500.jpg",
          //                             fit: BoxFit.fill,
          //                             height: AppDimens.dimens_90,
          //                             width: AppDimens.dimens_90),
          //                       ),
          //                     ),
          //                     Expanded(
          //                         child: Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       mainAxisAlignment: MainAxisAlignment.start,
          //                       children: [
          //                         Container(
          //                           child: Row(
          //                             mainAxisAlignment:
          //                                 MainAxisAlignment.spaceBetween,
          //                             crossAxisAlignment:
          //                                 CrossAxisAlignment.center,
          //                             children: [
          //                               Container(
          //                                   alignment: Alignment.centerLeft,
          //                                   child: Text(
          //                                     "Company",
          //                                     style: AppStyle
          //                                         .textViewStyleNormalBodyText2(
          //                                             context: context,
          //                                             color:
          //                                                 AppColors.colorBlack,
          //                                             fontSizeDelta: 0,
          //                                             fontWeightDelta: 2),
          //                                   )),
          //                               Container(
          //                                   alignment: Alignment.centerLeft,
          //                                   child: GradientText(
          //                                     Global.replaceCurrencySign(
          //                                             "USD") +
          //                                         "" +
          //                                         "30",
          //                                     style: AppStyle
          //                                         .textViewStyleNormalBodyText2(
          //                                             context: context,
          //                                             color: AppColors
          //                                                 .grayDashboardText,
          //                                             fontSizeDelta: -1,
          //                                             fontWeightDelta: 3),
          //                                   )),
          //                             ],
          //                           ),
          //                           margin: const EdgeInsets.only(
          //                               top: AppDimens.dimens_5,
          //                               bottom: AppDimens.dimens_2),
          //                         ),
          //                         Container(
          //                             margin: const EdgeInsets.only(
          //                                 bottom: AppDimens.dimens_5),
          //                             alignment: Alignment.centerLeft,
          //                             child: Text(
          //                               "Lorem Ipsum is simply dummy text of the printing.",
          //                               maxLines: 2,
          //                               style: AppStyle.textViewStyleSmall(
          //                                   context: context,
          //                                   color: AppColors.grayDashboardText,
          //                                   fontSizeDelta: -2,
          //                                   fontWeightDelta: -1),
          //                             )),
          //                         Container(
          //                             alignment: Alignment.centerRight,
          //                             child: Text(
          //                               "JAN 4, 2022",
          //                               style: AppStyle
          //                                   .textViewStyleNormalBodyText2(
          //                                       context: context,
          //                                       color:
          //                                           AppColors.grayDashboardText,
          //                                       fontSizeDelta: -2,
          //                                       fontWeightDelta: 1),
          //                             )),
          //                       ],
          //                     )),
          //                   ],
          //                 ),
          //               ),
          //               onTap: () {},
          //             )),
          //       );
          //     },
          //     itemCount: 20)
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

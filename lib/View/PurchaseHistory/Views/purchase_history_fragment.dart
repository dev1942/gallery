import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/Home/Controllers/home_screen_controller.dart';
import 'package:otobucks/View/Transactions/Controllers/transaction_controller.dart';
import 'package:otobucks/View/Transactions/Models/transaction_model.dart';
import 'package:otobucks/widgets/fade_in_image.dart';
import 'package:otobucks/widgets/gradient_text.dart';

import '../../../../../../global/app_colors.dart';
import '../../../../../../global/app_dimens.dart';
import '../../../../../../global/app_style.dart';
import '../../../../../../global/app_views.dart';
import '../../../../../../global/global.dart';

class PurchaseHistoryFragment extends StatefulWidget {
  const PurchaseHistoryFragment({Key? key}) : super(key: key);

  @override
  PurchaseHistoryFragmentState createState() => PurchaseHistoryFragmentState();
}

class PurchaseHistoryFragmentState extends State<PurchaseHistoryFragment> {
  var controller = Get.put(TransactionController());

  @override
  void initState() {
    controller.getTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  height: 0,
                ),
                GetBuilder<TransactionController>(
                    init: TransactionController(),
                    builder: (value) {
                      return AppViews.getSetData(
                          context,
                          controller.mShowData,
                          Column(
                            children: [
                              // profile pic and name
                              Container(
                                padding: const EdgeInsets.only(
                                    left: AppDimens.dimens_50,
                                    top: AppDimens.dimens_25,
                                    bottom: AppDimens.dimens_32),
                                alignment: Alignment.center,
                                color: AppColors.colorBlueStart,
                                child: Row(
                                  children: [
                                    Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            AppDimens.dimens_50),
                                        child: NetworkImageCustom(
                                            image:
                                                Get.find<HomeScreenController>()
                                                    .image,
                                            fit: BoxFit.fill,
                                            height: AppDimens.dimens_60,
                                            width: AppDimens.dimens_60),
                                      ),
                                      margin: const EdgeInsets.only(
                                          right: AppDimens.dimens_10),
                                    ),
                                    Flexible(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            margin: const EdgeInsets.only(
                                                top: AppDimens.dimens_5,
                                                bottom: AppDimens.dimens_2),
                                            child: Text(
                                              Get.find<HomeScreenController>()
                                                  .fullName
                                                  .trim()
                                                  .capitalize!,
                                              style: AppStyle
                                                  .textViewStyleNormalBodyText2(
                                                      context: context,
                                                      color:
                                                          AppColors.colorWhite,
                                                      fontSizeDelta: 0,
                                                      fontWeightDelta: -1),
                                            )),
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Car Owner",
                                              style:
                                                  AppStyle.textViewStyleSmall(
                                                      context: context,
                                                      color: AppColors
                                                          .colorWhite
                                                          .withOpacity(0.7),
                                                      fontSizeDelta: -2,
                                                      fontWeightDelta: 0),
                                            )),
                                      ],
                                    )),
                                  ],
                                ),
                              ),

                              Expanded(
                                  child: ListView.builder(
                                      padding: const EdgeInsets.all(
                                          AppDimens.dimens_20),
                                      itemBuilder:
                                          (BuildContext contextM, index) {
                                        TransactionModel transaction =
                                            value.transactions[index];

                                        return Container(
                                          margin: const EdgeInsets.only(
                                              bottom: AppDimens.dimens_14),
                                          color: Colors.transparent,
                                          child: Card(
                                              elevation: AppDimens.dimens_3,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppDimens.dimens_5),
                                              ),
                                              child: InkWell(
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  padding:
                                                      const EdgeInsets.only(
                                                    right: AppDimens.dimens_10,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(
                                                          right: AppDimens
                                                              .dimens_10,
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  AppDimens
                                                                      .dimens_5),
                                                          child: NetworkImageCustom(
                                                              image: transaction
                                                                          .metadata
                                                                          .provider ==
                                                                      null
                                                                  ? Get.find<
                                                                          HomeScreenController>()
                                                                      .image
                                                                  : transaction
                                                                      .metadata
                                                                      .provider!
                                                                      .image,
                                                              fit: BoxFit.fill,
                                                              height: AppDimens
                                                                  .dimens_90,
                                                              width: AppDimens
                                                                  .dimens_90),
                                                        ),
                                                      ),
                                                      Expanded(
                                                          child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      Container(
                                                                          alignment: Alignment
                                                                              .centerLeft,
                                                                          child:
                                                                              Text(
                                                                            transaction.metadata.provider == null
                                                                                ? Get.find<HomeScreenController>().fullName
                                                                                : transaction.metadata.provider!.firstName + " " + transaction.metadata.provider!.lastName,
                                                                            maxLines:
                                                                                2,
                                                                            style: AppStyle.textViewStyleNormalBodyText2(
                                                                                context: context,
                                                                                color: AppColors.grayDashboardText,
                                                                                fontSizeDelta: 0,
                                                                                fontWeightDelta: 1),
                                                                          )),
                                                                ),
                                                                Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child:
                                                                        GradientText(
                                                                      Global.replaceCurrencySign(
                                                                              transaction.currency) +
                                                                          "" +
                                                                          "${transaction.amount}/-",
                                                                      style: AppStyle.textViewStyleNormalBodyText2(
                                                                          context:
                                                                              context,
                                                                          color: AppColors
                                                                              .grayDashboardText,
                                                                          fontSizeDelta:
                                                                              2,
                                                                          fontWeightDelta:
                                                                              3),
                                                                    )),
                                                              ],
                                                            ),
                                                            margin: const EdgeInsets
                                                                    .only(
                                                                top: AppDimens
                                                                    .dimens_5,
                                                                bottom: AppDimens
                                                                    .dimens_2),
                                                          ),
                                                          Container(
                                                              margin: const EdgeInsets
                                                                      .only(
                                                                  bottom: AppDimens
                                                                      .dimens_5),
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                transaction.metadata
                                                                            .service ==
                                                                        null
                                                                    ? ''
                                                                    : transaction
                                                                        .metadata
                                                                        .service!
                                                                        .title,
                                                                maxLines: 1,
                                                                style: AppStyle.textViewStyleSmall(
                                                                    context:
                                                                        context,
                                                                    color: AppColors
                                                                        .grayDashboardText,
                                                                    fontSizeDelta:
                                                                        -2,
                                                                    fontWeightDelta:
                                                                        0),
                                                              )),
                                                          Container(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Text(
                                                                transaction
                                                                    .metadata
                                                                    .type,
                                                                style: AppStyle.textViewStyleNormalBodyText2(
                                                                    context:
                                                                        context,
                                                                    color: AppColors
                                                                        .colorGreen,
                                                                    fontSizeDelta:
                                                                        0,
                                                                    fontWeightDelta:
                                                                        1),
                                                              )),
                                                        ],
                                                      )),
                                                    ],
                                                  ),
                                                ),
                                                onTap: () {},
                                              )),
                                        );
                                      },
                                      itemCount: value.transactions.length))
                            ],
                          ));
                    })
              ],
            )));
  }
}

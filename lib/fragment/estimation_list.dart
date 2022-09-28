import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/controllers/estimation_sidebar_controllers/estimation_list_controller.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/page/services/estimation/estimation_details_pdf_screen.dart';
import 'package:otobucks/page/services/estimation/view_estimation.dart';
import 'package:otobucks/widgets/fade_in_image.dart';
import 'package:otobucks/widgets/gradient_text.dart';

import '../../../../global/app_colors.dart';
import '../../../../global/app_dimens.dart';
import '../../../../global/app_style.dart';
import '../../../../global/app_views.dart';
import '../../../../global/global.dart';
import '../../../model/estimates_model.dart';

class EstimationListFragment extends StatefulWidget {
  final String estimationStatus;
  final String screen;
  const EstimationListFragment(
      {Key? key, required this.estimationStatus, required this.screen})
      : super(key: key);

  @override
  EstimationListFragmentState createState() => EstimationListFragmentState();
}

class EstimationListFragmentState extends State<EstimationListFragment> {
  var controller = Get.put(EstimationListController());

  @override
  void initState() {
    super.initState();

    loadData();
  }

  //put a second time, then disposed the controller
  Future loadData() async {
    await Future.delayed(Duration.zero, () async {
      controller.getEstimation(widget.estimationStatus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: AppColors.getMainBgColor(),
            body: GetBuilder<EstimationListController>(
                init: EstimationListController(),
                builder: (value) {
                  return AppViews.getSetData(
                      context,
                      value.mShowData,
                      ListView.builder(
                          padding: const EdgeInsets.all(AppDimens.dimens_10),
                          itemBuilder: (BuildContext contextM, index) {
                            EstimatesModel mEstimatesModel =
                                value.alEstimates[index];
                            return Container(
                              margin: const EdgeInsets.only(
                                  bottom: AppDimens.dimens_14),
                              color: Colors.transparent,
                              child: Card(
                                  elevation: AppDimens.dimens_3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppDimens.dimens_5),
                                  ),
                                  child: InkWell(
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.only(
                                        right: AppDimens.dimens_10,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                              right: AppDimens.dimens_10,
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppDimens.dimens_5),
                                              child: NetworkImageCustom(
                                                  image: mEstimatesModel
                                                      .getProviderImage(),
                                                  fit: BoxFit.fill,
                                                  height: AppDimens.dimens_90,
                                                  width: AppDimens.dimens_90),
                                            ),
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            mEstimatesModel
                                                                .getProviderName(),
                                                            maxLines: 1,
                                                            style: AppStyle.textViewStyleNormalBodyText2(
                                                                context:
                                                                    context,
                                                                color: AppColors
                                                                    .colorBlack2,
                                                                fontSizeDelta:
                                                                    0,
                                                                fontWeightDelta:
                                                                    -3),
                                                          )),
                                                    ),
                                                    if (widget
                                                            .estimationStatus ==
                                                        'submitted')
                                                      Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: mEstimatesModel
                                                                  .itemModel
                                                                  .isNotEmpty
                                                              ? GradientText(
                                                                  Global.checkNull(mEstimatesModel
                                                                          .source
                                                                          ?.price)
                                                                      ? Global.replaceCurrencySign(
                                                                              "USD") +
                                                                          "" +
                                                                          mEstimatesModel
                                                                              .itemModel[0]
                                                                              .amount +
                                                                          "/-"
                                                                      : "",
                                                                  style: AppStyle.textViewStyleNormalBodyText2(
                                                                      context:
                                                                          context,
                                                                      color: AppColors
                                                                          .grayDashboardText,
                                                                      fontSizeDelta:
                                                                          2,
                                                                      fontWeightDelta:
                                                                          3),
                                                                )
                                                              : Container())
                                                    // : Container(
                                                    //     alignment: Alignment
                                                    //         .centerLeft,
                                                    //     child: GradientText(
                                                    //       widget
                                                    //           .estimationStatus
                                                    //           .toUpperCase(),
                                                    //       style: AppStyle.textViewStyleNormalBodyText2(
                                                    //           context:
                                                    //               context,
                                                    //           color: AppColors
                                                    //               .darkRed,
                                                    //           fontSizeDelta:
                                                    //               1.3,
                                                    //           fontWeightDelta:
                                                    //               3),
                                                    //     )),
                                                  ],
                                                ),
                                                margin: const EdgeInsets.only(
                                                    top: AppDimens.dimens_5,
                                                    bottom: AppDimens.dimens_5),
                                              ),
                                              Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom:
                                                          AppDimens.dimens_5),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    mEstimatesModel.getDate(),
                                                    style: AppStyle
                                                        .textViewStyleSmall(
                                                            context: context,
                                                            color: AppColors
                                                                .grayDashboardText,
                                                            fontSizeDelta: -2,
                                                            fontWeightDelta: 0),
                                                  )),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      child: Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            Constants
                                                                .TXT_VIEW_BOOKING,
                                                            style: AppStyle.textViewStyleSmall(
                                                                context:
                                                                    context,
                                                                color: AppColors
                                                                    .colorTextBlue2,
                                                                fontSizeDelta:
                                                                    -2,
                                                                fontWeightDelta:
                                                                    0),
                                                          )),
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ViewEstimation(
                                                                          mEstimatesModel:
                                                                              mEstimatesModel,
                                                                          screen:
                                                                              widget.screen,
                                                                        )));
                                                      },
                                                    ),
                                                  ),
                                                  if (mEstimatesModel.status ==
                                                      'submitted')
                                                    Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: InkWell(
                                                        child: Container(
                                                            height: AppDimens
                                                                .dimens_23,
                                                            alignment: Alignment
                                                                .center,
                                                            padding: const EdgeInsets
                                                                    .only(
                                                                top: AppDimens
                                                                    .dimens_4,
                                                                bottom: AppDimens
                                                                    .dimens_4,
                                                                left: AppDimens
                                                                    .dimens_6,
                                                                right: AppDimens
                                                                    .dimens_6),
                                                            decoration: AppViews
                                                                .getGradientBoxDecoration(
                                                                    mBorderRadius:
                                                                        AppDimens
                                                                            .dimens_12),
                                                            child: Text(
                                                              "View Details",
                                                              style: AppStyle.textViewStyleSmall(
                                                                  context:
                                                                      context,
                                                                  color: AppColors
                                                                      .colorWhite,
                                                                  fontSizeDelta:
                                                                      -3,
                                                                  fontWeightDelta:
                                                                      2),
                                                            )),
                                                        onTap: () {
                                                          if (mEstimatesModel
                                                                  .status ==
                                                              'submitted') {
                                                            gotoViewEstimation(
                                                                mEstimatesModel,
                                                                false);
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                ],
                                              )
                                            ],
                                          )),
                                        ],
                                      ),
                                    ),
                                    onTap: () {},
                                  )),
                            );
                          },
                          itemCount: value.alEstimates.length));
                })));
  }

  gotoViewEstimation(EstimatesModel mEstimatesModel, bool makePayment) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EstimationDetailsPDFScreen(
                  mEstimatesModel: mEstimatesModel,
                  callback: (bool isRefresh) {
                    setState(() {});
                  },
                )));
  }
}

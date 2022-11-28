import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/Estimation/controller/estimation_list_controller.dart';
import 'package:otobucks/View/Estimation/view/estimation_invoice_screen.dart';

// import 'package:otobucks/controllers/estimation_sidebar_controllers/estimation_list_controller.dart';
import 'package:otobucks/global/constants.dart';

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
                                height:  widget.estimationStatus ==
                                    'submitted'?190:150,
                                margin: const EdgeInsets.only(
                                    bottom: AppDimens.dimens_14),
                                child: Card(
                                  elevation: AppDimens.dimens_3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppDimens.dimens_5),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                      right: AppDimens.dimens_10,
                                    ),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              //------------------Image -----------------
                                              ImageWidget(
                                                imagePath: mEstimatesModel
                                                    .getProviderImage(),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        //---------------UserName
                                                        Expanded(
                                                          child: UserNameWidget(
                                                            userName:
                                                                mEstimatesModel
                                                                    .getProviderName(),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Textwidget(
                                                            text:
                                                                "Service Title: ",
                                                            fontsize: 0,
                                                            fontweight: 0),
                                                        Textwidget(
                                                            text: "Car Wash  ",
                                                            fontsize: 0,
                                                            fontweight: 0),
                                                      ],
                                                    ),
                                                    widget.estimationStatus ==
                                                            'submitted'
                                                        ? Row(
                                                            children: [
                                                              Textwidget(
                                                                  text:
                                                                      "Price :  ",
                                                                  fontsize: 0,
                                                                  fontweight:
                                                                      0),
                                                              priceWidget(
                                                                  mEstimatesModel),
                                                            ],
                                                          )
                                                        : const SizedBox(),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Booking Date : ",
                                                          style: AppStyle
                                                              .textViewStyleSmall(
                                                                  context:
                                                                      context,
                                                                  color: AppColors
                                                                      .grayDashboardText,
                                                                  fontSizeDelta:
                                                                      -2,
                                                                  fontWeightDelta:
                                                                      0),
                                                        ),
                                                        Text(
                                                          mEstimatesModel
                                                              .getDate(),
                                                          style: AppStyle
                                                              .textViewStyleSmall(
                                                                  context:
                                                                      context,
                                                                  color: AppColors
                                                                      .grayDashboardText,
                                                                  fontSizeDelta:
                                                                      -2,
                                                                  fontWeightDelta:
                                                                      0),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          //buttons

                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment: mEstimatesModel
                                                          .status ==
                                                      'submitted'
                                                  ? MainAxisAlignment
                                                      .spaceBetween
                                                  : MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  child: Container(

                                                      child: Padding(
                                                        padding: const EdgeInsets.only(left: 5.0),
                                                        child: Text(
                                                          Constants
                                                              .TXT_VIEW_BOOKING,
                                                          style: AppStyle
                                                              .textViewStyleSmall(
                                                                  context:
                                                                      context,
                                                                  color: AppColors
                                                                      .colorTextBlue2,
                                                                  fontSizeDelta:
                                                                      3,
                                                                  fontWeightDelta:
                                                                      0),
                                                        ),
                                                      )),
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ViewEstimation(
                                                                  mEstimatesModel:
                                                                      mEstimatesModel,
                                                                  screen: widget
                                                                      .screen,
                                                                )));
                                                  },
                                                ),
                                                //Details Button
                                                mEstimatesModel.status ==
                                                        'submitted'
                                                    ? Container(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: InkWell(
                                                          child: Container(
                                                              padding: const EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          6.0,
                                                                      vertical:
                                                                          5.0),
                                                              decoration: AppViews
                                                                  .getGradientBoxDecoration(
                                                                mBorderRadius:
                                                                    5,
                                                              ),
                                                              child: Text(
                                                                "View Estimation",
                                                                style: AppStyle.textViewStyleSmall(
                                                                    context:
                                                                        context,
                                                                    color: AppColors
                                                                        .colorWhite,
                                                                    fontSizeDelta:
                                                                        1,
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
                                                      )
                                                    : SizedBox(),
                                              ],
                                            ),
                                          ),

                                          //---------------Offer Status----------
                                          mEstimatesModel
                                              .status ==
                                              'submitted'?   Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                  .spaceBetween,

                                              children: [
                                                InkWell(
                                                  child: Container(
                                                      // alignment:
                                                      // Alignment.centerLeft,
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(left: 5.0),
                                                        child: Text(
                                                         "Offer Status",

                                                          style: AppStyle
                                                              .textViewStyleSmall(
                                                              context:
                                                              context,
                                                              color: AppColors
                                                                  .colorTextBlue2,
                                                              fontSizeDelta:
                                                              3,
                                                              fontWeightDelta:
                                                              0),
                                                        ),
                                                      )),
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ViewEstimation(
                                                                  mEstimatesModel:
                                                                  mEstimatesModel,
                                                                  screen: widget
                                                                      .screen,
                                                                )));
                                                  },
                                                ),
                                                Container(

                                                  child: InkWell(
                                                    child: Container(
                                                      width: 125,
                                                        padding:const  EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            6.0,
                                                            vertical:
                                                            5.0),
                                                        decoration:BoxDecoration(
                                                          color: Colors.yellow,
                                                            borderRadius: BorderRadius.circular(5.0),
                                                        ),
                                                        // AppViews
                                                        //     .getGradientBoxDecoration(
                                                        //   mBorderRadius:
                                                        //   5,
                                                        // ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              "Pending ",
                                                              style: AppStyle.textViewStyleSmall(
                                                                  context:
                                                                  context,
                                                                  color: AppColors
                                                                      .colorBlack,
                                                                  fontSizeDelta:
                                                                  1,
                                                                  fontWeightDelta:
                                                                  2),
                                                            ),
                                                            Icon(Icons.remove_red_eye_outlined),
                                                          ],
                                                        ),),
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
                                                )

                                              ],
                                            ),
                                          ):SizedBox(),
                                          SizedBox(height: 3.0),
                                        ]),
                                  ),
                                ));
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

  Widget Textwidget({String? text, double? fontsize, int? fontweight}) {
    return Text(
      text ?? "",
      maxLines: 1,
      style: AppStyle.textViewStyleNormalBodyText2(
        context: context,
        color: AppColors.colorBlack2,
        fontSizeDelta: fontsize, //1,
        fontWeightDelta: fontweight,
        //    1
      ),
    );
  }

  Widget UserNameWidget({String? userName}) {
    return Container(
        child: Text(
      userName ?? "",
      maxLines: 1,
      style: AppStyle.textViewStyleNormalBodyText2(
          context: context,
          color: AppColors.colorBlack2,
          fontSizeDelta: 1,
          fontWeightDelta: 1),
    ));
  }

  Widget ImageWidget({String? imagePath}) {
    return Container(
      margin: const EdgeInsets.only(
        right: AppDimens.dimens_10,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimens.dimens_5),
        child: NetworkImageCustom(
            image: imagePath ?? "",
            fit: BoxFit.fill,
            height: AppDimens.dimens_100,
            width: AppDimens.dimens_100),
      ),
    );
  }

  // if (widget
  //     .estimationStatus ==
  // 'submitted')
  Widget priceWidget(EstimatesModel mEstimatesModel) {
    return Container(
        alignment: Alignment.centerLeft,
        child: Text(
          "AED ${mEstimatesModel.source!.price}/-",
          // mEstimatesModel
          //     .itemModel
          //     .isNotEmpty
          //     ? GradientText(
          //   Global.checkNull(mEstimatesModel
          //       .source
          //       ?.price)
          //       ? Global.replaceCurrencySign(
          //       "USD") +
          //       "" +
          //       mEstimatesModel
          //           .itemModel[0]
          //           .amount +
          //       "/-"
          //       : "",
          style: AppStyle.textViewStyleNormalBodyText2(
              context: context,
              color: AppColors.colorBlack,
              fontSizeDelta: 1,
              fontWeightDelta: 1),
        ));
  }
}

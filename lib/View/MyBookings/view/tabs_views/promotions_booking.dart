import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:otobucks/global/enum.dart';

import 'package:otobucks/widgets/fade_in_image.dart';
import 'package:otobucks/widgets/gradient_text.dart';
import '../../../../../global/app_colors.dart';
import '../../../../../global/app_dimens.dart';
import '../../../../../global/app_style.dart';
import '../../../../../global/app_views.dart';
import '../../../../global/constants.dart';
import '../../../../global/global.dart';
import '../../../Rating/Views/rating_page.dart';
import '../../Models/PromotionBookingModel.dart';
import '../../controller/mybookings_controller.dart';
import 'give_rating.dart';

class PromotionsBookingView extends GetView<MyBookingsController> {
  const PromotionsBookingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.isSearching = false;
    controller.isSearchingTypePromotion = true;
    Get.put(MyBookingsController());
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColors.getMainBgColor(),
          body: GetBuilder<MyBookingsController>(builder: (context) {
            return FutureBuilder<PromotionBookingHistory>(
                future: controller.futurePromotionBookings,
                builder: (context, snapshot) {
                  controller.promotionBookingList = snapshot.data?.result;
                  if (snapshot.hasData) {
                    return RefreshIndicator(
                      onRefresh: controller.refreshBookings,
                      child: ListView.builder(
                        itemCount: controller.isSearching == true
                            ? controller.filteredPromotionBookingList!.length
                            : snapshot.data?.result?.length,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        itemBuilder: (BuildContext contextM, index) {
                          var data = controller.isSearching == false
                              ? snapshot.data?.result![index]
                              : controller.filteredPromotionBookingList![index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: AppColors.grayDashboardItem,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.only(
                                  top: 10,
                                  right: AppDimens.dimens_10,
                                  left: 10,
                                  bottom: 7),
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        //------------------ column Image  amd view booking-----------------
                                        Column(
                                          children: [
                                            imageWidget(
                                                imagePath: data
                                                    ?.promotion?.promoImg?.first
                                                    .toString()),
                                            const SizedBox(
                                              height: AppDimens.dimens_12,
                                            ),

                                            /// onclick of view booking
                                            // InkWell(
                                            //     child: Container(
                                            //         alignment: Alignment.center,
                                            //         child: Padding(
                                            //           padding:
                                            //               const EdgeInsets.only(
                                            //                   right: 8.0),
                                            //           child: Text(
                                            //             "Complete".tr,
                                            //             style: AppStyle
                                            //                 .textViewStyleSmall(
                                            //                     context:
                                            //                         context,
                                            //                     color: AppColors
                                            //                         .colorTextBlue2,
                                            //                     fontSizeDelta:
                                            //                         0,
                                            //                     fontWeightDelta:
                                            //                         0),
                                            //           ),
                                            //         )),
                                            //     onTap: () {
                                            //       markProvidedDialog();
                                            //       // if (data.status ==
                                            //       //     "inProgress") {
                                            //       //   //reschedule and decline
                                            //       //   Get.to(
                                            //       //       ViewBookingEstimation(
                                            //       //           status:
                                            //       //               "inProgress",
                                            //       //           mEstimatesModel:
                                            //       //               data,
                                            //       //           isPending:
                                            //       //               false));
                                            //       // } else {
                                            //       //   Get.to(
                                            //       //       ViewBookingEstimation(
                                            //       //           mEstimatesModel:
                                            //       //               data));
                                            //       // }
                                            //     }),
                                          ],
                                        ),
                                        addHorizontalSpace(8),
                                        //..........................right side data column
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  //---------------UserName
                                                  Expanded(
                                                    child: userNameWidget(
                                                        userName:
                                                            "${data?.provider?.firstName}"
                                                            " "
                                                            "${data?.provider?.lastName} "),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  textwidget(
                                                      text: "Promotion Title: "
                                                          .tr,
                                                      fontsize: 0,
                                                      fontweight: 0),
                                                  Flexible(
                                                    child: textwidget(
                                                        text:
                                                            "${data?.promotion?.title}",
                                                        fontsize: 0,
                                                        fontweight: 0),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  textwidget(
                                                      text: "Paid  : ".tr,
                                                      fontsize: 0,
                                                      fontweight: 0),
                                                  Text(
                                                    "AED ${data?.totalprice}/-"
                                                        .tr,
                                                    style: AppStyle
                                                        .textViewStyleNormalBodyText2(
                                                            context:
                                                                Get.context!,
                                                            color: Colors.green,
                                                            fontSizeDelta: 1,
                                                            fontWeightDelta: 3),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Booking Date : ".tr,
                                                    style: AppStyle
                                                        .textViewStyleSmall(
                                                            context: context,
                                                            color: AppColors
                                                                .colorBlack,
                                                            fontSizeDelta: -1,
                                                            fontWeightDelta: 0),
                                                  ),
                                                  Text(
                                                    getDate(data!.createdAt!),
                                                    style: AppStyle
                                                        .textViewStyleSmall(
                                                            context: context,
                                                            color: AppColors
                                                                .colorBlack,
                                                            fontSizeDelta: -1,
                                                            fontWeightDelta: 0),
                                                  ),
                                                ],
                                              ),

                                              ///........... estimation and status row button

                                              const Divider(
                                                thickness: 1,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        if(data.status=="booked"){
                                                          Global.showToastAlert(context: context, strTitle: "Message", strMsg: "Your booking is not completed yet", toastType: TOAST_TYPE.toastSuccess);
                                                        }
                                                        else{
                                                          displayTextInputDialog(
                                                              context, data.sId!);
                                                        }

                                                      },
                                                      child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      6.0,
                                                                  vertical:
                                                                      4.0),
                                                          decoration: BoxDecoration(
                                                              color: AppColors
                                                                  .colorYellowShade,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          2)),
                                                          child: Center(
                                                            child: Text(
                                                              "Give rating"
                                                                  .tr
                                                                  .toUpperCase(),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                                  addHorizontalSpace(10),
                                                  //----------------------Booked Status--------------------------------------
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        // displayTextInputDialog(
                                                        //     context,
                                                        //     data.sId!);
                                                      },
                                                      child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      6.0,
                                                                  vertical:
                                                                      4.0),
                                                          decoration: BoxDecoration(
                                                              color: AppColors
                                                                  .colorPrimary,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          2)),
                                                          child: Center(
                                                            child: Text(
                                                              "${data.status}"
                                                                  .tr
                                                                  .toUpperCase(),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    //buttons

                                    const SizedBox(height: 3.0),
                                  ]),
                            ),
                          );

                          ///////////////////////////////// ////////////////////////////////////////////////////////////////
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    const Center(child: Text("No data found"));
                  }
                  return const Center(child: CircularProgressIndicator());
                });
          }),
        ));
  }

  // gotoViewEstimation(EstimatesModel mEstimatesModel, bool makePayment) {
  //   Get.to(EstimationDetailsPDFScreen(
  //     mEstimatesModel: mEstimatesModel,
  //   ));
  // }

  Widget textwidget({String? text, double? fontsize, int? fontweight}) {
    return Text(
      text?.tr ?? "".tr,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: AppStyle.textViewStyleNormalBodyText2(
        context: Get.context!,
        color: AppColors.colorBlack2,
        fontSizeDelta: fontsize, //1,
        fontWeightDelta: fontweight,
        //    1
      ),
    );
  }

  Widget userNameWidget({String? userName}) {
    return Text(
      userName ?? "".tr,
      maxLines: 1,
      style: AppStyle.textViewStyleNormalBodyText2(
          context: Get.context!,
          color: AppColors.colorBlack2,
          fontSizeDelta: 1,
          fontWeightDelta: 1),
    );
  }

  Widget imageWidget({String? imagePath}) {
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
  Widget priceWidget(String price) {
    return Container(
        alignment: Alignment.centerLeft,
        child:
            // "AED ${mEstimatesModel.grandTotal}/-",
            GradientText(
          "AED $price /-".tr,
          // Global.checkNull(mEstimatesModel
          //     .source
          //     ?.price)
          //     ? Global.replaceCurrencySign(
          //     "USD") +
          //     "" +
          //     mEstimatesModel
          //         .itemModel[0]
          //         .amount +
          //     "/-"
          style: AppStyle.textViewStyleNormalBodyText2(
              context: Get.context!,
              color: AppColors.colorBlueStart,
              fontSizeDelta: 1,
              fontWeightDelta: 3),
        ));
  }

  getDate(String date) {
    if (Global.checkNull(date)) {
      DateTime parseDate =
          DateFormat(Constants.STRING_DB_DATE_FORMATE).parse(date);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat(Constants.STRING_DD_MMM_YYYY);
      var outputDate = outputFormat.format(inputDate);
      return outputDate.toString();
    } else {
      return "";
    }
  }

  displayTextInputDialog(BuildContext context, String bookingId) async {
    Get.to(PromotionRatingScreen(
      bookingId: bookingId,
    ));
  }

  markProvidedDialog() {
    return Get.defaultDialog(
        title: "Complete Booking",
        titleStyle: TextStyle(fontSize: 18, color: AppColors.colorPrimary),
        middleText: "Are you sure you want to mark this booking as completed ?",
        onConfirm: () {},
        textCancel: "Close",
        textConfirm: "Confirm",
        confirmTextColor: Colors.white,
        radius: 10,
        barrierDismissible: false);
  }
}

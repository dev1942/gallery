import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:otobucks/View/MyBookings/Models/view_booking_model.dart';

import 'package:otobucks/widgets/fade_in_image.dart';
import 'package:otobucks/widgets/gradient_text.dart';
import '../../../../../global/app_colors.dart';
import '../../../../../global/app_dimens.dart';
import '../../../../../global/app_style.dart';
import '../../../../../global/app_views.dart';
import '../../../../global/constants.dart';
import '../../../../global/global.dart';
import '../../controller/mybookings_controller.dart';
import '../view_booking_screen.dart';

class CancelledFragment extends GetView<MyBookingsController> {
  const CancelledFragment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.isSearching = false;
    controller.isSearchingTypePromotion = false;
    Get.put(MyBookingsController());
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColors.getMainBgColor(),
          body: GetBuilder<MyBookingsController>(builder: (context) {
            return FutureBuilder<BookingModel>(
                future: controller.futurBookings,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return RefreshIndicator(
                      onRefresh: controller.refreshBookings,
                      child: ListView.builder(
                        itemCount: controller.isSearching == true ? controller.filteredBookingList!.length : snapshot.data?.result?.length,
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        itemBuilder: (BuildContext contextM, index) {
                          List inProcgressList = snapshot.data!.result!.reversed.toList();
                          var data = controller.isSearching == false ? inProcgressList[index] : controller.filteredBookingList![index];
                          if ((data.status == "cancelled" || data.status == "declined" && data.deleted == false)&& data.provider!=null) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6.0),
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: AppColors.grayDashboardItem,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.only(top: 10, right: AppDimens.dimens_10, left: 10, bottom: 7),
                                    margin: const EdgeInsets.symmetric(horizontal: 5),
                                    child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                                      //Row left image and right data
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          //------------------ column Image  amd view booking-----------------
                                          Column(
                                            children: [
                                              imageWidget(imagePath: data.source?.image?.first),
                                              const SizedBox(
                                                height: AppDimens.dimens_12,
                                              ),

                                              /// onclick of view booking
                                              InkWell(
                                                child: Container(
                                                    padding: const EdgeInsets.only(right: 8.0),
                                                    child: Text(
                                                      Constants.TXT_VIEW_BOOKING.tr,
                                                      style: AppStyle.textViewStyleSmall(
                                                          context: context, color: AppColors.colorTextBlue2, fontSizeDelta: 0, fontWeightDelta: 0),
                                                    )),
                                                onTap: () {
                                                  if (data.status == "cancelled" || data.status == "declined") {
                                                    //reschedule and decline
                                                    Get.to(ViewBookingEstimation(status: "cancelled", mEstimatesModel: data, isPending: false));
                                                  } else {
                                                    Get.to(ViewBookingEstimation(mEstimatesModel: data));
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                          addHorizontalSpace(8),
                                          //..........................right side data column
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    //---------------UserName
                                                    Expanded(
                                                      child: userNameWidget(
                                                          userName: "${data.provider?.firstName}" " "
                                                              "${data.provider?.lastName} "),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    textwidget(text: "Service Title: ".tr, fontsize: 0, fontweight: 0),
                                                    textwidget(text: data.source?.title ?? "", fontsize: 0, fontweight: 0),
                                                  ],
                                                ),
                                                Text(
                                                  "Booking Cancelled".tr,
                                                  style: TextStyle(color: AppColors.colorCancelledText),
                                                ),
                                                Row(
                                                  children: [
                                                    textwidget(text: "Price :  ".tr, fontsize: 0, fontweight: 0),
                                                    priceWidget(data.source!.price.toString()),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Booking Date : ".tr,
                                                      style: AppStyle.textViewStyleSmall(
                                                          context: context, color: AppColors.colorBlack, fontSizeDelta: -1, fontWeightDelta: 0),
                                                    ),
                                                    Text(
                                                      getDate(data.bookingDetails!.date.toString()),
                                                      style: AppStyle.textViewStyleSmall(
                                                          context: context, color: AppColors.colorBlack, fontSizeDelta: -1, fontWeightDelta: 0),
                                                    ),
                                                  ],
                                                ),

                                                ///........... estimation and status row butto
                                                Divider(
                                                  color: Colors.grey.shade500,
                                                  thickness: 1,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  //     : MainAxisAlignment.center,
                                                  children: [
                                                    ///rebook onclick
                                                    InkWell(
                                                      child: Container(
                                                          width: Get.width / 2.6,
                                                          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 5.0),
                                                          decoration: AppViews.getGradientBoxDecoration(mBorderRadius: 2),
                                                          child: Center(
                                                            child: Text(
                                                              "re-book".tr.toUpperCase(),
                                                              style:
                                                                  TextStyle(color: AppColors.colorWhite, fontSize: 12, fontWeight: FontWeight.w500),
                                                            ),
                                                          )),
                                                      onTap: () {
                                                        // sdfa;lf
                                                        // gotoViewEstimation(
                                                        //     AllBookingsModel(),
                                                        //     false);false
                                                        Get.to(ViewBookingEstimation(
                                                          mEstimatesModel: data,
                                                          isPending: true,
                                                          isRebooked: true,
                                                        ));
                                                      },
                                                    ),
                                                    const SizedBox(
                                                      width: 3,
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
                                  Positioned(
                                    right: 5,
                                    top: 5,
                                    child: InkWell(
                                      onTap: () {
                                        controller.deleteBooking(bookingID: data.id);
                                        snapshot.data?.result?.removeWhere((element) => element.id == data.id);
                                        controller.update();
                                      },
                                      child: Icon(
                                        Icons.delete_outline,
                                        color: AppColors.colorCancelledText,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                          ///////////////////////////////// ////////////////////////////////////////////////////////////////
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    Center(child: Text("No data found".tr));
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
    return Flexible(
      child: Text(
        text ?? "",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppStyle.textViewStyleNormalBodyText2(
          context: Get.context!,
          color: AppColors.colorBlack2,
          fontSizeDelta: fontsize, //1,
          fontWeightDelta: fontweight,
          //    1
        ),
      ),
    );
  }

  Widget userNameWidget({String? userName}) {
    return Text(
      userName ?? "",
      maxLines: 1,
      style: AppStyle.textViewStyleNormalBodyText2(context: Get.context!, color: AppColors.colorBlack2, fontSizeDelta: 1, fontWeightDelta: 1),
    );
  }

  Widget imageWidget({String? imagePath}) {
    return Container(
      margin: const EdgeInsets.only(
        right: AppDimens.dimens_10,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimens.dimens_5),
        child: NetworkImageCustom(image: imagePath ?? "", fit: BoxFit.fill, height: AppDimens.dimens_100, width: AppDimens.dimens_100),
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
          "AED $price",
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

          style: AppStyle.textViewStyleNormalBodyText2(context: Get.context!, color: AppColors.colorBlueStart, fontSizeDelta: 1, fontWeightDelta: 3),
        ));
  }

  getDate(String date) {
    if (Global.checkNull(date)) {
      DateTime parseDate = DateFormat(Constants.STRING_DB_DATE_FORMATE).parse(date);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat(Constants.STRING_DD_MMM_YYYY);
      var outputDate = outputFormat.format(inputDate);
      return outputDate.toString();
    } else {
      return "";
    }
  }
}

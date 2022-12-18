import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:otobucks/widgets/fade_in_image.dart';
import 'package:otobucks/widgets/gradient_text.dart';
import '../../../../../global/app_colors.dart';
import '../../../../../global/app_dimens.dart';
import '../../../../../global/app_style.dart';
import '../../../../../global/app_views.dart';
import '../../../../global/constants.dart';
import '../../../../global/global.dart';
import '../../Models/AllBookingsModel.dart';
import '../../controller/mybookings_controller.dart';
import '../view_booking_screen.dart';

class CancelledFragment extends GetView<MyBookingsController> {
  const CancelledFragment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(MyBookingsController());
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColors.getMainBgColor(),
          body: FutureBuilder<AllBookingsModel>(
              future: controller.getAllBookings(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.result!.length,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    itemBuilder: (BuildContext contextM, index) {
                      List inProcgressList =
                          snapshot.data!.result!.reversed.toList();
                      var data = inProcgressList[index];
                      if (data.status == "cancelled" || data.status == "declined") {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Card(
                            elevation: AppDimens.dimens_6,
                            shadowColor: Colors.white,
                            surfaceTintColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(AppDimens.dimens_7),
                            ),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 10,
                                  right: AppDimens.dimens_10,
                                  left: 5,
                                  bottom: 7),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    //Row left image and right data
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        //------------------ column Image  amd view booking-----------------
                                        Column(
                                          children: [
                                            ImageWidget(
                                                imagePath:
                                                    data.source?.image?.first),
                                            const SizedBox(
                                              height: AppDimens.dimens_12,
                                            ),

                                            /// onclick of view booking
                                            InkWell(
                                              child: Container(
                                                  child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: Text(
                                                  Constants.TXT_VIEW_BOOKING,
                                                  style: AppStyle
                                                      .textViewStyleSmall(
                                                          context: context,
                                                          color: AppColors
                                                              .colorTextBlue2,
                                                          fontSizeDelta: 0,
                                                          fontWeightDelta: 0),
                                                ),
                                              )),
                                              onTap: () {
                                                if (data.status ==
                                                    "cancelled" || data.status == "declined") {
                                                  //reschedule and decline
                                                  Get.to(
                                                      ViewBookingEstimation(
                                                          mEstimatesModel: data,
                                                          isPending: false)
                                                  );
                                                } else {
                                                  Get.to(
                                                      ViewBookingEstimation(
                                                          mEstimatesModel: data));
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                        //..........................right side data column
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  //---------------UserName
                                                  Expanded(
                                                    child: UserNameWidget(
                                                        userName:
                                                            "${data.customer?.firstName}"
                                                            "${data.customer?.lastName} "),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Textwidget(
                                                      text: "Service Title: ",
                                                      fontsize: 0,
                                                      fontweight: 0),
                                                  Textwidget(
                                                      text:
                                                          data.source?.title ??
                                                              "",
                                                      fontsize: 0,
                                                      fontweight: 0),
                                                ],
                                              ),
                                              Text(
                                                "Booking Cancelled",
                                                style: TextStyle(
                                                    color: Colors.pink),
                                              ),
                                              Row(
                                                children: [
                                                  Textwidget(
                                                      text: "Price :  ",
                                                      fontsize: 0,
                                                      fontweight: 0),
                                                  priceWidget(data.source!.price
                                                      .toString()),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Booking Date : ",
                                                    style: AppStyle
                                                        .textViewStyleSmall(
                                                            context: context,
                                                            color: AppColors
                                                                .colorBlack,
                                                            fontSizeDelta: -1,
                                                            fontWeightDelta: 0),
                                                  ),
                                                  Text(
                                                    getDate(data
                                                        .bookingDetails!.date.toString()),
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

                                              ///........... estimation and status row butto
                                              Divider(
                                                color: Colors.grey.shade500,
                                                thickness: 1,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                //     : MainAxisAlignment.center,
                                                children: [
                                                  ///rebook onclick
                                                  InkWell(
                                                    child: Container(
                                                        width: Get.width / 2.6,
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 6.0,
                                                                vertical: 5.0),
                                                        decoration: AppViews
                                                            .getGradientBoxDecoration(
                                                                mBorderRadius:
                                                                    2),
                                                        child: Center(
                                                          child: Text(
                                                            "re-book"
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .colorWhite,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        )),
                                                    onTap: () {
                                                      // gotoViewEstimation(
                                                      //     AllBookingsModel(),
                                                      //     false);false
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
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                      ///////////////////////////////// ////////////////////////////////////////////////////////////////
                    },
                  );
                } else if (snapshot.hasError) {
                  const Center(child: Text("No data found"));
                }
                return const Center(child: CircularProgressIndicator());
              }),
        ));
  }

  // gotoViewEstimation(EstimatesModel mEstimatesModel, bool makePayment) {
  //   Get.to(EstimationDetailsPDFScreen(
  //     mEstimatesModel: mEstimatesModel,
  //   ));
  // }

  Widget Textwidget({String? text, double? fontsize, int? fontweight}) {
    return Text(
      text ?? "",
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

  Widget UserNameWidget({String? userName}) {
    return Container(
        child: Text(
      userName ?? "",
      maxLines: 1,
      style: AppStyle.textViewStyleNormalBodyText2(
          context: Get.context!,
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
  Widget priceWidget(String price) {
    return Container(
        alignment: Alignment.centerLeft,
        child:
            // "AED ${mEstimatesModel.grandTotal}/-",
            GradientText(
          "AED ${price}",
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
          DateFormat(Constants.STRING_DB_DATE_FORMATE).parse(date!);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat(Constants.STRING_DD_MMM_YYYY);
      var outputDate = outputFormat.format(inputDate);
      return outputDate.toString();
    } else {
      return "";
    }
  }
}

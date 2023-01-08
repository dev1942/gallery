import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:otobucks/View/Estimation/Views/estimation_invoice_screen.dart';
import 'package:otobucks/View/MyBookings/Models/view_booking_model.dart';
import 'package:otobucks/widgets/fade_in_image.dart';
import 'package:otobucks/widgets/gradient_text.dart';
import '../../../../../global/app_colors.dart';
import '../../../../../global/app_dimens.dart';
import '../../../../../global/app_style.dart';
import '../../../../../global/app_views.dart';
import '../../../../global/constants.dart';
import '../../../../global/global.dart';
import '../../Models/AllBookingsModel.dart';
import 'package:otobucks/global/enum.dart';
import '../../controller/mybookings_controller.dart';
import '../view_booking_screen.dart';
import 'package:otobucks/View/MyBookings/Models/view_booking_model.dart'
    as viewBookingModel;
import 'package:otobucks/View/MyBookings/Models/AllBookingsModel.dart'
    as bookingResult;

class PendingFragment extends GetView<MyBookingsController> {
  const PendingFragment({
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
          body: GetBuilder<MyBookingsController>(builder: (context) {
            return FutureBuilder<BookingModel>(
                // body: FutureBuilder<AllBookingsModel>(
                future: controller.futurBookings,
                builder: (context, snapshot) {
                  print(snapshot.hasData);
                  print("----------------snapshot has data----------");
                  if (snapshot.hasData) {
                    return GetBuilder<MyBookingsController>(
                        init: MyBookingsController(),
                        builder: (context) {
                          return RefreshIndicator(
                            onRefresh: controller.refreshBookings,

                            child: ListView.builder(
                              itemCount: snapshot.data?.result!.length,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              itemBuilder: (BuildContext contextM, index) {
                                controller.pendingsbookinglist =
                                    snapshot.data!.result!.reversed.toList()
                                        as List<Result>;
                                var data = controller.pendingsbookinglist![index];

                                if (data.status == "submitted" ||
                                    data.status == "pending" ||
                                    data.status == "reSubmitted") {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 6.0),
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
                                      margin: EdgeInsets.symmetric(horizontal: 5),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            //Row left image and right data
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                //------------------ column Image  amd view booking-----------------
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    ImageWidget(
                                                        imagePath: data.source
                                                            ?.image?.first),
                                                    const SizedBox(
                                                      height: AppDimens.dimens_12,
                                                    ),
//--------------------------------View booking--------------------------
                                                    /// onclick of view booking
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 10.0),
                                                      child: InkWell(
                                                        child: Container(
                                                            child: Center(
                                                          child: Text(
                                                            Constants
                                                                .TXT_VIEW_BOOKING
                                                                .tr,
                                                            style: AppStyle
                                                                .textViewStyleSmall(
                                                                    context: Get
                                                                        .context!,
                                                                    color: AppColors
                                                                        .colorTextBlue2,
                                                                    fontSizeDelta:
                                                                        0,
                                                                    fontWeightDelta:
                                                                        0),
                                                          ),
                                                        )),
                                                        onTap: () {
                                                          if (data.status ==
                                                              "pending") {
                                                            //reschedule and decline
                                                            // print(data.bookingDetails!.customerNote.toString());
                                                            Get.to(ViewBookingEstimation(
                                                                mEstimatesModel: data
                                                                    as viewBookingModel
                                                                        .Result,
                                                                isPending: true));
                                                          } else {
                                                            Get.to(ViewBookingEstimation(
                                                                mEstimatesModel: data
                                                                    as viewBookingModel
                                                                        .Result));
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                addHorizontalSpace(5),
                                                //..........................right side data column
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          //---------------UserName
                                                          Expanded(
                                                            child: UserNameWidget(
                                                                userName:
                                                                    "${data.provider?.firstName?.toUpperCase()}"
                                                                    " "
                                                                    "${data.provider?.lastName?.toUpperCase()} "),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Textwidget(
                                                              text:
                                                                  "Service Title: "
                                                                      .tr,
                                                              fontsize: 0,
                                                              fontweight: 0),
                                                          Textwidget(
                                                              text: data.source
                                                                      ?.title ??
                                                                  "",
                                                              fontsize: 0,
                                                              fontweight: 0),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Textwidget(
                                                              text:
                                                                  "Price :  ".tr,
                                                              fontsize: 0,
                                                              fontweight: 0),
                                                          priceWidget(
                                                              "${data.source!.price}/hr"
                                                                  .toString()),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Booking Date : ".tr,
                                                            style: AppStyle
                                                                .textViewStyleSmall(
                                                                    context: Get
                                                                        .context!,
                                                                    color: AppColors
                                                                        .colorBlack,
                                                                    fontSizeDelta:
                                                                        -1,
                                                                    fontWeightDelta:
                                                                        0),
                                                          ),
                                                          Text(
                                                            getDate(data
                                                                .bookingDetails!
                                                                .date!),
                                                            style: AppStyle
                                                                .textViewStyleSmall(
                                                                    context: Get
                                                                        .context!,
                                                                    color: AppColors
                                                                        .colorBlack,
                                                                    fontSizeDelta:
                                                                        -1,
                                                                    fontWeightDelta:
                                                                        0),
                                                          ),
                                                        ],
                                                      ),
                                                      Divider(
                                                        thickness: 1,
                                                      ),

                                                      ///........... estimation and status row button

                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        //     : MainAxisAlignment.center,
                                                        children: [
                                                          ///on click view estimation
                                                          InkWell(
                                                            child: Container(
                                                                width: Get.width /
                                                                    3.2,
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        6.0,
                                                                    vertical:
                                                                        6.0),
                                                                decoration: AppViews
                                                                    .getGradientBoxDecoration(
                                                                        mBorderRadius:
                                                                            2),
                                                                //.....estimation staus............
                                                                child: Center(
                                                                  child: Text(
                                                                    data.status ==
                                                                            "pending"
                                                                        ? "Requested"
                                                                            .tr
                                                                        : "View Estimation"
                                                                            .tr
                                                                            .toUpperCase(),
                                                                    style: TextStyle(
                                                                        color: AppColors
                                                                            .colorWhite,
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500),
                                                                  ),
                                                                )),
                                                            onTap: () {
                                                              if (data.status !=
                                                                  "pending") {
                                                                //items data isEmpty or Not
                                                                if (snapshot
                                                                    .data!
                                                                    .result!
                                                                    .first
                                                                    .estimation!
                                                                    .items!
                                                                    .isNotEmpty) {
                                                                  Get.to(EstimationDetailsPDFScreen(
                                                                      allBookingsModel: data
                                                                          as viewBookingModel
                                                                              .Result));
                                                                } else {
                                                                  Global.showToastAlert(
                                                                      context: Get
                                                                          .overlayContext!,
                                                                      strTitle:
                                                                          "",
                                                                      strMsg:
                                                                          "Estimation Data incomplete",
                                                                      toastType:
                                                                          TOAST_TYPE
                                                                              .toastInfo);
                                                                }
                                                                //
                                                              }
                                                            },
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),

                                                          /// ofer Status button
                                                          data.estimation
                                                                      ?.isOfferCreated ==
                                                                  true
                                                              ? Expanded(
                                                                  child: InkWell(
                                                                    child:
                                                                        Container(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              6.0,
                                                                          vertical:
                                                                              5.0),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: data.estimation?.offerStatus ==
                                                                                "accepted"
                                                                            ? AppColors
                                                                                .colorSuccessBackground
                                                                            : data.estimation?.offerStatus == "declined"
                                                                                ? AppColors.colorCancelledBackground
                                                                                : AppColors.colorPendingBackground,
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                2.0),
                                                                        border:
                                                                            Border
                                                                                .all(
                                                                          width:
                                                                              1,
                                                                          color: data.estimation?.offerStatus ==
                                                                                  "accepted"
                                                                              ? AppColors.colorSuccessBorder
                                                                              : data.estimation?.offerStatus == "declined"
                                                                                  ? AppColors.colorCancelledBorder
                                                                                  : AppColors.colorPendingBorder,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          "${data.estimation?.offerStatus}".tr.toUpperCase() ??
                                                                              "",
                                                                          style:
                                                                              TextStyle(
                                                                            color: data.estimation?.offerStatus == "accepted"
                                                                                ? AppColors.colorSuccessText
                                                                                : data.estimation?.offerStatus == "declined"
                                                                                    ? AppColors.colorCancelledText
                                                                                    : AppColors.colorPendingText,
                                                                            fontSize:
                                                                                10,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    onTap: () {
                                                                      showDialog<
                                                                              String>(
                                                                          context: Get
                                                                              .context!,
                                                                          builder: (BuildContext
                                                                                  context) =>
                                                                              AlertDialog(
                                                                                title: const Text(
                                                                                  'Offering Amount',
                                                                                  textAlign: TextAlign.center,
                                                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                                                ),
                                                                                content: Column(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    Text(
                                                                                      "${data.estimation?.offerAmount} AED".tr,
                                                                                      style: AppStyle.textViewStyleSmall(context: context, color: AppColors.colorBlack, fontSizeDelta: 8, fontWeightDelta: 2),
                                                                                    ),
                                                                                    Container(
                                                                                      child: Text(
                                                                                        // " dsfjlasd ladjfl klfjl;asf l;sa lsjflks jlkdf lkdfkadjlfjal; fkdalkdf dlkfj;la sd",
                                                                                        "${data.estimation?.offerNote}",
                                                                                        textAlign: TextAlign.center,
                                                                                        style: AppStyle.textViewStyleSmall(context: context, color: AppColors.colorBlack, fontSizeDelta: 3, fontWeightDelta: -1),
                                                                                      ),
                                                                                    ),
                                                                                    InkWell(
                                                                                      onTap: () {
                                                                                        Navigator.pop(context);
                                                                                      },
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                        child: Container(
                                                                                          decoration: BoxDecoration(
                                                                                            gradient: LinearGradient(
                                                                                              begin: Alignment.topCenter,
                                                                                              end: Alignment.bottomCenter,
                                                                                              colors: [
                                                                                                AppColors.colorBlueEnd,
                                                                                                AppColors.colorBlueStart,
                                                                                              ],
                                                                                            ),
                                                                                            borderRadius: BorderRadius.circular(5.0),
                                                                                          ),
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
                                                                                            child: Text('Close'.tr, textAlign: TextAlign.center, style: AppStyle.textViewStyleNormalButton(context: context, color: Colors.white, fontSizeDelta: 0, fontWeightDelta: 2)),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ));

                                                                      if (data.estimation
                                                                              ?.offerStatus ==
                                                                          'submitted') {
                                                                        gotoViewEstimation(
                                                                            data,
                                                                            false);
                                                                      }
                                                                    },
                                                                  ),
                                                                )
                                                              : SizedBox()
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
                                } else {
                                  return SizedBox();
                                }
                              },
                            ),
                          );
                        });
                  } else if (snapshot.hasError) {
                    const Center(child: Text("No data found"));
                  }
                  return const Center(child: CircularProgressIndicator());
                });
          }),
        ));
  }

  gotoViewEstimation(dynamic allBookingsModel, bool makePayment) {
    Get.to(EstimationDetailsPDFScreen(
      allBookingsModel: allBookingsModel,
    ));
  }

  Widget Textwidget({String? text, double? fontsize, int? fontweight}) {
    return Flexible(
      child: Text(
        text ?? "".tr,
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

  Widget UserNameWidget({String? userName}) {
    return Container(
        child: Text(
      userName ?? "".tr,
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
          "AED ${price}".tr,
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:otobucks/View/MyBookings/controller/estimation_list_controller.dart';
import 'package:otobucks/View/MyBookings/view/estimation_invoice_screen.dart';
import 'package:otobucks/widgets/fade_in_image.dart';
import 'package:otobucks/widgets/gradient_text.dart';
import '../../../../../global/app_colors.dart';
import '../../../../../global/app_dimens.dart';
import '../../../../../global/app_style.dart';
import '../../../../../global/app_views.dart';
import '../../../../global/constants.dart';
import '../../../../global/global.dart';
import '../../../../model/estimates_model.dart';
import '../../Models/AllBookingsModel.dart';
import '../../controller/mybookings_controller.dart';
import '../view_booking_screen.dart';

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
          body: FutureBuilder<AllBookingsModel>(
              future: controller.getAllBookings(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.result
                        ?.where((element) =>
                            element.status == "pending" ||
                            element.status == "submitted")
                        .length,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    itemBuilder: (BuildContext contextM, index) {
                      var data = snapshot.data!.result![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Card(
                          elevation: AppDimens.dimens_8,
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
                                                  left: 5.0),
                                              child: Text(
                                                Constants.TXT_VIEW_BOOKING,
                                                style:
                                                    AppStyle.textViewStyleSmall(
                                                        context: context,
                                                        color: AppColors
                                                            .colorTextBlue2,
                                                        fontSizeDelta: 0,
                                                        fontWeightDelta: 0),
                                              ),
                                            )),
                                            onTap: () {
                                              //Navigator.push(
                                              //  context,
                                              // MaterialPageRoute(
                                              //     builder: (context) =>
                                              //         ViewBookingEstimation(
                                              //           //ViewEstimation(
                                              //           mEstimatesModel:
                                              //           mEstimatesModel, screen: '',
                                              //         )));
                                            },
                                          ),
                                        ],
                                      ),
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
                                                    text: data.source?.title ??
                                                        "",
                                                    fontsize: 0,
                                                    fontweight: 0),
                                              ],
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
                                                      .bookingDetails!.date!),
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
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              //     : MainAxisAlignment.center,
                                              children: [
                                                ///on click view estimation
                                                InkWell(
                                                  child: Container(
                                                      width: 130,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 6.0,
                                                          vertical: 5.0),
                                                      decoration: AppViews
                                                          .getGradientBoxDecoration(
                                                              mBorderRadius: 2),
                                                      //.....estimation staus............
                                                      child: Center(
                                                        child: Text(
                                                          data.status ==
                                                                  "pending"
                                                              ? "View Estimation"
                                                              : "Requested Estimation"
                                                                  .toUpperCase(),
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .colorWhite,
                                                              fontSize: 10,
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

                                                /// ofer Status button
                                                data.estimation
                                                            ?.isOfferCreated ==
                                                        true
                                                    ? InkWell(
                                                        child: Container(
                                                          width: 110,
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      6.0,
                                                                  vertical:
                                                                      5.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: data.estimation
                                                                        ?.offerStatus ==
                                                                    "accepted"
                                                                ? Colors.green
                                                                : data.estimation
                                                                            ?.offerStatus ==
                                                                        "declined"
                                                                    ? Colors
                                                                        .pink
                                                                    : Colors
                                                                        .yellow,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2.0),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              "Offer ${data.estimation?.offerStatus}"
                                                                      .toUpperCase() ??
                                                                  "",
                                                              style: TextStyle(
                                                                color: data.estimation
                                                                            ?.offerStatus ==
                                                                        "accepted"
                                                                    ? AppColors
                                                                        .colorWhite
                                                                    : Colors
                                                                        .black,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          showDialog<String>(
                                                              context: context,
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  AlertDialog(
                                                                    title:
                                                                        const Text(
                                                                      ' Offering Amount ',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    content:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        Text(
                                                                          "${data.estimation?.grandTotal} AED",
                                                                          style: AppStyle.textViewStyleSmall(
                                                                              context: context,
                                                                              color: AppColors.colorBlack,
                                                                              fontSizeDelta: 8,
                                                                              fontWeightDelta: 2),
                                                                        ),
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Container(
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
                                                                                child: Text('Cancel', textAlign: TextAlign.center, style: AppStyle.textViewStyleNormalButton(context: context, color: Colors.white, fontSizeDelta: 0, fontWeightDelta: 2)),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ));

                                                          // if (mEstimatesModel
                                                          //     .status ==
                                                          //     'submitted') {
                                                          //   gotoViewEstimation(
                                                          //       mEstimatesModel,
                                                          //       false);
                                                          //}
                                                        },
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
                        ),
                      );
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

  gotoViewEstimation(EstimatesModel mEstimatesModel, bool makePayment) {
    Get.to(EstimationDetailsPDFScreen(
      mEstimatesModel: mEstimatesModel,
    ));
  }

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
          "AED ${price} /-",
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
              fontWeightDelta: 1),
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

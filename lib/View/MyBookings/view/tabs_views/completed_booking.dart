import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:otobucks/View/MyBookings/Models/view_booking_model.dart';
import 'package:otobucks/View/MyBookings/controller/estimation_screen_controller.dart';
import 'package:otobucks/View/Estimation/Views/estimation_invoice_screen.dart';
import 'package:otobucks/View/Rating/Views/rating_page.dart';
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
class CompletedFragment extends GetView<MyBookingsController> {
   CompletedFragment({
    Key? key,
  }) : super(key: key);
  var  estimationController=  Get.put(EstimationFragmentController());
  @override
  Widget build(BuildContext context) {
    Get.put(MyBookingsController());
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColors.getMainBgColor(),
          body: FutureBuilder<BookingModel>(
              future: controller.getAllBookings(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.result!.length,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    itemBuilder: (BuildContext contextM, index) {
                      var inProcgressList =
                          snapshot.data!.result!.reversed.toList();
                      var data = inProcgressList[index];
                      if (data.status == "completed") {
                        print("data rated-------");
                        print(data.rated);
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
                                  padding: const EdgeInsets.only(
                                      top: 10,
                                      right: AppDimens.dimens_10,
                                      left:10,
                                      bottom: 7
                                  ),
                                  margin: EdgeInsets.symmetric(horizontal: 5),
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
                                                    Constants.TXT_VIEW_BOOKING.tr,
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
                                                      "completed") {
                                                    //reschedule and decline
                                                    Get.to(
                                                        ViewBookingEstimation(
                                                            status: "completed",
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
                                          addHorizontalSpace(4),
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
                                                        fontsize: -1,
                                                        fontweight: 0),
                                                    Textwidget(
                                                        text:
                                                            data.source?.title ??
                                                                "",
                                                        fontsize: -1,
                                                        fontweight: 0),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Textwidget(
                                                        text: "Price :  ",
                                                        fontsize: -1,
                                                        fontweight: 0),
                                                    priceWidget(data.paymentCompleted
                                                        .toString()),
                                                    Text(
                                                      "Fully Paid".tr,
                                                      style: TextStyle(
                                                          color: Colors.green,fontSize: 12),
                                                    )
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
                                             Divider(thickness: 1,),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  //     : MainAxisAlignment.center,
                                                  children: [
                                                    //...................on click of give ratting


                                                    Expanded(
                                                      child: InkWell(
                                                        child: Container(
                                                          margin: EdgeInsets.only(right: 5),
                                                            padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 2.0,
                                                                vertical: 4.0),
                                                            decoration: AppViews
                                                                .getGradientBoxDecoration(
                                                                mBorderRadius:
                                                                2),
                                                            child: Center(
                                                              child: Text(
                                                                "View Estimation".tr
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
                                                          Get.to(EstimationDetailsPDFScreen(allBookingsModel: data,isCompleted: true,));
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap: () {
                                                          data.rated!?null:displayTextInputDialog(context,data.id!);

                                                        },
                                                        child: Container(
                                                            padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 6.0,
                                                                vertical: 4.0),
                                                            decoration: BoxDecoration(
                                                                color: AppColors.colorYellowShade,
                                                              borderRadius: BorderRadius.circular(2)
                                                            ),
                                                            child: Center(
                                                              child: Text(

                                                               data.rated!? "RATED".tr: "Give rating".tr

                                                              // data.rated? "RATED".tr: "Give rating".tr

                                                                    .toUpperCase(),
                                                                style: const TextStyle(
                                                                    color: Colors.black,
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
                              Positioned(
                                  right: 5,
                                  top:5,
                                  child: InkWell(
                                      onTap: (){
                                        //controller.deleteBooking(bookingID: data.id);
                                        controller.update();
                                      },
                                      child: Icon(Icons.delete_outline,color: AppColors.colorCancelledText,)))
                            ],
                          ),
                        );
                      } else {
                        return SizedBox();
                      }

                      ///////////////////////////////// ////////////////////////////////////////////////////////////////
                    },
                  );
                } else if (snapshot.hasError) {
                    Center(child: Text("No data found".tr));
                }
                return const Center(child: CircularProgressIndicator());
              }),
        ));
  }
  displayTextInputDialog(BuildContext context,String bookingId) async {
    Get.to(RatingScreen(bookingId: bookingId, ));
  }
  // gotoViewEstimation(EstimatesModel mEstimatesModel, bool makePayment) {
  //   Get.to(EstimationDetailsPDFScreen(
  //     mEstimatesModel: mEstimatesModel,
  //   ));
  // }

  Widget Textwidget({String? text, double? fontsize, int? fontweight}) {
    return Flexible(
      child: Text(
        text?.tr ?? "",
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
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
}

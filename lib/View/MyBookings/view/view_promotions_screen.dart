import 'dart:collection';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:image_picker/image_picker.dart';

import 'package:otobucks/View/MyBookings/Repo/decline_booking_Repo.dart';
import 'package:otobucks/View/MyBookings/controller/reschedule_booking_controller.dart';
import 'package:otobucks/View/MyBookings/widget/date_selector_view.dart';
import 'package:otobucks/View/MyBookings/widget/time_selector_reshedule.dart';
import 'package:otobucks/View/MyBookings/widget/voice_note_view.dart';
import 'package:otobucks/View/Profile/View/widget/my_car_list_widget.dart';
import 'package:otobucks/global/adaptive_helper.dart';
import 'package:otobucks/widgets/cancel_booking_dialog.dart';
import 'package:otobucks/widgets/fade_in_image.dart';
import 'package:otobucks/widgets/gradient_text.dart';
import 'package:otobucks/widgets/image_preview_widget.dart';
import '../../../../global/app_colors.dart';
import '../../../../global/app_dimens.dart';
import '../../../../global/app_style.dart';
import '../../../../global/app_views.dart';
import '../../../../global/constants.dart';
import '../../../../global/enum.dart';
import '../../../../global/global.dart';
import '../../../global/Models/time_model.dart';
import '../../../global/app_images.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/google_map_view.dart';
import '../../../widgets/media_button.dart';
import '../../Estimation/Controllers/estimation_sidebar_controllers/view_estimation_controller.dart';
import '../Models/PromotionBookingModel.dart';
import '../controller/mybookings_controller.dart';

// ignore: must_be_immutable
class ViewPromotionDetailsScreen extends StatefulWidget {
  final ProotionResult mEstimatesModel;
  final bool isPending;
  final String? status;
  bool isRebooked;
  ViewPromotionDetailsScreen({
    Key? key,
    this.status,
    required this.mEstimatesModel,
    this.isPending = false,
    this.isRebooked = false,
  }) : super(key: key);
  @override
  ViewPromotionDetailsScreenState createState() => ViewPromotionDetailsScreenState();
}

class ViewPromotionDetailsScreenState extends State<ViewPromotionDetailsScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  dynamic imagePickerPath = "";
  List<String> imagePaths = [];
  // final ImagePickerUtility _imagePickerUtility = ImagePickerUtility();
  late TextEditingController controllerNotes; //TextEditingController(text:widget.mEstimatesModel.bookingDetails!.customerNote.toString() );
  ShowData mShowData = ShowData.showLoading;
  bool connectionStatus = false;
  bool isShowLoader = false;
  bool imageLoader = false;
  int _progress = 0;

  var controller = Get.put(ViewEstimationController());
  var reScheduleController = Get.put(RescheduleBookingController());
  String promotiondate = "";
  @override
  void initState() {
    controllerNotes = TextEditingController(text: widget.mEstimatesModel.bookingDetails!.note.toString());
    promotiondate = widget.mEstimatesModel.bookingDetails!.date!;
//-----------videos
//     if (widget.mEstimatesModel.bookingDetails!.video!.isNotEmpty) {
//       reScheduleController.pickedVideo = widget.mEstimatesModel.bookingDetails!.!.first;
//     }

// //-------------images--------
//     if (widget.mEstimatesModel.bookingDetails!.im!.isNotEmpty) {
//       imageLoader = true;
//       getimageUrl(widget.mEstimatesModel.bookingDetails!.image!.first);
//       ImageDownloader.callback(onProgressUpdate: (String? imageId, int progress) {
//         setState(() {
//           _progress = progress;
//         });
//       });
//     }
//     //-------voice notes
//     if (widget.mEstimatesModel.bookingDetails!.voiceNote!.isNotEmpty) {
//       reScheduleController.voiceNoteFile = widget.mEstimatesModel.bookingDetails!.voiceNote!.first;
//     }
//     if (widget.mEstimatesModel.bookingDetails!.customerNote != null) {
//       reScheduleController.controllerNote.text = widget.mEstimatesModel.bookingDetails!.customerNote.toString();
//     }
//     // log(widget.mEstimatesModel.bookingDetails!.voiceNote);

//     reScheduleController.onInitScreen(widget.mEstimatesModel);
    super.initState();
  }

  getimageUrl(String imageUrl) async {
    try {
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage(imageUrl);
      if (imageId == null) {
        return;
      }
      // Below is a method of obtaining saved image information.
      // var fileName = await ImageDownloader.findName(imageId);
      var path = await ImageDownloader.findPath(imageId);
      imagePaths.add(path!);
      imageLoader = false;
      setState(() {});
      // var size = await ImageDownloader.findByteSize(imageId);
      // var mimeType = await ImageDownloader.findMimeType(imageId);
    } on PlatformException catch (error) {
      log(error.toString());
    }
  }

  @override
  void dispose() {
    ImageDownloader.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppViews.initAppBar(
        mContext: context,
        centerTitle: false,
        strTitle: widget.mEstimatesModel.promotion!.title.toString() + " Detail",
        isShowNotification: false,
        isShowSOS: false,
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.getMainBgColor(),
      body: Stack(
        children: [
          Container(
            color: AppColors.colorBlueStart,
            height: 0,
          ),
          GetBuilder<RescheduleBookingController>(
            builder: (value) => AppViews.showLoadingWithStatus(value.isShowLoader),
          ),
          ListView(
            children: [
              /*---------------------------------Profile-----------------------*/
              Stack(
                children: [
                  Container(
                    color: AppColors.colorBlueStart,
                    height: AppDimens.dimens_120,
                  ),
                  _profileSection()
                ],
              ),
              //video and images
              /*---------------------------------Booking data-----------------------*/
/*
 MyCarListItem(
                                            carBrand: mcarlistmodel.brand ?? "",
                                            modeYear:
                                                mcarlistmodel.modelYear ?? "",
                                            km: mcarlistmodel.mileage ?? "",
                                            color: mcarlistmodel.color ?? "",
                                            code: mcarlistmodel.carCode ?? "",
                                            city: mcarlistmodel.carCity ?? "",
                                            number:
                                                mcarlistmodel.carNumber ?? "",
                                            image:
                                                "https://s3.amazonaws.com/cdn.carbucks.com/520e5860-fab9-4d18-904f-919e7cd7667e.png",
                                            onEditTap: () {
                                              value.controllerCarBrand.text =
                                                  mcarlistmodel.brand ?? "";
                                              value.controllerColour.text =
                                                  mcarlistmodel.color ?? "";
                                              value.controllerCarModelYear
                                                      .text =
                                                  mcarlistmodel.modelYear ?? "";
                                              value.controllerMileage.text =
                                                  mcarlistmodel.mileage ?? "";
                                              value.controllerCity.text =
                                                  mcarlistmodel.carCity ?? "";
                                              value.controllerCode.text =
                                                  mcarlistmodel.carCode ?? "";
                                              value.controllerNumber.text =
                                                  mcarlistmodel.carNumber ?? "";
                                              setState(() {
                                                isEditidTab = true;
                                                editId =
                                                    mcarlistmodel.Id ?? "0";
                                              });
                                              // controller.onTapCategory(mCategoryModel);
                                            },
                                            onDeleteTap: () {
                                              controller.deletecar(
                                                  mcarlistmodel.Id ?? "0");
                                              // });
                                            });
 */
              Container(
                  padding: EdgeInsets.symmetric(horizontal: wd(10)),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _uploadImagesSection(),
                      //Upload Video or Shoot a video

                      _videoSection(),
                      // //Voice Note
                      // _voiceNoteSection(),
                      //Leave Note (if any)
                      _anyNoteTextFiledSection(reScheduleController.controllerNote),
                      widget.mEstimatesModel.acceptNote == null || widget.mEstimatesModel.acceptNote!.isEmpty
                          ? const SizedBox()
                          : Container(
                              margin: EdgeInsets.symmetric(horizontal: wd(15), vertical: wd(15)),
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Acknowledge Note".tr,
                                      style: AppStyle.textViewStyleNormalSubtitle2(
                                          context: context, color: AppColors.colorGray, fontSizeDelta: 1, fontWeightDelta: 1),
                                    ),
                                  ),
                                  Text(
                                    widget.mEstimatesModel.acceptNote ?? "",
                                    style: AppStyle.textViewStyleNormalSubtitle2(
                                        context: context, color: Colors.grey, fontSizeDelta: 1, fontWeightDelta: -1),
                                  ),
                                ],
                              ),
                            ),
                      widget.mEstimatesModel.rescheduleNote == null || widget.mEstimatesModel.rescheduleNote!.isEmpty
                          ? SizedBox()
                          : Container(
                              margin: EdgeInsets.symmetric(horizontal: wd(15), vertical: wd(15)),
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Reschedule Note".tr,
                                      style: AppStyle.textViewStyleNormalSubtitle2(
                                          context: context, color: AppColors.colorGray, fontSizeDelta: 1, fontWeightDelta: 1),
                                    ),
                                  ),
                                  Text(
                                    widget.mEstimatesModel.rescheduleNote ?? "",
                                    style: AppStyle.textViewStyleNormalSubtitle2(
                                        context: context, color: Colors.grey, fontSizeDelta: 1, fontWeightDelta: -1),
                                  ),
                                ],
                              ),
                            ),
                      widget.isPending && widget.isRebooked
                          ? Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(
                                  top: AppDimens.dimens_20, bottom: AppDimens.dimens_20, left: AppDimens.dimens_10, right: AppDimens.dimens_10),
                              child: CustomButton(
                                  isGradient: true,
                                  isRoundBorder: true,
                                  fontColor: AppColors.colorWhite,
                                  width: size.width,
                                  onPressed: () {
                                    if (imagePaths.isNotEmpty) {
                                      if (reScheduleController.selectedDate == widget.mEstimatesModel.bookingDetails!.date!.substring(0, 10)) {
                                        Global.showToastAlert(
                                            context: Get.overlayContext!,
                                            strTitle: "",
                                            strMsg: "Please Select Another date",
                                            toastType: TOAST_TYPE.toastInfo);
                                      } else {
                                        reScheduleController.reScheduleBooking(context, widget.mEstimatesModel.promotion!.id.toString(),
                                            imagePath: imagePaths.first);
                                      }
                                    } else {
                                      if (reScheduleController.selectedDate == widget.mEstimatesModel.bookingDetails!.date!.substring(0, 10)) {
                                        Global.showToastAlert(
                                            context: Get.overlayContext!,
                                            strTitle: "".tr,
                                            strMsg: "Please Select Another date".tr,
                                            toastType: TOAST_TYPE.toastInfo);
                                      } else {
                                        reScheduleController.reScheduleBooking(
                                          context,
                                          widget.mEstimatesModel.promotion!.id.toString(),
                                        );
                                      }
                                    }
                                  },
                                  // =>
                                  //     controller.rebook(
                                  //     context, widget.mEstimatesModel),
                                  strTitle: "re-book".tr.toUpperCase()),
                            )
                          : widget.isPending
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.only(
                                            top: AppDimens.dimens_20,
                                            bottom: AppDimens.dimens_20,
                                            left: AppDimens.dimens_10,
                                            right: AppDimens.dimens_10),
                                        child: CustomButton(
                                            isGradient: true,
                                            isRoundBorder: true,
                                            fontColor: AppColors.colorWhite,
                                            // width: size.width,
                                            onPressed: () {
                                              if (imagePaths.isNotEmpty) {
                                                if (reScheduleController.selectedDate ==
                                                    widget.mEstimatesModel.bookingDetails!.date!.substring(0, 10)) {
                                                  Global.showToastAlert(
                                                      context: Get.overlayContext!,
                                                      strTitle: "".tr,
                                                      strMsg: "Please Select Another date".tr,
                                                      toastType: TOAST_TYPE.toastInfo);
                                                } else {
                                                  reScheduleController.reScheduleBooking(context, widget.mEstimatesModel.promotion!.id.toString(),
                                                      imagePath: imagePaths.first);
                                                }
                                              } else {
                                                if (reScheduleController.selectedDate ==
                                                    widget.mEstimatesModel.bookingDetails!.date!.substring(0, 10)) {
                                                  Global.showToastAlert(
                                                      context: Get.overlayContext!,
                                                      strTitle: "",
                                                      strMsg: "Please Select Another date".tr,
                                                      toastType: TOAST_TYPE.toastInfo);
                                                } else {
                                                  reScheduleController.reScheduleBooking(
                                                    context,
                                                    widget.mEstimatesModel.promotion!.id.toString(),
                                                  );
                                                }
                                              }

                                              // Global.showAlert(context, "Something went wrong");
                                            },
                                            strTitle: "Reschedule".tr),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.only(
                                            top: AppDimens.dimens_20,
                                            bottom: AppDimens.dimens_20,
                                            left: AppDimens.dimens_10,
                                            right: AppDimens.dimens_10),
                                        child: CustomButton(
                                            isGradient: true,
                                            isRoundBorder: true,
                                            fontColor: AppColors.colorWhite,
                                            //width: size.width,
                                            onPressed: () {
                                              displayTextInputDialog();
                                            },
                                            // =>
                                            //     controller.rebook(
                                            //     context, widget.mEstimatesModel),
                                            strTitle: "Cancel".tr),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(
                                  // alignment: Alignment.center,
                                  // margin: const EdgeInsets.only(
                                  //     top: AppDimens.dimens_20, bottom: AppDimens.dimens_20, left: AppDimens.dimens_10, right: AppDimens.dimens_10),
                                  // child: CustomButton(
                                  //   isGradient: true,
                                  //   isRoundBorder: true,
                                  //   fontColor: AppColors.colorWhite,
                                  //   width: size.width,
                                  //   onPressed: () {
                                  //     Get.put(MyBookingsController()).reseduleBooking(context, widget.mEstimatesModel.promotion!.id!, promotiondate);
                                  //   },
                                  //   // =>
                                  //   //     controller.rebook(
                                  //   //     context, widget.mEstimatesModel),
                                  //   strTitle: "Reschedule",
                                  // ),
                                  ),
                    ],
                  ))

              // Expanded(child: Container()),
            ],
          ),
          GetBuilder<MyBookingsController>(
            builder: (value) => AppViews.showLoadingWithStatus(value.isShowLoader),
          )
        ],
      ),
    );
  }

  displayTextInputDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return CancelBookingDialogBox(
            isDecline: false,
            onTap: (String strReason) {
              if (Global.checkNull(strReason)) {
                declineEstimation(id: widget.mEstimatesModel.promotion!.id.toString(), reason: strReason);
              } else {
                Global.showToastAlert(context: context, strTitle: "", strMsg: AppAlert.ALERT_ENTER_FN, toastType: TOAST_TYPE.toastError);
              }
            },
          );
        });
  }

//-----------------------Decline Booking-------------------
  declineEstimation({required String reason, required String id}) async {
    setState(() {
      mShowData = ShowData.showLoading;
      // isShowLoader = true;
    });

    HashMap<String, Object> requestParams = HashMap();

    requestParams['bookingID'] = id;
    requestParams['cancelReason'] = reason;

    var categories = await BookingDeclineRepo().declineBooking(
      requestParams,
    );

    categories.fold((failure) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);
      setState(() {
        mShowData = ShowData.showNoDataFound;
      });
    }, (mResult) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: mResult.responseMessage, toastType: TOAST_TYPE.toastSuccess);
      setState(() {
        mShowData = ShowData.showNoDataFound;
      });
      Get.back();
      //Get.find<EstimationListController>().getEstimation('submitted');
    });
  }

  _profileSection() => Container(
        margin: const EdgeInsets.only(left: AppDimens.dimens_30, top: AppDimens.dimens_20, bottom: AppDimens.dimens_30, right: AppDimens.dimens_20),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(
                right: AppDimens.dimens_20,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppDimens.dimens_5),
                child: NetworkImageCustom(
                    image: widget.mEstimatesModel.promotion!.promoImg!.isNotEmpty
                        ? widget.mEstimatesModel.promotion!.promoImg!.first
                        : "https://i.tribune.com.pk/media/images/7UOKRCYY7NJTFHXVVO5XFZLCK41641535289-0/7UOKRCYY7NJTFHXVVO5XFZLCK41641535289-0.jpg",
                    fit: BoxFit.fill,
                    height: AppDimens.dimens_120,
                    width: AppDimens.dimens_120),
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.mEstimatesModel.provider!.firstName.toString(),
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  maxLines: 2,
                  style: AppStyle.textViewStyleLarge(context: context, color: AppColors.colorWhite, fontSizeDelta: 3, fontWeightDelta: -2),
                ),
                InkWell(
                  child: Container(
                      margin: const EdgeInsets.only(top: AppDimens.dimens_5),
                      child: Text(
                        "View Profile",
                        style: AppStyle.textViewStyleSmall(
                            context: context,
                            color: AppColors.colorWhite,
                            mDecoration: TextDecoration.underline,
                            fontSizeDelta: -2,
                            fontWeightDelta: 0),
                      )),
                  onTap: () {
                    // controller.gotoProfile(context);
                  },
                ),
              ],
            ))
          ],
        ),
      );

  _uploadImagesSection() {
    return GetBuilder<RescheduleBookingController>(
        init: RescheduleBookingController(),
        builder: (value) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //-----------------------Service-------------------
              Container(
                margin: EdgeInsets.symmetric(horizontal: wd(15)),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Service".tr,
                        style:
                            AppStyle.textViewStyleNormalSubtitle2(context: context, color: AppColors.colorGray, fontSizeDelta: 1, fontWeightDelta: 1),
                      ),
                    ),
                    Text(
                      widget.mEstimatesModel.promotion!.title.toString(),
                      style: AppStyle.textViewStyleNormalSubtitle2(context: context, color: Colors.grey, fontSizeDelta: 1, fontWeightDelta: -1),
                    ),
                  ],
                ),
              ),
              //-----------------------Provider-------------------
              Container(
                margin: const EdgeInsets.only(top: AppDimens.dimens_10, left: AppDimens.dimens_14, right: AppDimens.dimens_14),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Provider".tr,
                        style:
                            AppStyle.textViewStyleNormalSubtitle2(context: context, color: AppColors.colorGray, fontSizeDelta: 1, fontWeightDelta: 1),
                      ),
                    ),
                    Text(
                      widget.mEstimatesModel.provider!.firstName.toString(),
                      style: AppStyle.textViewStyleNormalSubtitle2(context: context, color: Colors.grey, fontSizeDelta: 1, fontWeightDelta: -1),
                    ),
                  ],
                ),
              ),
              //-----------------------Service Price Per Hour-------------------
              Container(
                margin: const EdgeInsets.only(top: AppDimens.dimens_10, left: AppDimens.dimens_14, right: AppDimens.dimens_14),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Service Price per hour".tr,
                        style:
                            AppStyle.textViewStyleNormalSubtitle2(context: context, color: AppColors.colorGray, fontSizeDelta: 1, fontWeightDelta: 1),
                      ),
                    ),
                    GradientText(
                      Global.replaceCurrencySign("AED") + widget.mEstimatesModel.promotion!.priceAfterDiscount!.toString(),
                      style: AppStyle.textViewStyleNormalSubtitle2(
                          context: context, color: AppColors.colorTextBlue, fontSizeDelta: 0, fontWeightDelta: 3),
                    ),
                  ],
                ),
              ),
              //-----------------------Map get Location---------------------------
              Container(
                  margin: const EdgeInsets.only(top: AppDimens.dimens_20, left: AppDimens.dimens_14, right: AppDimens.dimens_14),
                  alignment: Alignment.center,
                  height: AppDimens.dimens_160,
                  child: GoogleMapView(onTap: (LatLng mLatLng_) => value.updateLatLang(mLatLng_))),
              _addressTextFiledSection(),

              //-----------------------Date Time--------------------------
              Container(
                margin: const EdgeInsets.only(
                  top: AppDimens.dimens_15,
                  left: AppDimens.dimens_14,
                  right: AppDimens.dimens_14,
                ),
                child: Text(
                  "Date & Time".tr,
                  style: AppStyle.textViewStyleNormalSubtitle2(context: context, color: AppColors.colorBlack2, fontWeightDelta: 1, fontSizeDelta: 0),
                ),
              ),
// Text(widget.mEstimatesModel.bookingDetails!.date.toString()),
              Container(
                margin: const EdgeInsets.only(
                  top: AppDimens.dimens_8,
                  left: AppDimens.dimens_14,
                  right: AppDimens.dimens_14,
                ),
                child: DateViewSelector(
                    isPending: widget.isPending,
                    // selectedDate: value.selectedDate,
                    selectedDate: DateTime.parse(widget.mEstimatesModel.bookingDetails!.date!),
                    //selectedDate:DateTime.parse(value.selectedDate),
                    onSelection: (String _selectedDate) {
                      promotiondate = _selectedDate;
                      value.onSelectDate(_selectedDate);
                    }

                    // selectedDate: DateTime.parse(widget.mEstimatesModel.bookingDetails!.date!),
                    //  onSelection: (String _selectedDate) {
                    //    // log(_selectedDate);
                    //
                    //    value.onSelectDate(_selectedDate);
                    //  },

                    ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: AppDimens.dimens_15,
                  left: AppDimens.dimens_14,
                  right: AppDimens.dimens_14,
                ),
                child: Text(
                  "Time".tr,
                  style: AppStyle.textViewStyleNormalSubtitle2(context: context, color: AppColors.colorBlack2, fontWeightDelta: 1, fontSizeDelta: 0),
                ),
              ),
              Container(
                height: AppDimens.dimens_50,
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(
                  top: AppDimens.dimens_10,
                  left: AppDimens.dimens_14,
                  right: AppDimens.dimens_14,
                ),
                child: TimeRescheduleSelector(
                    isPending: widget.isPending,
                    selectedDate: value.selectedDate,
                    time: widget.mEstimatesModel.bookingDetails!.time ?? "",
                    // mTimeModel: value.mTimeModel,
                    onSelection: (TimeModel mtimeModel_) => value.onSelectTime(mtimeModel_)),
              ),

              ///-------------------------------------carList
              Container(
                margin: const EdgeInsets.only(
                  top: AppDimens.dimens_15,
                  left: AppDimens.dimens_14,
                  right: AppDimens.dimens_14,
                ),
                child: Text(
                  "Car".tr,
                  style: AppStyle.textViewStyleNormalSubtitle2(context: context, color: AppColors.colorBlack2, fontWeightDelta: 1, fontSizeDelta: 0),
                ),
              ),

              // MyCarListItem(
              //     isViewed: true,
              //     carBrand: widget.mEstimatesModel. ?? "",
              //     modeYear: widget.mEstimatesModel.bookingDetails!.car!.modelYear ?? "",
              //     km: widget.mEstimatesModel.bookingDetails!.car!.mileage ?? "",
              //     color: widget.mEstimatesModel.bookingDetails!.car!.color ?? "",
              //     code: widget.mEstimatesModel.bookingDetails!.car!.carCode ?? "",
              //     city: widget.mEstimatesModel.bookingDetails!.car!.carCity ?? "",
              //     number: widget.mEstimatesModel.bookingDetails!.car!.carNumber ?? "",
              //     registrationDate: "",
              //     image: "https://s3.amazonaws.com/cdn.carbucks.com/520e5860-fab9-4d18-904f-919e7cd7667e.png",
              //     onEditTap: () {},
              //     onDeleteTap: () {}),

              //---------------------------------------------------Upload image or Take a photo
              Container(
                margin: const EdgeInsets.only(
                  top: AppDimens.dimens_15,
                  left: AppDimens.dimens_14,
                  right: AppDimens.dimens_14,
                ),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        Constants.STR_IMAGE_MSG.tr,
                        style: AppStyle.textViewStyleNormalSubtitle2(
                            context: context, color: AppColors.colorBlack2, fontWeightDelta: 1, fontSizeDelta: 0),
                      ),
                    ),
                    const SizedBox(width: AppDimens.dimens_5),
                    Flexible(
                      child: Text(
                        Constants.STR_MAX_SIZE,
                        style: AppStyle.textViewStyleNormalSubtitle2(
                            context: context, color: AppColors.colorBlack2, fontWeightDelta: -1, fontSizeDelta: -4),
                      ),
                    ),
                  ],
                ),
              ),

              //upload and view image selection--
              imageLoader
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(height: 30.0, child: Text('Progress: $_progress %'.tr)),
                    )
                  : imageSlider(),
            ],
          );
        });
  }

  _videoSection() {
    return GetBuilder<RescheduleBookingController>(builder: (value) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: AppDimens.dimens_20,
              left: AppDimens.dimens_14,
              right: AppDimens.dimens_14,
            ),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    Constants.STR_VIDEO_MSG.tr,
                    style:
                        AppStyle.textViewStyleNormalSubtitle2(context: context, color: AppColors.colorBlack2, fontWeightDelta: 1, fontSizeDelta: 0),
                  ),
                ),
                const SizedBox(width: AppDimens.dimens_5),
                Text(
                  Constants.STR_MAX_SIZE.tr,
                  style:
                      AppStyle.textViewStyleNormalSubtitle2(context: context, color: AppColors.colorBlack2, fontWeightDelta: -1, fontSizeDelta: -4),
                ),
              ],
            ),
          ),
          //-----------------video uploading -progress bar -----------
          Visibility(
            visible: value.isVideoCompressed,
            child: StreamBuilder<double>(
              stream: value.lightCompressor.onProgressUpdated,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.data != null && snapshot.data > 0) {
                  return Container(
                    margin: const EdgeInsets.only(
                      top: AppDimens.dimens_10,
                      left: AppDimens.dimens_14,
                      right: AppDimens.dimens_14,
                    ),
                    child: Column(
                      children: <Widget>[
                        LinearProgressIndicator(
                          minHeight: AppDimens.dimens_5,
                          color: AppColors.colorBlueEnd,
                          value: snapshot.data / 100,
                        ),
                        Container(
                          child: Text(
                            Constants.TXT_PLEASE_WAIT.tr + ' ${snapshot.data.toStringAsFixed(0)}%',
                            style: AppStyle.textViewStyleSmall(context: context, color: AppColors.colorBlack),
                          ),
                          margin: const EdgeInsets.only(top: AppDimens.dimens_8),
                        )
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          // Text(value.pickedVideo.toString()),
          Container(
            margin: const EdgeInsets.only(
              top: AppDimens.dimens_10,
              left: AppDimens.dimens_14,
              right: AppDimens.dimens_14,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Visibility(
                visible: !value.isVideoCompressed,
                child: Row(
                  children: [
                    //----------------------video seleciton box------------
                    Visibility(
                        visible: Global.checkNull(value.pickedVideo),
                        child: Container(
                          margin: const EdgeInsets.only(right: AppDimens.dimens_15),
                          height: AppDimens.dimens_100,
                          width: AppDimens.dimens_100,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(AppDimens.dimens_5),
                                ),
                                height: AppDimens.dimens_100,
                                width: AppDimens.dimens_100,
                                child: InkWell(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(AppDimens.dimens_5),
                                      child: Container(
                                        color: AppColors.colorGray2,
                                        child: Icon(
                                          Icons.play_arrow,
                                          color: AppColors.curiousBlue,
                                        ),
                                        padding: const EdgeInsets.all(AppDimens.dimens_35),
                                        // width: width != null ? width : AppDimens.dimens_100,
                                        // height: height != null ? height : AppDimens.dimens_100,
                                      )),
                                  onTap: () {
                                    Global.gotoVideoView(context, value.pickedVideo);
                                  },
                                ),
                              ),
                              widget.isPending
                                  ? Positioned(
                                      right: 0,
                                      top: 0,
                                      child: InkWell(
                                          child: const Icon(Icons.close),
                                          onTap: () {
                                            value.onDeleteVideo();
                                          } //=>
                                          ))
                                  : const SizedBox(),
                            ],
                          ),
                        )),
                    //----------------------Camera video selection----------
                    Visibility(
                      visible: !Global.checkNull(value.pickedVideo),
                      child: Row(
                        children: [
                          MediaButton(
                            strImage: AppImages.ic_cloud,
                            onPressed: widget.isPending
                                ? () {
                                    value.pickVideo(ImageSource.gallery);
                                  }
                                : () {},
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: AppDimens.dimens_15),
                            child: MediaButton(
                              strImage: AppImages.ic_video_cam,
                              onPressed: widget.isPending
                                  ? () {
                                      value.pickVideo(ImageSource.camera);
                                    }
                                  : () {},
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  _voiceNoteSection() => GetBuilder<RescheduleBookingController>(builder: (value) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: AppDimens.dimens_20,
                left: AppDimens.dimens_14,
                right: AppDimens.dimens_14,
              ),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      Constants.STR_LEAVE_VOICE_NOTE.tr,
                      style:
                          AppStyle.textViewStyleNormalSubtitle2(context: context, color: AppColors.colorBlack2, fontWeightDelta: 1, fontSizeDelta: 0),
                    ),
                  ),
                  const SizedBox(width: AppDimens.dimens_5),
                  Text(
                    Constants.STR_MAX_SIZE.tr,
                    style:
                        AppStyle.textViewStyleNormalSubtitle2(context: context, color: AppColors.colorBlack2, fontWeightDelta: -1, fontSizeDelta: -4),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: AppDimens.dimens_10,
                left: AppDimens.dimens_14,
                right: AppDimens.dimens_14,
              ),
              child: VoiceRecordingViewButton(
                  isPending: widget.isPending,
                  // strVoiceNotePath: 'https://flutter-sound.canardoux.xyz/web_example/assets/extract/01.aac',
                  strVoiceNotePath: value.voiceNoteFile,
                  callback: (String filePath) {
                    value.onSelectVoiceNote(filePath);
                  }),
            ),
          ],
        );
      });

  _addressTextFiledSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: AppDimens.dimens_20,
            left: AppDimens.dimens_14,
            right: AppDimens.dimens_14,
          ),
          child: Text(
            Constants.STR_ADDRESS.tr,
            style: AppStyle.textViewStyleNormalSubtitle2(context: context, color: AppColors.colorBlack2, fontWeightDelta: 1, fontSizeDelta: 0),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            top: AppDimens.dimens_10,
            left: AppDimens.dimens_14,
            right: AppDimens.dimens_14,
          ),
          child: SizedBox(
            child: TextField(
              onChanged: (String strvalue) {},
              onSubmitted: (String? value) {
                //onSubmit!(value!);
              },
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              style: AppStyle.textViewStyleNormalBodyText2(color: AppColors.colorBlack, fontSizeDelta: 0, fontWeightDelta: 0, context: context),
              controller: reScheduleController.addressNote,
              readOnly: true,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                prefixIconConstraints: const BoxConstraints(minWidth: AppDimens.dimens_33),
                suffixIconConstraints: const BoxConstraints(minWidth: AppDimens.dimens_33),
                suffixIcon: Container(
                  margin: const EdgeInsets.only(right: AppDimens.dimens_12),
                  alignment: Alignment.center,
                  width: 5,
                ),
                contentPadding: const EdgeInsets.only(top: AppDimens.dimens_7, left: AppDimens.dimens_15),
                focusedBorder: AppViews.textFieldRoundBorder(),
                border: AppViews.textFieldRoundBorder(),
                disabledBorder: AppViews.textFieldRoundBorder(),
                focusedErrorBorder: AppViews.textFieldRoundBorder(),
                hintText: "Address".tr,
                filled: true,
                fillColor: AppColors.colorGray2,
                hintStyle: AppStyle.textViewStyleNormalBodyText2(
                    color: AppColors.colorTextFieldHint, fontSizeDelta: 0, fontWeightDelta: 0, context: context),
              ),
            ),
            height: AppDimens.dimens_50,
          ),
          decoration: AppViews.getGrayDecoration(mBorderRadius: AppDimens.dimens_5),
        )
      ],
    );
  }

  _anyNoteTextFiledSection(TextEditingController leaveNotesController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: AppDimens.dimens_20,
            left: AppDimens.dimens_14,
            right: AppDimens.dimens_14,
          ),
          child: Text(
            Constants.STR_LEAVE_NOTE.tr,
            style: AppStyle.textViewStyleNormalSubtitle2(context: context, color: AppColors.colorBlack2, fontWeightDelta: 1, fontSizeDelta: 0),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            top: AppDimens.dimens_10,
            left: AppDimens.dimens_14,
            right: AppDimens.dimens_14,
          ),
          child: TextField(
            onChanged: (String? strvalue) {
              // log("-------------------");
              // log(strvalue);
              // reScheduleController.controllerNote.text=strvalue;
            },
            onSubmitted: (String? value) {
              reScheduleController.controllerNote.text = value ?? "";
              //onSubmit!(value!);
            },
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            maxLines: 3,
            style: AppStyle.textViewStyleNormalBodyText2(color: AppColors.colorBlack, fontSizeDelta: 0, fontWeightDelta: 0, context: context),
            controller: leaveNotesController, //reScheduleController.controllerNote,
            textAlign: TextAlign.start,
            readOnly: widget.isPending ? false : true,
            decoration: InputDecoration(
              prefixIconConstraints: const BoxConstraints(minWidth: AppDimens.dimens_33),
              suffixIconConstraints: const BoxConstraints(minWidth: AppDimens.dimens_33),
              suffixIcon: Container(
                margin: const EdgeInsets.only(right: AppDimens.dimens_12),
                alignment: Alignment.center,
                width: AppDimens.dimens_50,
              ),
              contentPadding: const EdgeInsets.only(top: AppDimens.dimens_7, left: AppDimens.dimens_15),
              focusedBorder: AppViews.textFieldRoundBorder(),
              border: AppViews.textFieldRoundBorder(),
              disabledBorder: AppViews.textFieldRoundBorder(),
              focusedErrorBorder: AppViews.textFieldRoundBorder(),
              hintText: "Write a message...".tr,
              // filled: true,
              fillColor: AppColors.colorGray2,
              hintStyle:
                  AppStyle.textViewStyleNormalBodyText2(color: AppColors.colorTextFieldHint, fontSizeDelta: 0, fontWeightDelta: 0, context: context),
            ),
          ),
          decoration: AppViews.getGrayDecoration(mBorderRadius: AppDimens.dimens_5),
        )
      ],
    );
  }

/*-------------------------------------Upload Image A Take Photo Ibraim------------------------------ */
  Widget imageSlider() {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Row(
            children: [
              ImagePreviews(imagePaths, onDelete: _onDeleteImage, onSelect: _onSelectImage),
              //image
              imagePaths.isNotEmpty
                  ? const SizedBox()
                  : InkWell(
                      onTap: widget.isPending
                          ? () async {
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      contentPadding: EdgeInsets.zero,
                                      backgroundColor: AppColors.colorWhite,
                                      title: Text(
                                        'Select Image'.tr,
                                        textAlign: TextAlign.center,
                                        style: AppStyle.textViewStyleLarge(
                                            context: context, color: AppColors.colorBlack, fontWeightDelta: 1, fontSizeDelta: 3),
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          const Divider(),
                                          ListTile(
                                              onTap: () async {
                                                Navigator.pop(context);
                                                final pickedFile = await _imagePicker.pickImage(
                                                  source: ImageSource.camera,
                                                );

                                                if (pickedFile != null) {
                                                  setState(() {
                                                    imagePaths.add(pickedFile.path);
                                                    imagePickerPath = imagePaths.first;
                                                  });
                                                }
                                              },
                                              title: Text(
                                                'Take a Photo'.tr,
                                                style: AppStyle.textViewStyleNormalSubtitle2(
                                                    context: context, color: AppColors.colorBlack, fontWeightDelta: 1, fontSizeDelta: 2),
                                              )),
                                          ListTile(
                                            onTap: () async {
                                              Navigator.pop(context);

                                              final pickedFile = await _imagePicker.pickImage(
                                                source: ImageSource.gallery,
                                              );

                                              if (pickedFile != null) {
                                                setState(() {
                                                  imagePaths.add(pickedFile.path);
                                                  imagePickerPath = imagePaths.first;
                                                });
                                              }
                                            },
                                            title: Text(
                                              'Upload Image'.tr,
                                              style: AppStyle.textViewStyleNormalSubtitle2(
                                                  context: context, color: AppColors.colorBlack, fontWeightDelta: 1, fontSizeDelta: 2),
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        ElevatedButton(
                                            child: Text('Cancel'.tr),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            })
                                      ],
                                    );
                                  });
                            }
                          : () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: AppColors.colorGray2,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.add, color: AppColors.colorGray),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  void _onDeleteImage(int position) {
    setState(() {
      if (position >= 0) {
        if (position == 0) {
          imagePickerPath = "";
        } else {
          imagePickerPath = imagePaths[position - 1];
        }
      }
      imagePaths.removeAt(position);
    });
  }

  void _onSelectImage(int index) {
    setState(() {
      imagePickerPath = imagePaths[index];
      // imagePaths.removeAt(position);
    });
  }
}

import 'dart:collection';
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
import 'package:otobucks/controllers/estimation_sidebar_controllers/view_estimation_controller.dart';
import 'package:otobucks/global/adaptive_helper.dart';
import 'package:otobucks/widgets/Image_Select/image_utility.dart';
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
import '../../../global/app_images.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/google_map_view.dart';
import '../../../widgets/media_button.dart';
import '../../../widgets/voice_note_buttons.dart';
import 'package:otobucks/View/MyBookings/Models/AllBookingsModel.dart';



class ViewBookingEstimation extends StatefulWidget {
  final Result mEstimatesModel;
  final bool isPending;
  const ViewBookingEstimation({
    Key? key,
    required this.mEstimatesModel,
    this.isPending = false,
  }) : super(key: key);
  @override
  ViewBookingEstimationState createState() => ViewBookingEstimationState();
}

class ViewBookingEstimationState extends State<ViewBookingEstimation> {
  final ImagePicker _imagePicker = ImagePicker();
  dynamic imagePickerPath = "";
  List<String> imagePaths = [];
  final ImagePickerUtility _imagePickerUtility = ImagePickerUtility();
  ShowData mShowData = ShowData.showLoading;
  bool connectionStatus = false;
  bool isShowLoader = false;
  bool imageLoader = false;
  int _progress = 0;
  var controller = Get.put(ViewEstimationController());
  var reScheduleController = Get.put(RescheduleBookingController());
  @override
  void initState() {
    print("-----------------booking data ------------init data-");
    print(widget.mEstimatesModel.bookingDetails!.time);
    print(widget.mEstimatesModel.bookingDetails!.date);
    print(widget.mEstimatesModel.bookingDetails!.image);
    print(widget.mEstimatesModel.bookingDetails!.video);
    print(widget.mEstimatesModel.bookingDetails!.customerNote);
    print(widget.mEstimatesModel.bookingDetails!.voiceNote);
    print("-----------voice notes------------");
//-----------videos
    if (widget.mEstimatesModel.bookingDetails!.video!.isNotEmpty) {
      reScheduleController.pickedVideo =
          widget.mEstimatesModel.bookingDetails!.video!.first;
    }
//-------------images--------
    if (widget.mEstimatesModel.bookingDetails!.image!.isNotEmpty) {
      imageLoader = true;
      getimageUrl(widget.mEstimatesModel.bookingDetails!.image!.first);
      ImageDownloader.callback(
          onProgressUpdate: (String? imageId, int progress) {
        setState(() {
          _progress = progress;
        });
      });
    }
    //-------voice notes
    if (widget.mEstimatesModel.bookingDetails!.voiceNote!.isNotEmpty) {
      print("-----------voice notes--------1----");
      reScheduleController.voiceNoteFile =
          widget.mEstimatesModel.bookingDetails!.voiceNote!.first;
    }
    if (widget.mEstimatesModel.bookingDetails!.customerNote != null) {
      reScheduleController.controllerNote.text =
          widget.mEstimatesModel.bookingDetails!.customerNote.toString();
    }
   // print(widget.mEstimatesModel.bookingDetails!.voiceNote);

    reScheduleController.onInitScreen(widget.mEstimatesModel);
    super.initState();
  }

  getimageUrl(String ImageUrl) async {
    try {
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage(ImageUrl);
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
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppViews.initAppBar(
        mContext: context,
        centerTitle: false,
        strTitle: widget.mEstimatesModel.source!.title.toString() + " Detail",
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
            builder: (value) =>
                AppViews.showLoadingWithStatus(value.isShowLoader),
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
                      _voiceNoteSection(),
                      //Leave Note (if any)
                      _anyNoteTextFiledSection(),
                      widget.isPending
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
                                          print(
                                              "image path--------dfgsdfsdfg-dg-dsf-g-sdg--");
                                          //  Loader.show(context,progressIndicator:LinearProgressIndicator());
                                          if (imagePaths.isNotEmpty) {

                                            reScheduleController
                                                .reScheduleBooking(
                                                    context,
                                                    widget.mEstimatesModel.id
                                                        .toString(),
                                                    imagePath:
                                                        imagePaths.first);
                                          } else {
                                            reScheduleController
                                                .reScheduleBooking(
                                              context,
                                              widget.mEstimatesModel.id
                                                  .toString(),
                                            );
                                          }

                                          // Global.showAlert(context, "Something went wrong");
                                        },
                                        strTitle: "Rescheduled"),
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
                                        strTitle: "Canceled"),
                                  ),
                                ),
                              ],
                            )
                          : Container(
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
                                  width: size.width,
                                  onPressed: () {},
                                  // =>
                                  //     controller.rebook(
                                  //     context, widget.mEstimatesModel),
                                  strTitle: "Booked"),
                            ),

                      // if (widget.screen == 'partial')
                      //   Container(
                      //     alignment: Alignment.center,
                      //     margin: const EdgeInsets.only(
                      //         top: AppDimens.dimens_20,
                      //         bottom: AppDimens.dimens_20,
                      //         left: AppDimens.dimens_10,
                      //         right: AppDimens.dimens_10),
                      //     child: CustomButton(
                      //         isGradient: true,
                      //         isRoundBorder: true,
                      //         fontColor: AppColors.colorWhite,
                      //         width: size.width,
                      //         onPressed: () {
                      //           Navigator.push(
                      //               context,
                      //               MaterialPageRoute(
                      //                   builder: (context) => CheckoutScreen(
                      //                     // estimateId:
                      //                     //     widget.mEstimatesModel.id,
                      //                     // sourceId: widget
                      //                     //     .mEstimatesModel.source!.id,
                      //                     // paymentStatus: 'completePayment',
                      //                   )));
                      //         },
                      //         strTitle: "Make The Balance Payment"
                      //
                      //       //Constants.TXT_COMPLETED_ESTIMATION
                      //     ),
                      //   )
                      // else if (widget.screen == 'pending')
                      //   Container(
                      //     alignment: Alignment.center,
                      //     margin: const EdgeInsets.only(
                      //         top: AppDimens.dimens_20,
                      //         bottom: AppDimens.dimens_20,
                      //         left: AppDimens.dimens_10,
                      //         right: AppDimens.dimens_10),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         SizedBox(
                      //           child: CustomButton(
                      //               isGradient: true,
                      //               fontSize: -2,
                      //               isRoundBorder: true,
                      //               fontColor: AppColors.colorWhite,
                      //               width: size.width,
                      //               onPressed: () =>
                      //                   controller.checkDateTime(context),
                      //               strTitle: Constants.TXT_RESCHEDULE),
                      //           width: size.width / 2.5,
                      //         ),
                      //         SizedBox(
                      //           child: CustomButton(
                      //               fontSize: -2,
                      //               isGradient: false,
                      //               isRoundBorder: true,
                      //               color: AppColors.greyDateBG,
                      //               fontColor: AppColors.colorBlack,
                      //               width: size.width,
                      //               onPressed: () => displayTextInputDialog(),
                      //               strTitle: Constants.TXT_CANCEL),
                      //           width: size.width / 2.5,
                      //         ),
                      //       ],
                      //     ),
                      //   )
                    ],
                  ))

              // Expanded(child: Container()),
            ],
          ),
        ],
      ),
    );
  }

  displayTextInputDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return CancelBookingDialogBox(
            isDecline: true,
            onTap: (String strReason) {
              if (Global.checkNull(strReason)) {
                declineEstimation(
                    id: widget.mEstimatesModel.id.toString(),
                    reason: strReason);
              } else {
                Global.showToastAlert(
                    context: context,
                    strTitle: "",
                    strMsg: AppAlert.ALERT_ENTER_FN,
                    toastType: TOAST_TYPE.toastError);
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
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);
      setState(() {
        mShowData = ShowData.showNoDataFound;
      });
    }, (mResult) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: mResult.responseMessage,
          toastType: TOAST_TYPE.toastSuccess);
      setState(() {
        mShowData = ShowData.showNoDataFound;
      });
      Get.back();
      //Get.find<EstimationListController>().getEstimation('submitted');
    });
  }

  _profileSection() => Container(
        margin: const EdgeInsets.only(
            left: AppDimens.dimens_30,
            top: AppDimens.dimens_20,
            bottom: AppDimens.dimens_30,
            right: AppDimens.dimens_20),
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
                    image: widget.mEstimatesModel.source!.image!.first,
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
                  style: AppStyle.textViewStyleLarge(
                      context: context,
                      color: AppColors.colorWhite,
                      fontSizeDelta: 3,
                      fontWeightDelta: -2),
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
                        "Service",
                        style: AppStyle.textViewStyleNormalSubtitle2(
                            context: context,
                            color: AppColors.colorGray,
                            fontSizeDelta: 1,
                            fontWeightDelta: 1),
                      ),
                    ),
                    Text(
                      widget.mEstimatesModel.source!.title.toString(),
                      style: AppStyle.textViewStyleNormalSubtitle2(
                          context: context,
                          color: Colors.grey,
                          fontSizeDelta: 1,
                          fontWeightDelta: -1),
                    ),
                  ],
                ),
              ),
              //-----------------------Provider-------------------
              Container(
                margin: const EdgeInsets.only(
                    top: AppDimens.dimens_10,
                    left: AppDimens.dimens_14,
                    right: AppDimens.dimens_14),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Provider",
                        style: AppStyle.textViewStyleNormalSubtitle2(
                            context: context,
                            color: AppColors.colorGray,
                            fontSizeDelta: 1,
                            fontWeightDelta: 1),
                      ),
                    ),
                    Text(
                      widget.mEstimatesModel.provider!.firstName.toString(),
                      style: AppStyle.textViewStyleNormalSubtitle2(
                          context: context,
                          color: Colors.grey,
                          fontSizeDelta: 1,
                          fontWeightDelta: -1),
                    ),
                  ],
                ),
              ),
              //-----------------------Service Price Per Hour-------------------
              Container(
                margin: const EdgeInsets.only(
                    top: AppDimens.dimens_10,
                    left: AppDimens.dimens_14,
                    right: AppDimens.dimens_14),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Service Price per hour",
                        style: AppStyle.textViewStyleNormalSubtitle2(
                            context: context,
                            color: AppColors.colorGray,
                            fontSizeDelta: 1,
                            fontWeightDelta: 1),
                      ),
                    ),
                    GradientText(
                      Global.replaceCurrencySign(
                              widget.mEstimatesModel.source!.currency!) +
                          widget.mEstimatesModel.source!.price!.toString(),
                      style: AppStyle.textViewStyleNormalSubtitle2(
                          context: context,
                          color: AppColors.colorTextBlue,
                          fontSizeDelta: 0,
                          fontWeightDelta: 3),
                    ),
                  ],
                ),
              ),
              //-----------------------Map get Location---------------------------
              Container(
                  margin: const EdgeInsets.only(
                      top: AppDimens.dimens_20,
                      left: AppDimens.dimens_14,
                      right: AppDimens.dimens_14),
                  alignment: Alignment.center,
                  height: AppDimens.dimens_160,
                  child: GoogleMapView(
                      onTap: (LatLng mLatLng_) =>
                          value.updateLatLang(mLatLng_))),
              _addressTextFiledSection(),

              //-----------------------Date Time--------------------------
              Container(
                margin: const EdgeInsets.only(
                  top: AppDimens.dimens_15,
                  left: AppDimens.dimens_14,
                  right: AppDimens.dimens_14,
                ),
                child: Text(
                  "Date & Time",
                  style: AppStyle.textViewStyleNormalSubtitle2(
                      context: context,
                      color: AppColors.colorBlack2,
                      fontWeightDelta: 1,
                      fontSizeDelta: 0),
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
                    // selectedDate: value.selectedDate,
                    selectedDate: DateTime.parse(
                        widget.mEstimatesModel.bookingDetails!.date!),
                    //selectedDate:DateTime.parse(value.selectedDate),
                    onSelection: (String _selectedDate) {
                      value.onSelectDate(_selectedDate);
                    }

                    // selectedDate: DateTime.parse(widget.mEstimatesModel.bookingDetails!.date!),
                    //  onSelection: (String _selectedDate) {
                    //    // print(_selectedDate);
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
                  "Time",
                  style: AppStyle.textViewStyleNormalSubtitle2(
                      context: context,
                      color: AppColors.colorBlack2,
                      fontWeightDelta: 1,
                      fontSizeDelta: 0),
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
                  selectedDate: value.selectedDate ?? "",
                  time: widget.mEstimatesModel.bookingDetails!.time ?? "",
                  // mTimeModel: value.mTimeModel,
                  //  onSelection: (TimeModel mtimeModel_) =>
                  //      value.onSelectTime(mtimeModel_)
                ),
              ),
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
                        Constants.STR_IMAGE_MSG,
                        style: AppStyle.textViewStyleNormalSubtitle2(
                            context: context,
                            color: AppColors.colorBlack2,
                            fontWeightDelta: 1,
                            fontSizeDelta: 0),
                      ),
                    ),
                    const SizedBox(width: AppDimens.dimens_5),
                    Flexible(
                      child: Text(
                        Constants.STR_MAX_SIZE,
                        style: AppStyle.textViewStyleNormalSubtitle2(
                            context: context,
                            color: AppColors.colorBlack2,
                            fontWeightDelta: -1,
                            fontSizeDelta: -4),
                      ),
                    ),
                  ],
                ),
              ),

              //upload and view image selection--
              imageLoader
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          height: 30.0, child: Text('Progress: $_progress %')),
                    )
                  : imageSlider(),
            ],
          );
        });
  }

  _videoSection() {
    return GetBuilder<RescheduleBookingController>(builder: (value) {
      print("picked videos----get builder------");
      print(value.pickedVideo);
      print("is compressed-------");
      print(value.isVideoCompressed);
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
                    Constants.STR_VIDEO_MSG,
                    style: AppStyle.textViewStyleNormalSubtitle2(
                        context: context,
                        color: AppColors.colorBlack2,
                        fontWeightDelta: 1,
                        fontSizeDelta: 0),
                  ),
                ),
                const SizedBox(width: AppDimens.dimens_5),
                Text(
                  Constants.STR_MAX_SIZE,
                  style: AppStyle.textViewStyleNormalSubtitle2(
                      context: context,
                      color: AppColors.colorBlack2,
                      fontWeightDelta: -1,
                      fontSizeDelta: -4),
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
                            Constants.TXT_PLEASE_WAIT +
                                ' ${snapshot.data.toStringAsFixed(0)}%',
                            style: AppStyle.textViewStyleSmall(
                                context: context, color: AppColors.colorBlack),
                          ),
                          margin:
                              const EdgeInsets.only(top: AppDimens.dimens_8),
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
                child: Row(
                  children: [
                    //----------------------video seleciton box------------
                    Visibility(
                        visible: Global.checkNull(value.pickedVideo),
                        child: Container(
                          margin:
                              const EdgeInsets.only(right: AppDimens.dimens_15),
                          height: AppDimens.dimens_100,
                          width: AppDimens.dimens_100,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(AppDimens.dimens_5),
                                ),
                                height: AppDimens.dimens_100,
                                width: AppDimens.dimens_100,
                                child: InkWell(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          AppDimens.dimens_5),
                                      child: Container(
                                        color: AppColors.colorGray2,
                                        child: Icon(
                                          Icons.play_arrow,
                                          color: AppColors.curiousBlue,
                                        ),
                                        padding: const EdgeInsets.all(
                                            AppDimens.dimens_35),
                                        // width: width != null ? width : AppDimens.dimens_100,
                                        // height: height != null ? height : AppDimens.dimens_100,
                                      )),
                                  onTap: () {
                                    Global.gotoVideoView(
                                        context, value.pickedVideo);
                                  },
                                ),
                              ),
                              Positioned(
                                  right: 0,
                                  top: 0,
                                  child: InkWell(
                                      child: const Icon(Icons.close),
                                      onTap: () {
                                        value.onDeleteVideo();
                                      } //=>
                                      ))
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
                            onPressed: () {

                              value.pickVideo(ImageSource.gallery);
                            },
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: AppDimens.dimens_15),
                            child: MediaButton(
                              strImage: AppImages.ic_video_cam,
                              onPressed: () {
                                value.pickVideo(ImageSource.camera);
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                visible: !value.isVideoCompressed,
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
                      Constants.STR_LEAVE_VOICE_NOTE,
                      style: AppStyle.textViewStyleNormalSubtitle2(
                          context: context,
                          color: AppColors.colorBlack2,
                          fontWeightDelta: 1,
                          fontSizeDelta: 0),
                    ),
                  ),
                  const SizedBox(width: AppDimens.dimens_5),
                  Text(
                    Constants.STR_MAX_SIZE,
                    style: AppStyle.textViewStyleNormalSubtitle2(
                        context: context,
                        color: AppColors.colorBlack2,
                        fontWeightDelta: -1,
                        fontSizeDelta: -4),
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
            Constants.STR_ADDRESS,
            style: AppStyle.textViewStyleNormalSubtitle2(
                context: context,
                color: AppColors.colorBlack2,
                fontWeightDelta: 1,
                fontSizeDelta: 0),
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
              style: AppStyle.textViewStyleNormalBodyText2(
                  color: AppColors.colorBlack,
                  fontSizeDelta: 0,
                  fontWeightDelta: 0,
                  context: context),
              controller: reScheduleController.addressNote,
              readOnly: true,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                prefixIconConstraints:
                    const BoxConstraints(minWidth: AppDimens.dimens_33),
                suffixIconConstraints:
                    const BoxConstraints(minWidth: AppDimens.dimens_33),
                suffixIcon: Container(
                  margin: const EdgeInsets.only(right: AppDimens.dimens_12),
                  alignment: Alignment.center,
                  width: 5,
                ),
                contentPadding: const EdgeInsets.only(
                    top: AppDimens.dimens_7, left: AppDimens.dimens_15),
                focusedBorder: AppViews.textFieldRoundBorder(),
                border: AppViews.textFieldRoundBorder(),
                disabledBorder: AppViews.textFieldRoundBorder(),
                focusedErrorBorder: AppViews.textFieldRoundBorder(),
                hintText: "Adress",
                filled: true,
                fillColor: AppColors.colorGray2,
                hintStyle: AppStyle.textViewStyleNormalBodyText2(
                    color: AppColors.colorTextFieldHint,
                    fontSizeDelta: 0,
                    fontWeightDelta: 0,
                    context: context),
              ),
            ),
            height: AppDimens.dimens_50,
          ),
          decoration:
              AppViews.getGrayDecoration(mBorderRadius: AppDimens.dimens_5),
        )
      ],
    );
  }

  _anyNoteTextFiledSection() {
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
            Constants.STR_LEAVE_NOTE,
            style: AppStyle.textViewStyleNormalSubtitle2(
                context: context,
                color: AppColors.colorBlack2,
                fontWeightDelta: 1,
                fontSizeDelta: 0),
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
              style: AppStyle.textViewStyleNormalBodyText2(
                  color: AppColors.colorBlack,
                  fontSizeDelta: 0,
                  fontWeightDelta: 0,
                  context: context),
              controller: reScheduleController.controllerNote,
              textAlign: TextAlign.start,
              //readOnly: true,
              decoration: InputDecoration(
                prefixIconConstraints:
                    const BoxConstraints(minWidth: AppDimens.dimens_33),
                suffixIconConstraints:
                    const BoxConstraints(minWidth: AppDimens.dimens_33),
                suffixIcon: Container(
                  margin: const EdgeInsets.only(right: AppDimens.dimens_12),
                  alignment: Alignment.center,
                  width: AppDimens.dimens_50,
                ),
                contentPadding: const EdgeInsets.only(
                    top: AppDimens.dimens_7, left: AppDimens.dimens_15),
                focusedBorder: AppViews.textFieldRoundBorder(),
                border: AppViews.textFieldRoundBorder(),
                disabledBorder: AppViews.textFieldRoundBorder(),
                focusedErrorBorder: AppViews.textFieldRoundBorder(),
                hintText: "Write a message...",
                // filled: true,
                fillColor: AppColors.colorGray2,
                hintStyle: AppStyle.textViewStyleNormalBodyText2(
                    color: AppColors.colorTextFieldHint,
                    fontSizeDelta: 0,
                    fontWeightDelta: 0,
                    context: context),
              ),
            ),
            height: AppDimens.dimens_50,
          ),
          decoration:
              AppViews.getGrayDecoration(mBorderRadius: AppDimens.dimens_5),
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
              ImagePreviews(imagePaths,
                  onDelete: _onDeleteImage, onSelect: _onSelectImage),
              //image
              InkWell(
                onTap: () async {
                  await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          contentPadding: EdgeInsets.zero,
                          backgroundColor: AppColors.colorWhite,
                          title: Text(
                            'Select Image',
                            textAlign: TextAlign.center,
                            style: AppStyle.textViewStyleLarge(
                                context: context,
                                color: AppColors.colorBlack,
                                fontWeightDelta: 1,
                                fontSizeDelta: 3),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Divider(),
                              ListTile(
                                  onTap: () async {
                                    Navigator.pop(context);
                                    final pickedFile =
                                        await _imagePicker.getImage(
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
                                    'Take a Photo',
                                    style:
                                        AppStyle.textViewStyleNormalSubtitle2(
                                            context: context,
                                            color: AppColors.colorBlack,
                                            fontWeightDelta: 1,
                                            fontSizeDelta: 2),
                                  )),
                              ListTile(
                                onTap: () async {
                                  Navigator.pop(context);

                                  final pickedFile =
                                      await _imagePicker.getImage(
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
                                  'Upload Image',
                                  style: AppStyle.textViewStyleNormalSubtitle2(
                                      context: context,
                                      color: AppColors.colorBlack,
                                      fontWeightDelta: 1,
                                      fontSizeDelta: 2),
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            ElevatedButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.pop(context);
                                })
                          ],
                        );
                      });
                },
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
                      padding: EdgeInsets.all(8.0),
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

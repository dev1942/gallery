import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:otobucks/View/MyBookings/widget/date_selector_view.dart';
import 'package:otobucks/View/MyBookings/widget/time_selector_view.dart';
import 'package:otobucks/controllers/estimation_sidebar_controllers/view_estimation_controller.dart';
import 'package:otobucks/global/adaptive_helper.dart';
import 'package:otobucks/model/estimates_model.dart';
import 'package:otobucks/widgets/cancel_booking_dialog.dart';
import 'package:otobucks/widgets/fade_in_image.dart';
import 'package:otobucks/widgets/gradient_text.dart';
import '../../../../global/app_colors.dart';
import '../../../../global/app_dimens.dart';
import '../../../../global/app_style.dart';
import '../../../../global/app_views.dart';
import '../../../../global/constants.dart';
import '../../../../global/enum.dart';
import '../../../../global/global.dart';
import '../../../global/app_images.dart';
import '../../../model/time_model.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/date_selector.dart';
import '../../../widgets/google_map_view.dart';
import '../../../widgets/image_view.dart';
import '../../../widgets/media_button.dart';
import '../../../widgets/time_selector.dart';
import '../../../widgets/voice_note_buttons.dart';

class ViewBookingEstimation extends StatefulWidget {
  final EstimatesModel mEstimatesModel;
  final String screen;

  const ViewBookingEstimation(
      {Key? key, required this.mEstimatesModel, required this.screen})
      : super(key: key);
  @override
  ViewBookingEstimationState createState() => ViewBookingEstimationState();
}
class ViewBookingEstimationState extends State<ViewBookingEstimation> {
  var controller = Get.put(ViewEstimationController());
  @override
  void initState() {
    controller.estimatesModel = widget.mEstimatesModel;
    controller.onInitScreen(widget.mEstimatesModel);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppViews.initAppBar(
        mContext: context,
        centerTitle: false,
        strTitle: widget.mEstimatesModel.source!.title + " Detail",
        isShowNotification: false,
        isShowSOS: false,
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.getMainBgColor(),
      body: Stack(
        children: [
          Container(
            color: AppColors.colorBlueStart,
            //height: AppDimens.dimens_120,
            height: 0,
          ),
          ListView(
            children: [
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
                      //Voice Note
                      _voiceNoteSection(),
                      //Leave Note (if any)

                      _anyNoteTextFiledSection(),
                     // if (widget.screen == 'cancelled')
                        Container(
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
                              onPressed: (){},
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
          GetBuilder<ViewEstimationController>(
            builder: (value) =>
                AppViews.showLoadingWithStatus(value.isShowLoader),
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
                controller.cancelEstimation(strReason);
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
                image: controller.estimatesModel!.getProviderImage(),
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
                  controller.estimatesModel!.mServiceProviderModel != null
                      ? controller.estimatesModel!.mServiceProviderModel!
                      .getName()
                      : "",
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
                    controller.gotoProfile(context);
                  },
                ),
              ],
            ))
      ],
    ),
  );

  _uploadImagesSection() {
    return GetBuilder<ViewEstimationController>(
        init: ViewEstimationController(),
        builder: (value) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                      value.estimatesModel!.source!.title,
                      style: AppStyle.textViewStyleNormalSubtitle2(
                          context: context,
                          color: Colors.grey,
                          fontSizeDelta: 1,
                          fontWeightDelta: -1),
                    ),
                  ],
                ),
              ),
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
                      value.estimatesModel!.mServiceProviderModel!.getName(),
                      style: AppStyle.textViewStyleNormalSubtitle2(
                          context: context,
                          color: Colors.grey,
                          fontSizeDelta: 1,
                          fontWeightDelta: -1),
                    ),
                  ],
                ),
              ),
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
                          value.estimatesModel!.source!.currency) +
                          value.estimatesModel!.source!.price,
                      style: AppStyle.textViewStyleNormalSubtitle2(
                          context: context,
                          color: AppColors.colorTextBlue,
                          fontSizeDelta: 0,
                          fontWeightDelta: 3),
                    ),
                  ],
                ),
              ),
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

              Container(
                margin: const EdgeInsets.only(
                  top: AppDimens.dimens_8,
                  left: AppDimens.dimens_14,
                  right: AppDimens.dimens_14,
                ),
                child: DateViewSelector(
                    selectedDate: value.estimatesModel!.getDateInFormate(),
                    onSelection: (String _selectedDate) {
                      // print(_selectedDate);

                     // value.onSelectDate(_selectedDate);
                    },

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
                child: TimeViewSelector(
                    selectedDate: value.selectedDate,
                    mTimeModel: value.mTimeModel,
                    onSelection: (TimeModel mtimeModel_) =>
                        value.onSelectTime(mtimeModel_)),
              ),
              //Upload image or Take a photo
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
              Container(
                margin: const EdgeInsets.only(
                  top: AppDimens.dimens_10,
                  left: AppDimens.dimens_14,
                  right: AppDimens.dimens_14,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Visibility(
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
                                child: ImageView(strImage: value.pickedImage),
                              ),
                              Positioned(
                                  right: 0,
                                  top: 0,
                                  child: InkWell(
                                    child: const Icon(Icons.close),
                                    onTap: () {},
          //value.onDeleteImage(),
                                  ))
                            ],
                          ),
                        ),
                        visible: Global.checkNull(value.pickedImage),
                      ),
                      Visibility(
                          visible: !Global.checkNull(value.pickedImage),
                          child: Row(
                            children: [
                              MediaButton(
                                strImage: AppImages.ic_cloud,
                                onPressed: () {
                                //  value.getImage(ImageSource.gallery);
                                },
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: AppDimens.dimens_15),
                                child: MediaButton(
                                  strImage: AppImages.ic_camera,
                                  onPressed: () {
                                   // value.getImage(ImageSource.camera);
                                  },
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  _videoSection() {
    return GetBuilder<ViewEstimationController>(builder: (value) {
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
                                    onTap: () {}//=> value.onDeleteVideo(),
                                  ))
                            ],
                          ),
                        )),
                    Visibility(
                      visible: !Global.checkNull(value.pickedVideo),
                      child: Row(
                        children: [
                          MediaButton(
                            strImage: AppImages.ic_cloud,
                            onPressed: () {
                             // value.pickVideo(ImageSource.gallery);
                            },
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: AppDimens.dimens_15),
                            child: MediaButton(
                              strImage: AppImages.ic_video_cam,
                              onPressed: () {
                               // value.pickVideo(ImageSource.camera);
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

  _voiceNoteSection() => GetBuilder<ViewEstimationController>(builder: (value) {
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
          child: VoiceRecordingButton(
            // strVoiceNotePath: 'https://flutter-sound.canardoux.xyz/web_example/assets/extract/01.aac',
            strVoiceNotePath: value.voiceNoteFile,
            callback: (String filePath) {
              //value.onSelectVoiceNote(filePath);

    }
          ),
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
              controller: controller.addressNote,
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
              controller: controller.controllerNote,
              textAlign: TextAlign.start,
              readOnly: true,
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
}

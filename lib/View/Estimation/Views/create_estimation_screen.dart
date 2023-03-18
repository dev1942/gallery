import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:otobucks/View/CheckOut/Views/checkout_screen.dart';
import 'package:otobucks/View/MyBookings/controller/estimation_controller.dart';
import 'package:otobucks/View/Profile/Controller/profile_screen_controller.dart';
import 'package:otobucks/global/adaptive_helper.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_images.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/View/Services_All/Models/service_model.dart';
import 'package:otobucks/widgets/custom_button.dart';
import 'package:otobucks/widgets/custom_ui/drop_down/dropdown_button2.dart';
import 'package:otobucks/widgets/date_selector.dart';
import 'package:otobucks/widgets/fade_in_image.dart';
import 'package:otobucks/widgets/google_map_view.dart';
import 'package:otobucks/widgets/gradient_text.dart';
import 'package:otobucks/widgets/image_view.dart';
import 'package:otobucks/widgets/media_button.dart';
import 'package:otobucks/widgets/time_selector.dart';
import 'package:otobucks/widgets/voice_note_buttons.dart';
import 'dart:io' show Platform;
import '../../../global/Models/time_model.dart';

class CreateEstimationScreen extends StatefulWidget {
  final ServiceModel mServiceModel;
  final String screenType;

  const CreateEstimationScreen(
      {Key? key, required this.mServiceModel, required this.screenType})
      : super(key: key);

  @override
  CreateEstimationScreenState createState() => CreateEstimationScreenState();
}

class CreateEstimationScreenState extends State<CreateEstimationScreen> {
  var controller = Get.put(CreateEstimationController());
  var profileController = Get.put(ProfileScreenController());

  @override
  void initState() {
    controller.mServiceModel = widget.mServiceModel;
    controller.controllerNote.clear();
    getcardata();
    controller.getLocationAdress();
    super.initState();
  }

  List<String>? carNamesList = [];
  List<String>? carNameId = [];

  getcardata() {
    if (profileController.carList.isNotEmpty) {
      for (int i = 0; i < profileController.carList.length; i++) {
        carNamesList?.add(profileController.carList[i].brand!);
        carNameId?.add(profileController.carList[i].id!);
      }
    }
  }

  String? selectedValue = "";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    log("---------car list----------------");
    log(carNamesList.toString());
    log(carNameId.toString());

    return Scaffold(
      appBar: AppViews.initAppBar(
        mContext: context,
        centerTitle: false,
        strTitle: "${widget.mServiceModel.title} Detail",
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
                alignment: AlignmentDirectional.centerStart,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _dateTimeSection(),
                    if (widget.screenType != 'promotion')
                      _uploadImagesSection(),
                    //Upload Video or Shoot a video
                    if (widget.screenType != 'promotion') _videoSection(),
                    //Voice Note
                    if (widget.screenType != 'promotion') _voiceNoteSection(),
                   // Leave Note (if any)
                    if (widget.screenType != 'promotion')

                    _anyNoteTextFiledSection(),
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
                          onPressed: () {
                            if (controller.isValid()) {
                              if (widget.screenType == 'promotion') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CheckoutScreen(
                                              promotionID:
                                                  widget.mServiceModel.id,
                                              address: controller
                                                  .addressNote.text
                                                  .toString(),
                                              date: controller.selectedDate,
                                              time: controller
                                                  .mTimeModel!.time_24hr,
                                              amount: controller
                                                  .mServiceModel.price,
                                              note: controller
                                                  .controllerNote.text,
                                              previousAmount: controller
                                                  .mServiceModel.beforePrice,
                                              discount: controller
                                                  .mServiceModel.discount,
                                            )));
                              } else {
                                if (selectedValue != null &&
                                    selectedValue!.isNotEmpty) {
                                  int index =
                                      carNamesList!.indexOf(selectedValue!);
                                  controller.createEstimation(
                                      context, carNameId![index]);
                                } else {
                                  Global.showToastAlert(
                                      context: Get.overlayContext!,
                                      strTitle: "",
                                      strMsg: "Please Select a Car",
                                      toastType: TOAST_TYPE.toastInfo);
                                }

                                //
                              }
                            }
                          },
                          strTitle: widget.screenType == 'promotion'
                              ? 'Process To Payment'
                              : Constants.TXT_REQUEST_ESTIMATION.tr),
                    ),
                  ],
                ),
              )

              // Expanded(child: Container()),
            ],
          ),
          GetBuilder<CreateEstimationController>(
            builder: (value) =>
                AppViews.showLoadingWithStatus(value.isShowLoader),
          )
        ],
      ),
    );
  }

  _profileSection() => Container(
        margin: const EdgeInsetsDirectional.only(
            start: AppDimens.dimens_20,
            top: AppDimens.dimens_20,
            bottom: AppDimens.dimens_30,
            end: AppDimens.dimens_20),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(
                end: AppDimens.dimens_20,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppDimens.dimens_5),
                child: NetworkImageCustom(
                    image: controller.mServiceModel.getProviderImage(),
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
                  // ignore: unnecessary_null_comparison
                  controller.mServiceModel.mServiceProviderModel != null
                      ? controller.mServiceModel.mServiceProviderModel.getName()
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
                        "View Profile".tr,
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

  _dateTimeSection() {
    return GetBuilder<CreateEstimationController>(builder: (value) {
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
                    "Service".tr,
                    style: AppStyle.textViewStyleNormalSubtitle2(
                        context: context,
                        color: AppColors.colorGray,
                        fontSizeDelta: 1,
                        fontWeightDelta: 1),
                  ),
                ),
                Text(
                  value.mServiceModel.mSubCategoryModel.title,
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
                    "Provider".tr,
                    style: AppStyle.textViewStyleNormalSubtitle2(
                        context: context,
                        color: AppColors.colorGray,
                        fontSizeDelta: 1,
                        fontWeightDelta: 1),
                  ),
                ),
                Text(
                  value.mServiceModel.mServiceProviderModel.getName(),
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
                    "Service Price per hour".tr,
                    style: AppStyle.textViewStyleNormalSubtitle2(
                        context: context,
                        color: AppColors.colorGray,
                        fontSizeDelta: 1,
                        fontWeightDelta: 1),
                  ),
                ),
                GradientText(
                  //  Global.replaceCurrencySign(value.mServiceModel.currency) +
                  "AED " + value.mServiceModel.price,
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
                  onTap: (LatLng mLatLng_) => value.updateLatLang(mLatLng_))),
          _addressTextFiledSection(),
          Container(
            margin: const EdgeInsets.only(
              top: AppDimens.dimens_15,
              left: AppDimens.dimens_14,
              right: AppDimens.dimens_14,
            ),
            //...................cars text

            child: carNamesList!.isNotEmpty
                ? Text(
                    "Car".tr,
                    style: AppStyle.textViewStyleNormalSubtitle2(
                        context: context,
                        color: AppColors.colorBlack2,
                        fontWeightDelta: 1,
                        fontSizeDelta: 0),
                  )
                : const Text(
                    "You have not added car details yet. Go to profile and add a car.",
                    style: TextStyle(color: Colors.red),
                  ),
          ),
          //..................drop down car list..........................
          Container(
              margin: const EdgeInsets.only(
                top: AppDimens.dimens_8,
                left: AppDimens.dimens_14,
                right: AppDimens.dimens_14,
              ),
              child: carNamesList!.isNotEmpty
                  ? DropdownButtonFormField2(
                      buttonHeight: 45,
                      decoration: InputDecoration(
                        //Add isDense true and zero Padding.
                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                        isDense: true,
                        hintStyle: AppStyle.textViewStyleNormalBodyText2(
                            color: AppColors.colorTextFieldHint,
                            fontSizeDelta: -5,
                            fontWeightDelta: -1,
                            context: Get.context!),
                        fillColor: Colors.white,
                        focusedBorder: AppViews.textFieldRoundBorder(),
                        border: AppViews.textFieldRoundBorder(),
                        disabledBorder: AppViews.textFieldRoundBorder(),
                        focusedErrorBorder: AppViews.textFieldRoundBorder(),
                        contentPadding: EdgeInsets.zero,
                        filled: true,
                        //Add more decoration as you want here
                        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                      ),
                      isExpanded: true,
                      hint: Text(
                        "Choose Your Car".tr,
                      ),
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Colors.black),
                      iconSize: 30,
                      buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                      dropdownDecoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      items: carNamesList!
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: AppStyle.textViewStyleSmall(
                                      context: Get.context!,
                                      color: Colors.black),
                                ),
                              ))
                          .toList(),
                      // validator: (value) {
                      //   if (value == null) {
                      //     return 'Field can not empty';
                      //   }
                      // },

                      onChanged: (value) {
                        selectedValue = value.toString();
                        setState(() {});
                      },
                      onSaved: (value) {
                        selectedValue = value.toString();
                        setState(() {});
                      },
                    )
                  : const SizedBox()),

          Container(
            margin: const EdgeInsets.only(
              top: AppDimens.dimens_15,
              left: AppDimens.dimens_14,
              right: AppDimens.dimens_14,
            ),
            child: Text(
              "Date & Time".tr,
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
            child: DateSelector(
                onSelection: (String _selectedDate) =>
                    value.onSelectDate(_selectedDate)),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: AppDimens.dimens_15,
              left: AppDimens.dimens_14,
              right: AppDimens.dimens_14,
            ),
            child: Text(
              "Time".tr,
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
            child: TimeSelector(
                selectedDate: value.selectedDate,
                mTimeModel: value.mTimeModel,
                onSelection: (TimeModel mtimeModel_) =>
                    value.onSelectTime(mtimeModel_)),
          ),
        ],
      );
    });
  }

//   static Widget defaultDropDownInPutFieldButton(
//       {required List<String> itemsList,
//         required String? selectedValue,
//         required String? hintText}) {
//     return
//
//
//   }
// }
  _uploadImagesSection() {
    return GetBuilder<CreateEstimationController>(
        init: CreateEstimationController(),
        builder: (value) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                        Constants.STR_IMAGE_MSG.tr,
                        style: AppStyle.textViewStyleNormalSubtitle2(
                            context: context,
                            color: AppColors.colorBlack2,
                            fontWeightDelta: 1,
                            fontSizeDelta: 0),
                      ),
                    ),
                    const SizedBox(width: AppDimens.dimens_5),
                    Text(
                      Constants.STR_MAX_SIZE.tr,
                      style: AppStyle.textViewStyleNormalSubtitle2(
                          context: context,
                          color: AppColors.colorBlack2,
                          fontWeightDelta: -1,
                          fontSizeDelta: -4),
                    ),
                  ],
                ),
              ),
              Platform.isIOS
                  ? Text(
                      "(it can take sometime opening camera for the first time)",
                      style: AppStyle.textViewStyleNormalSubtitle2(
                          context: context,
                          color: AppColors.colorBlack2,
                          fontWeightDelta: -1,
                          fontSizeDelta: -4),
                    )
                  : Container(),

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
                                    onTap: () => value.onDeleteImage(),
                                  ))
                            ],
                          ),
                        ),
                        visible: Global.checkNull(value.pickedImage),
                      ),
                      value.pickedImage == null || value.pickedImage.isEmpty
                          ? Row(
                              children: [
                                MediaButton(
                                  strImage: AppImages.ic_cloud,
                                  onPressed: () async {
                                    value.showLoader().then((voi) {
                                      value.getImage(ImageSource.gallery);
                                    });
                                  },
                                ),
                                Container(
                                  margin: const EdgeInsetsDirectional.only(
                                      start: AppDimens.dimens_15),
                                  child: MediaButton(
                                    strImage: AppImages.ic_camera,
                                    onPressed: () {
                                      value.showLoader().then((voi) =>
                                          value.getImage(ImageSource.camera));
                                    },
                                  ),
                                ),
                              ],
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  _videoSection() {
    return GetBuilder<CreateEstimationController>(
        init: CreateEstimationController(),
        builder: (value) {
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
                        style: AppStyle.textViewStyleNormalSubtitle2(
                            context: context,
                            color: AppColors.colorBlack2,
                            fontWeightDelta: 1,
                            fontSizeDelta: 0),
                      ),
                    ),
                    const SizedBox(width: AppDimens.dimens_5),
                    Text(
                      Constants.STR_MAX_SIZE.tr,
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
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
                                    context: context,
                                    color: AppColors.colorBlack),
                              ),
                              margin: const EdgeInsets.only(
                                  top: AppDimens.dimens_8),
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
                              margin: const EdgeInsetsDirectional.only(
                                  end: AppDimens.dimens_15),
                              height: AppDimens.dimens_100,
                              width: AppDimens.dimens_100,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          AppDimens.dimens_5),
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
                                        onTap: () => value.onDeleteVideo(),
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
                                  value.showLoader();
                                  value.pickVideo(ImageSource.gallery);
                                },
                              ),
                              Container(
                                margin: const EdgeInsetsDirectional.only(
                                    start: AppDimens.dimens_15),
                                child: MediaButton(
                                  strImage: AppImages.ic_video_cam,
                                  onPressed: () {
                                    value.showLoader();
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

  _voiceNoteSection(){
    return GetBuilder<CreateEstimationController>(builder: (value) {
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
                    style: AppStyle.textViewStyleNormalSubtitle2(
                        context: context,
                        color: AppColors.colorBlack2,
                        fontWeightDelta: 1,
                        fontSizeDelta: 0),
                  ),
                ),
                const SizedBox(width: AppDimens.dimens_5),
                Text(
                  Constants.STR_MAX_SIZE.tr,
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
            child: InkWell(
              onTap: () {},
              child: VoiceRecordingButton(
                // strVoiceNotePath: 'https://flutter-sound.canardoux.xyz/web_example/assets/extract/01.aac',
                strVoiceNotePath: value.voiceNoteFile,
                callback: (String filePath) =>
                    value.onSelectVoiceNote(filePath),
              ),
            ),
          ),
        ],
      );
    });
  }


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
                hintText: "Adress".tr,
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
            Constants.STR_LEAVE_NOTE.tr,
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
                hintText: "Write a message...".tr,
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
          // decoration: AppViews.getBoxDecorColorVise(mBorderRadius: AppDimens.dimens_5),
        )
      ],
    );
  }
// Future  hitAPI() async {
//   final response=await http.get(Uri.parse('https://developmentapi-app.otobucks.com/v1/bookings/bookService'));
//   if(response.statusCode==200){
//     return log(response.body.toString());
//   }
//   else{
//     return log(response.body.toString());
//   }
// }
}

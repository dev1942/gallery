import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../global/app_colors.dart';
import '../../global/app_dimens.dart';
import '../../global/app_images.dart';
import '../../global/app_style.dart';
import '../../global/app_views.dart';
import '../../global/constants.dart';
import '../../global/enum.dart';
import '../../global/global.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield_with_icon.dart';
import '../../widgets/image_view.dart';
import '../../widgets/media_button.dart';
import '../Profile/Controller/profile_screen_controller.dart';
import 'controller/add_car_controler.dart';

enum TransmitionType { manaual, autommatic }

class AddCarToSell extends StatefulWidget {
  const AddCarToSell();

  @override
  State<AddCarToSell> createState() => _AddCarToSellState();
}

class _AddCarToSellState extends State<AddCarToSell> {
  var profileController = Get.put(ProfileScreenController());

  @override
  void initState() {
    super.initState();
    profileController.getCarList().then((value) {
      // getcardata();
    });
  }

  double height = AppDimens.dimens_36;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: GetBuilder<AddCarController>(
            init: AddCarController(),
            builder: (value) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListView(
                    children: [
                      addVerticleSpace(AppDimens.dimens_16),

                      CustomTextFieldWithIcon(
                        height: 42,
                        textInputAction: TextInputAction.next,
                        enabled: true,
                        controller: value.controllerCarBrand,
                        keyboardType: TextInputType.text,
                        hintText: Constants.STR_CAR_BRAND.tr,
                        inputFormatters: const [],
                        obscureText: false,
                        onChanged: (String value) {},
                        // suffixIcon: Image.asset(
                        //   AppImages.ic_car,
                        //   width: iconSize,
                        //   height: iconSize,
                        //   color: AppColors.colorPrimary,
                        // ),
                      ),
                      addVerticleSpace(AppDimens.dimens_16),
                      CustomTextFieldWithIcon(
                        height: 42,
                        textInputAction: TextInputAction.next,
                        enabled: true,
                        controller: value.controllerCarTitle,
                        keyboardType: TextInputType.text,
                        hintText: "Title".tr,
                        inputFormatters: const [],
                        obscureText: false,
                        onChanged: (String value) {},
                      ),
                      addVerticleSpace(AppDimens.dimens_16),
                      CustomTextFieldWithIcon(
                        height: 42,
                        textInputAction: TextInputAction.next,
                        enabled: true,
                        controller: value.controllerCarDescription,
                        keyboardType: TextInputType.text,
                        hintText: "Description".tr,
                        inputFormatters: const [],
                        obscureText: false,
                        onChanged: (String value) {},
                      ),
                      addVerticleSpace(AppDimens.dimens_16),
                      CustomTextFieldWithIcon(
                        height: 42,
                        textInputAction: TextInputAction.next,
                        enabled: true,
                        controller: value.controllerCarModelYear,
                        keyboardType: TextInputType.text,
                        hintText: Constants.STR_CAR_MODEL_YEAR.tr,
                        inputFormatters: const [],
                        obscureText: false,
                        onChanged: (String value) {},
                        // suffixIcon: Image.asset(
                        //   AppImages.ic_car,
                        //   width: iconSize,
                        //   height: iconSize,
                        //   color: AppColors.colorPrimary,
                        // ),
                      ),
                      addVerticleSpace(AppDimens.dimens_16),
                      CustomTextFieldWithIcon(
                        height: 42,
                        textInputAction: TextInputAction.next,
                        enabled: true,
                        controller: value.controllerMileage,
                        keyboardType: TextInputType.text,
                        hintText: Constants.STR_MILEAGE.tr,
                        inputFormatters: const [],
                        obscureText: false,
                        onChanged: (String value) {},
                        // suffixIcon: Image.asset(
                        //   AppImages.ic_petrol,
                        //   width: iconSize,
                        //   height: iconSize,
                        //   color: AppColors.colorPrimary,
                        // ),
                      ),
                      addVerticleSpace(AppDimens.dimens_16),

                      CustomTextFieldWithIcon(
                        height: 42,
                        textInputAction: TextInputAction.next,
                        enabled: true,
                        controller: value.controllerColour,
                        keyboardType: TextInputType.text,
                        hintText: Constants.STR_CAR_COLOUR.tr,
                        inputFormatters: const [],
                        obscureText: false,
                        onChanged: (String value) {},
                        // suffixIcon: Image.asset(
                        //   AppImages.ic_color,
                        //   width: iconSize,
                        //   height: iconSize,
                        //   color: AppColors.colorPrimary,
                        // ),
                      ),
                      addVerticleSpace(AppDimens.dimens_16),
                      CustomTextFieldWithIcon(
                        height: 42,
                        textInputAction: TextInputAction.next,
                        enabled: true,
                        controller: value.controllerCarModel,
                        keyboardType: TextInputType.text,
                        hintText: "Model".tr,
                        inputFormatters: const [],
                        obscureText: false,
                        onChanged: (String value) {},
                        // suffixIcon: Image.asset(
                        //   AppImages.ic_color,
                        //   width: iconSize,
                        //   height: iconSize,
                        //   color: AppColors.colorPrimary,
                        // ),
                      ),
                      addVerticleSpace(AppDimens.dimens_16),
                      CustomTextFieldWithIcon(
                        height: 42,
                        textInputAction: TextInputAction.next,
                        enabled: true,
                        controller: value.controllerCarSeats,
                        keyboardType: TextInputType.text,
                        hintText: "Number od seats".tr,
                        inputFormatters: const [],
                        obscureText: false,
                        onChanged: (String value) {},
                        // suffixIcon: Image.asset(
                        //   AppImages.ic_color,
                        //   width: iconSize,
                        //   height: iconSize,
                        //   color: AppColors.colorPrimary,
                        // ),
                      ),
                      addVerticleSpace(AppDimens.dimens_16),
                      CustomTextFieldWithIcon(
                        height: 42,
                        textInputAction: TextInputAction.next,
                        enabled: true,
                        controller: value.controllerCarPrice,
                        keyboardType: TextInputType.text,
                        hintText: "Price".tr,
                        inputFormatters: const [],
                        obscureText: false,
                        onChanged: (String value) {},
                      ),
                      addVerticleSpace(AppDimens.dimens_16),
                      CustomTextFieldWithIcon(
                        height: 42,
                        textInputAction: TextInputAction.next,
                        enabled: true,
                        controller: value.controllerCarEngine,
                        keyboardType: TextInputType.text,
                        hintText: "Engine cc".tr,
                        inputFormatters: const [],
                        obscureText: false,
                        onChanged: (String value) {},
                      ),
                      addVerticleSpace(AppDimens.dimens_16),
                      CustomTextFieldWithIcon(
                        height: 42,
                        textInputAction: TextInputAction.next,
                        enabled: true,
                        controller: value.controllerCarFuelType,
                        keyboardType: TextInputType.text,
                        hintText: "Fuel Type".tr,
                        inputFormatters: const [],
                        obscureText: false,
                        onChanged: (String value) {},
                      ),
                      addVerticleSpace(AppDimens.dimens_16),
                      CustomTextFieldWithIcon(
                        height: 42,
                        textInputAction: TextInputAction.next,
                        enabled: true,
                        controller: value.controllerCarWarranty,
                        keyboardType: TextInputType.text,
                        hintText: "Warranty".tr,
                        inputFormatters: const [],
                        obscureText: false,
                        onChanged: (String value) {},
                      ),
                      addVerticleSpace(AppDimens.dimens_16),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFieldWithIcon(
                              height: 42,
                              textInputAction: TextInputAction.next,
                              enabled: true,
                              controller: value.controllerCarKeyfeautre,
                              keyboardType: TextInputType.text,
                              hintText: "4 Key Features".tr,
                              inputFormatters: const [],
                              obscureText: false,
                              onChanged: (String value) {},
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 80,
                            height: 43,
                            child: CustomButton(
                                isGradient: true,
                                isRoundBorder: true,
                                height: height,
                                fontSize: -2,
                                fontColor: AppColors.colorWhite,
                                width: size.width / 2.2,
                                onPressed: () {
                                  if (value.controllerCarKeyfeautre.text.isNotEmpty && value.keyfeatureList.length < 4) {
                                    value.keyfeatureList.add(value.controllerCarKeyfeautre.text);
                                    setState(() {});
                                  } else if (value.keyfeatureList.length >= 4) {
                                    Global.showToastAlert(
                                        context: Get.overlayContext!,
                                        strTitle: "",
                                        strMsg: "Only 4 key feature can be added",
                                        toastType: TOAST_TYPE.toastError);
                                  }
                                },
                                strTitle: "Add".tr),
                          ),
                        ],
                      ),
                      GetBuilder<AddCarController>(builder: (value) {
                        return Visibility(
                            visible: value.keyfeatureList.isNotEmpty,
                            child: SizedBox(
                              height: 100,
                              child: ListView(
                                padding: const EdgeInsets.all(10),
                                children: [
                                  Wrap(
                                    runAlignment: WrapAlignment.start,
                                    alignment: WrapAlignment.start,
                                    children: List.generate(
                                        value.keyfeatureList.length,
                                        (index) => InkWell(
                                              onTap: () {
                                                value.keyfeatureList.remove(value.keyfeatureList[index]);
                                                setState(() {});
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                                decoration: BoxDecoration(color: AppColors.colorPrimary),
                                                child: Text(
                                                  value.keyfeatureList[index],
                                                  style: TextStyle(fontSize: 14, color: AppColors.colorWhite),
                                                ),
                                              ),
                                            )),
                                  )
                                ],
                              ),
                            ));
                      }),
                      addVerticleSpace(AppDimens.dimens_16),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFieldWithIcon(
                              height: 42,
                              textInputAction: TextInputAction.next,
                              enabled: true,
                              controller: value.controllerCarBadges,
                              keyboardType: TextInputType.text,
                              hintText: "4 badges".tr,
                              inputFormatters: const [],
                              obscureText: false,
                              onChanged: (String value) {},
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 80,
                            height: 43,
                            child: CustomButton(
                                isGradient: true,
                                isRoundBorder: true,
                                height: height,
                                fontSize: -2,
                                fontColor: AppColors.colorWhite,
                                width: size.width / 2.2,
                                onPressed: () {
                                  if (value.controllerCarBadges.text.isNotEmpty && value.badgesList.length < 4) {
                                    value.badgesList.add(value.controllerCarBadges.text);
                                    setState(() {});
                                  } else if (value.badgesList.length >= 4) {
                                    Global.showToastAlert(
                                        context: Get.overlayContext!,
                                        strTitle: "",
                                        strMsg: "Only 4 badges can be added",
                                        toastType: TOAST_TYPE.toastError);
                                  }
                                },
                                strTitle: "Add".tr),
                          ),
                        ],
                      ),
                      GetBuilder<AddCarController>(builder: (value) {
                        return Visibility(
                            visible: value.badgesList.isNotEmpty,
                            child: SizedBox(
                              height: 100,
                              child: ListView(
                                padding: const EdgeInsets.all(10),
                                children: [
                                  Wrap(
                                    runAlignment: WrapAlignment.start,
                                    alignment: WrapAlignment.start,
                                    children: List.generate(
                                        value.badgesList.length,
                                        (index) => InkWell(
                                              onTap: () {
                                                value.badgesList.remove(value.badgesList[index]);
                                                setState(() {});
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                                decoration: BoxDecoration(color: AppColors.colorPrimary),
                                                child: Text(
                                                  value.badgesList[index],
                                                  style: TextStyle(fontSize: 14, color: AppColors.colorWhite),
                                                ),
                                              ),
                                            )),
                                  )
                                ],
                              ),
                            ));
                      }),

                      addVerticleSpace(AppDimens.dimens_16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                              checkColor: AppColors.colorBlueStart,
                              activeColor: Colors.white,
                              fillColor: MaterialStateProperty.all(AppColors.colorYellowShade),
                              value: value.isNew,
                              onChanged: (newval) {
                                value.isNew = newval!;
                                setState(() {});
                              }),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Is New'.tr,
                            style: TextStyle(color: AppColors.colorYellowShade, fontSize: size.width * 0.043),
                          ),
                          SizedBox(
                            width: size.width * 0.14,
                          ),
                          Checkbox(
                              checkColor: AppColors.colorBlueStart,
                              activeColor: Colors.white,
                              fillColor: MaterialStateProperty.all(AppColors.colorYellowShade),
                              value: value.hasAirBags,
                              onChanged: (newval) {
                                value.hasAirBags = newval!;
                                setState(() {});
                              }),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Airbags'.tr,
                            style: TextStyle(color: AppColors.colorYellowShade),
                          )
                        ],
                      ),
                      Container(
                        height: 50,
                        width: size.width * 0.9,
                        child: Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  'Automatic',
                                  style: TextStyle(color: AppColors.colorYellowShade),
                                ),
                                leading: Radio(
                                  fillColor: MaterialStateProperty.all(AppColors.colorYellowShade),
                                  value: TransmitionType.autommatic,
                                  groupValue: value.transType,
                                  onChanged: (TransmitionType? newvalue) {
                                    setState(() {
                                      value.transType = newvalue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  'Manual',
                                  style: TextStyle(color: AppColors.colorYellowShade),
                                ),
                                leading: Radio(
                                  fillColor: MaterialStateProperty.all(AppColors.colorYellowShade),
                                  value: TransmitionType.manaual,
                                  groupValue: value.transType,
                                  onChanged: (TransmitionType? newvalue) {
                                    setState(() {
                                      value.transType = newvalue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      _uploadImagesSection(),
                      addVerticleSpace(AppDimens.dimens_10),
                      _videoSection(),
                      // Align(
                      //   alignment: Alignment.centerLeft,
                      //   child: Text(
                      //     'Car Plate Number'.tr,
                      //     style: regularText600(15),
                      //   ),
                      // ),
                      // addVerticleSpace(AppDimens.dimens_12),
                      // //..........Car plete info row..................//
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     Expanded(
                      //       child: CustomTextFieldWithIcon(
                      //         height: 42,
                      //         textInputAction: TextInputAction.next,
                      //         enabled: true,
                      //         controller: value.controllerCode,
                      //         keyboardType: TextInputType.text,
                      //         hintText: 'Code'.tr,
                      //         inputFormatters: const [],
                      //         obscureText: false,
                      //         onChanged: (String value) {},
                      //       ),
                      //     ),
                      //     addHorizontalSpace(5),
                      //     Expanded(
                      //       child: CustomTextFieldWithIcon(
                      //         height: 42,
                      //         textInputAction: TextInputAction.next,
                      //         enabled: true,
                      //         controller: value.controllerCity,
                      //         keyboardType: TextInputType.text,
                      //         hintText: 'City'.tr,
                      //         inputFormatters: const [],
                      //         obscureText: false,
                      //         onChanged: (String value) {},
                      //       ),
                      //     ),
                      //     addHorizontalSpace(5),
                      //     Expanded(
                      //       child: CustomTextFieldWithIcon(
                      //         height: 42,
                      //         textInputAction: TextInputAction.next,
                      //         enabled: true,
                      //         controller: value.controllerNumber,
                      //         keyboardType: TextInputType.text,
                      //         hintText: 'Number'.tr,
                      //         inputFormatters: const [],
                      //         obscureText: false,
                      //         onChanged: (String value) {},
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      addVerticleSpace(16),
                      // edit butons................
                      CustomButton(
                          isGradient: true,
                          isRoundBorder: true,
                          height: height,
                          fontSize: -2,
                          fontColor: AppColors.colorWhite,
                          width: size.width / 2.2,
                          onPressed: () {
                            value.isValid();
                          },
                          strTitle: "Update".tr),
                      addVerticleSpace(12),
                    ],
                  ),
                )));
  }

  _uploadImagesSection() {
    return GetBuilder<AddCarController>(
        init: AddCarController(),
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
                            context: context, color: AppColors.colorBlack2, fontWeightDelta: 1, fontSizeDelta: 0),
                      ),
                    ),
                    const SizedBox(width: AppDimens.dimens_5),
                    Text(
                      Constants.STR_MAX_SIZE.tr,
                      style: AppStyle.textViewStyleNormalSubtitle2(
                          context: context, color: AppColors.colorBlack2, fontWeightDelta: -1, fontSizeDelta: -4),
                    ),
                  ],
                ),
              ),
              Platform.isIOS
                  ? Text(
                      "(it can take sometime opening camera for the first time)",
                      style: AppStyle.textViewStyleNormalSubtitle2(
                          context: context, color: AppColors.colorBlack2, fontWeightDelta: -1, fontSizeDelta: -4),
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
                        visible: Global.checkNull(value.pickedImage),
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
                                  margin: const EdgeInsetsDirectional.only(start: AppDimens.dimens_15),
                                  child: MediaButton(
                                    strImage: AppImages.ic_camera,
                                    onPressed: () {
                                      value.showLoader().then((voi) => value.getImage(ImageSource.camera));
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
    return GetBuilder<AddCarController>(
        init: AddCarController(),
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
                            context: context, color: AppColors.colorBlack2, fontWeightDelta: 1, fontSizeDelta: 0),
                      ),
                    ),
                    const SizedBox(width: AppDimens.dimens_5),
                    Text(
                      Constants.STR_MAX_SIZE.tr,
                      style: AppStyle.textViewStyleNormalSubtitle2(
                          context: context, color: AppColors.colorBlack2, fontWeightDelta: -1, fontSizeDelta: -4),
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
                              margin: const EdgeInsets.only(top: AppDimens.dimens_8),
                              child: Text(
                                Constants.TXT_PLEASE_WAIT + ' ${snapshot.data.toStringAsFixed(0)}%',
                                style: AppStyle.textViewStyleSmall(context: context, color: AppColors.colorBlack),
                              ),
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
                    visible: !value.isVideoCompressed,
                    child: Row(
                      children: [
                        Visibility(
                            visible: Global.checkNull(value.pickedVideo),
                            child: Container(
                              margin: const EdgeInsetsDirectional.only(end: AppDimens.dimens_15),
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
                                margin: const EdgeInsetsDirectional.only(start: AppDimens.dimens_15),
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
                  ),
                ),
              ),
            ],
          );
        });
  }
}

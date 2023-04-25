import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:otobucks/View/MyBookings/controller/mybookings_controller.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/widgets/custom_textfield.dart';

import '../../../../global/app_colors.dart';
import '../../../../global/app_dimens.dart';
import '../../../../global/app_images.dart';
import '../../../../global/app_style.dart';
import '../../../../global/constants.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_textfield_password.dart';
import '../../../../widgets/custom_textfield_with_icon.dart';

class OpenDisputeView extends GetView<MyBookingsController> {
  OpenDisputeView({Key? key, required this.bookingID}) : super(key: key);
  String bookingID;
  @override
  Widget build(BuildContext context) {
    Get.put(MyBookingsController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Open Complaint".tr,
          style: AppStyle.textViewStyleNormalButton(context: context, color: Colors.white, fontSizeDelta: 2),
        ),
        backgroundColor: AppColors.colorBlueStart,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 19,
          ),
        ),
      ),
      body: Stack(
        children: [
          GetBuilder<MyBookingsController>(
            builder: (value) => AppViews.showLoadingWithStatus(value.isShowLoader),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                addVerticleSpace(12),
                //Text filed title
                CustomTextFieldWithIcon(
                  textInputAction: TextInputAction.next,
                  enabled: true,
                  focusNode: FocusNode(),
                  controller: controller.disputeTitleController,
                  keyboardType: TextInputType.text,
                  hintText: Constants.STR_DISPUTE_TITLE.tr,
                  inputFormatters: [],
                  obscureText: false,
                  onChanged: (String value) {
                    Logger().i(value);
                  },
                ),
                addVerticleSpace(15),
                //text filed description
                CustomTextFieldWithIcon(
                  textInputAction: TextInputAction.next,
                  enabled: true,
                  focusNode: FocusNode(),
                  controller: controller.disputeDescriptionController,
                  keyboardType: TextInputType.text,
                  hintText: Constants.STR_DISPUTE_Desc.tr,
                  inputFormatters: [],
                  obscureText: false,
                  onChanged: (String value) {
                    Logger().i(value);
                  },
                ),
                addVerticleSpace(15),
                //select image
                GetBuilder<MyBookingsController>(builder: (logic) {
                  return Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: Get.width,
                        height: 200,
                        decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(10)),
                        child: logic.selectDisputeImage.isEmpty
                            ? InkWell(
                                onTap: () {
                                  logic.selectProfilePic(context);
                                },
                                child: Icon(
                                  CupertinoIcons.photo_on_rectangle,
                                  size: 200,
                                  color: Colors.grey.shade400,
                                ),
                              )
                            : Image.file(
                                File(controller.selectDisputeImage),
                                fit: BoxFit.cover,
                              ),
                      ),
                      //Delete image
                      IconButton(
                          onPressed: () {
                            logic.selectDisputeImage = '';
                            logic.update();
                          },
                          icon: Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                            size: 27,
                          ))
                    ],
                  );
                })
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
        child: CustomButton(
            isRoundBorder: true,
            color: AppColors.colorBlueStart,
            textStyle: AppStyle.textViewStyleNormalButton(context: context, color: Colors.white, fontSizeDelta: 2, fontWeightDelta: 1),
            onPressed: () {
              Get.defaultDialog(
                  title: "Confirmation".tr,
                  textCancel: "Close".tr,
                  textConfirm: "Confirm".tr,
                  confirmTextColor: Colors.white,
                  barrierDismissible: false,
                  content: Text(
                    "Are you sure you want to open dispute for this booking",
                    style: AppStyle.textViewStyleNormalButton(context: context, color: Colors.black),
                  ),
                  onConfirm: () {
                    controller.openDispute(bookingID, context);

                    //confirm logic
                  });
            },
            strTitle: 'Submit'.tr.toUpperCase()),
      ),
    );
  }
}

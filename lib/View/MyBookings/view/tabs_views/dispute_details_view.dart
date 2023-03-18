import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/global.dart';

import '../../../../global/app_colors.dart';
import '../../../../widgets/custom_button.dart';
import '../../Models/view_booking_model.dart';

class DisputeDetailsView extends StatelessWidget {
  DisputeDetailsView({Key? key, this.dispute}) : super(key: key);
  Dispute? dispute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dispute Detail".tr,
          style: AppStyle.textViewStyleNormalButton(
              context: context, color: Colors.white, fontSizeDelta: 2),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //image
            Container(
              width: Get.width,
              height: 250,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: InstaImageViewer(
                child: Image(
                  image: Image.file(
                    File(dispute!.disputeimage.toString()),
                    fit: BoxFit.cover,
                  ).image,
                ),
              ),
            ),
            addVerticleSpace(8),

            //ID
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "ID#".tr,
                  style: AppStyle.textViewStyleNormalButton(
                    context: context,
                    color: AppColors.lightGrey,
                    fontSizeDelta: 2,
                  ),
                ),
                Text(
                  dispute!.createdAt.toString().tr,
                  style: AppStyle.textViewStyleNormalButton(
                    context: context,
                    color: AppColors.lightGrey,
                    fontSizeDelta: 2,
                  ),
                ),
              ],
            ),
            addVerticleSpace(8),
            Text(dispute!.sId.toString()),
            addVerticleSpace(15),
            //  //Title
            Text(
              "Title".tr,
              style: AppStyle.textViewStyleNormalButton(
                context: context,
                color: AppColors.lightGrey,
                fontSizeDelta: 2,
              ),
            ),
            addVerticleSpace(8),
            Text(dispute!.title.toString()),
            addVerticleSpace(15),
            // Description
            Text(
              "Description".tr,
              style: AppStyle.textViewStyleNormalButton(
                context: context,
                color: AppColors.lightGrey,
                fontSizeDelta: 2,
              ),
            ),
            addVerticleSpace(8),
            Text(dispute!.description.toString()),
            //Remarks by admin
            addVerticleSpace(8),
            Text(
              "Admin Remarks".tr,
              style: AppStyle.textViewStyleNormalButton(
                context: context,
                color: AppColors.lightGrey,
                fontSizeDelta: 2,
              ),
            ),
            addVerticleSpace(8),
            dispute!.disputeStatus != AppStatus.TEXT_STATUS_DISPUTE_PENDING
                ? Text(
                    dispute!.adminRemarks.toString(),
                    style: TextStyle(color: AppColors.colorSuccessText),
                  )
                : Text(
              "Admin not responded yet, Please be patient".tr,
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
        child: CustomButton(
            isRoundBorder: true,
            color: AppColors.colorBlueStart,
            textStyle: AppStyle.textViewStyleNormalButton(
                context: context,
                color: Colors.white,
                fontSizeDelta: 2,
                fontWeightDelta: 1),
            onPressed: () {},
            strTitle: 'Submitted'.tr.toUpperCase()),
      ),
    );
  }
}

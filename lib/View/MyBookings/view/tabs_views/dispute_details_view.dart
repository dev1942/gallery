import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/global.dart';

import '../../../../global/app_colors.dart';
import '../../../../widgets/custom_button.dart';

class DisputeDetailsView extends StatelessWidget {
  const DisputeDetailsView({Key? key}) : super(key: key);

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
                  image: Image.asset(
                    "assets/images/bmw2.png",
                    fit: BoxFit.cover,
                  ).image,
                ),
              ),
            ),
            addVerticleSpace(8),

            //ID
            Text(
              "ID#".tr,
              style: AppStyle.textViewStyleNormalButton(
                context: context,
                color: AppColors.lightGrey,
                fontSizeDelta: 2,
              ),
            ),
            addVerticleSpace(8),
            Text("jnf877yghg87f8gh"),
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
            Text("Half amount paid but Service not Delivered yet"),
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
            Text(
                "Half amount paid but Service not Delivered yet jbv hvuihiuf ud8hrbhbfv fjhf cbwlafhiu b f  jf vbhugvv "),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 20),
        child: CustomButton(
            isRoundBorder: true,
            color: AppColors.colorBlueStart,
            textStyle: AppStyle.textViewStyleNormalButton(context: context, color: Colors.white,fontSizeDelta: 2,fontWeightDelta: 1),
            onPressed:(){},
            strTitle: 'Submitted'.tr.toUpperCase()),
      ),
    );
  }
}

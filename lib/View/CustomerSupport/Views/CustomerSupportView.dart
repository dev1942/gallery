import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:otobucks/View/MyBookings/controller/mybookings_controller.dart';
import 'package:otobucks/global/app_colors.dart';

import '../../../widgets/custom_button.dart';

class CustomerSupportView extends StatelessWidget {
  const CustomerSupportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Image.asset("assets/images/c-support.png",width: Get.width,),
             Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                  "Our customer support team is always available to help you with any questions, Let us assist you with anything you need".tr,textAlign: TextAlign.center,),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: CustomButton(isRoundBorder: true,
                  color: AppColors.colorBlueStart,
                  textStyle: TextStyle(
                    color: Colors.white,fontSize: 17
                  ),
                  onPressed: () {
                    Get.put(MyBookingsController()).launchWhatsappSendMessage("+971542457866",
                        "Hi! How Are You?");
                  } , strTitle: 'Talk Now'.tr),
            ),
          ],
        ),
      ),
    );
  }
}

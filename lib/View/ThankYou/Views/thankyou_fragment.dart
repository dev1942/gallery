import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_images.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/widgets/custom_button.dart';

import '../../../Utils/Navigation.dart';

class ThankYouFragment extends StatefulWidget {
  bool isFromPromotion;
  ThankYouFragment({Key? key, this.isFromPromotion = false}) : super(key: key);

  @override
  ThankYouFragmentState createState() => ThankYouFragmentState();
}

class ThankYouFragmentState extends State<ThankYouFragment> {
  late AssetImage image;
  @override
  void initState() {
    super.initState();
    // startTime();
    image = AssetImage(AppImages.ic_thank_you_service);
  }

  // startTime() async {
  //   var _duration = const Duration(seconds: 2);
  //   return Timer(_duration, navigateToHomePage);
  // }

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.isFromPromotion.toString());
    var size = MediaQuery.of(context).size;
    double marginBoth = AppDimens.dimens_20;
    double height = AppDimens.dimens_36;
    Widget widgetM = Scaffold(
        bottomSheet: Container(
          margin: EdgeInsets.only(top: marginBoth, bottom: marginBoth, left: marginBoth, right: marginBoth),
          child: CustomButton(
              isGradient: true,
              isRoundBorder: true,
              height: height + AppDimens.dimens_20,
              fontSize: 0,
              fontColor: AppColors.colorWhite,
              width: size.width,
              onPressed: () {
                Navigation().navigateToHomePage();
                // if (value.isValid(context)) {
                //   value.updateProfile(context);
                // }
              },
              strTitle: "GO BACK HOME".tr),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: Container(
                  height: 300,
                  width: 350,
                  decoration: BoxDecoration(image: DecorationImage(image: image)),
                )),
            // Container(
            //   child: Image.asset(
            //     AppImages.ic_thank_you,
            //     width: AppDimens.dimens_190,
            //   ),
            //   margin: const EdgeInsets.only(top: AppDimens.dimens_20, bottom: AppDimens.dimens_20),
            // ),
            Text(
              widget.isFromPromotion ? 'Thank you for service'.tr : 'Thank you for booking.'.tr,
              textAlign: TextAlign.center,
              style: AppStyle.textViewStyleLargeSubtitle1(
                context: context,
                color: AppColors.colorBlue2,
                fontSizeDelta: 1,
                fontWeightDelta: 0,
              ),
            ),
            widget.isFromPromotion
                ? SizedBox()
                : Text(
                    'The vendor will get back to you soon.'.tr,
                    textAlign: TextAlign.center,
                    style: AppStyle.textViewStyleSmall(context: context, color: AppColors.colorBlack, fontSizeDelta: 1, fontWeightDelta: 0),
                  ),
            addVerticleSpace(widget.isFromPromotion ? 0 : 10),
            Text(
              'To track your booking, please visit My Bookings section'.tr,
              textAlign: TextAlign.center,
              style: AppStyle.textViewStyleSmall(context: context, color: AppColors.colorBlack, fontSizeDelta: 1, fontWeightDelta: 0),
            ),
          ],
        ));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.getMainBgColor(),
      body: Center(
        child: widgetM,
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_images.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/widgets/custom_button.dart';

import '../../../Utils/Navigation.dart';

class ThankYouFragment extends StatefulWidget {
  const ThankYouFragment({Key? key}) : super(key: key);

  @override
  ThankYouFragmentState createState() => ThankYouFragmentState();
}

class ThankYouFragmentState extends State<ThankYouFragment> {
  @override
  void initState() {
    super.initState();
   // startTime();
  }

  // startTime() async {
  //   var _duration = const Duration(seconds: 2);
  //   return Timer(_duration, navigateToHomePage);
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double marginBoth = AppDimens.dimens_20;
    double height = AppDimens.dimens_36;
    Widget widgetM = Scaffold(
        bottomSheet: Container(
          margin: EdgeInsets.only(
              top: marginBoth,
              bottom: marginBoth,
              left: marginBoth,
              right: marginBoth),
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
            Image.asset(AppImages.ic_thank_you_service),
            Container(
              child: Image.asset(
                AppImages.ic_thank_you,
                width: AppDimens.dimens_190,
              ),
              margin: const EdgeInsets.only(
                  top: AppDimens.dimens_20, bottom: AppDimens.dimens_20),
            ),
            Text(
              'Thank you for booking.'
                  .tr,
              textAlign: TextAlign.center,
              style: AppStyle.textViewStyleSmall(
                  context: context,
                  color: AppColors.colorYellowShade,
                  fontSizeDelta: 1,
                  fontWeightDelta: 0),
            ),
            Text(
              'The vendor will get back to you soon.'
                  .tr,
              textAlign: TextAlign.center,
              style: AppStyle.textViewStyleSmall(
                  context: context,
                  color: AppColors.colorYellowShade,
                  fontSizeDelta: 1,
                  fontWeightDelta: 0),
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

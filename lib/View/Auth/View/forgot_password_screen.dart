import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_images.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/widgets/custom_button.dart';
import 'package:otobucks/widgets/custom_textfield_password.dart';
import 'package:otobucks/widgets/custom_textfield_with_icon.dart';
import 'package:otobucks/widgets/language_dropdown.dart';

import '../controllers/forget_password_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  final controller = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: AppColors.colorWhite,
            appBar: AppBar(
              elevation: 0,
            ),
            body: Stack(
              children: [
                Container(
                  decoration: AppViews.getGradientBoxDecoration(),
                ),
                PageView(
                  controller: controller.pageController,
                  reverse: false,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _fistPage(size, context),
                    _secondPage(size, context),
                  ],
                ),
                GetBuilder<ForgotPasswordController>(builder: (value) => AppViews.showLoadingWithStatus(value.isShowLoader))
              ],
            )));
  }

  _fistPage(size, BuildContext context) => Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.only(left: AppDimens.dimens_18, right: AppDimens.dimens_18, top: AppDimens.dimens_10, bottom: AppDimens.dimens_10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(top: size.height * 0.04),
              child: const LanguageDropdown(isWhite: true),
            ),
            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(
                    left: AppDimens.dimens_24, top: AppDimens.dimens_90, bottom: AppDimens.dimens_80, right: AppDimens.dimens_24),
                child: Image.asset(AppImages.icAppIconWhite)),
            CustomTextFieldWithIcon(
              textInputAction: TextInputAction.next,
              enabled: true,
              focusNode: controller.mFocusNodeEmail,
              controller: controller.controllerEmail,
              keyboardType: TextInputType.emailAddress,
              hintText: Constants.STR_EMAIL.tr,
              inputFormatters: const [],
              obscureText: false,
              onChanged: (String value) {},
              suffixIcon: Image.asset(
                AppImages.ic_email,
                width: AppDimens.dimens_18,
                color: AppColors.colorIconGray,
              ),
            ),
            // Container(
            //   margin: const EdgeInsets.only(
            //       top: AppDimens.dimens_30, bottom: AppDimens.dimens_30),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       RotatedBox(
            //           quarterTurns: 2,
            //           child: Image.asset(
            //             AppImages.ic_white_line,
            //             width: size.width / 3,
            //           )),
            //       Container(
            //         margin: const EdgeInsets.only(
            //             left: AppDimens.dimens_10, right: AppDimens.dimens_10),
            //         child: Text(
            //           Constants.TXT_OR.tr,
            //           style: AppStyle.textViewStyleSmall(
            //               context: context,
            //               color: AppColors.colorWhite,
            //               fontSizeDelta: -2,
            //               fontWeightDelta: -10),
            //         ),
            //       ),
            //       Image.asset(
            //         AppImages.ic_white_line,
            //         width: size.width / 3,
            //       )
            //     ],
            //   ),
            // ),
            // CustomTextFieldMobile(
            //   strCountyCode: controller.strCountyCode,
            //   textInputAction: TextInputAction.done,
            //   enabled: true,
            //   controller: controller.controllerPhone,
            //   focusNode: controller.mFocusNodePhone,
            // ),
            Container(
              margin: const EdgeInsets.only(top: AppDimens.dimens_50),
              child: CustomButton(isRoundBorder: true, onPressed: () => controller.loginUserTaskForget(context), strTitle: Constants.TXT_SUBMIT.tr),
            ),
          ],
        ),
      ));

  _secondPage(size, BuildContext context) => Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.only(left: AppDimens.dimens_18, right: AppDimens.dimens_18, top: AppDimens.dimens_10, bottom: AppDimens.dimens_10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(top: size.height * 0.04),
              child: const LanguageDropdown(isWhite: true),
            ),
            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(
                    left: AppDimens.dimens_24, top: AppDimens.dimens_90, bottom: AppDimens.dimens_80, right: AppDimens.dimens_24),
                child: Image.asset(AppImages.icAppIconWhite)),
            CustomTextFieldPassword(
              enabled: true,
              focusNode: controller.mFocusNodeNewPass,
              controller: controller.newPassword,
              hintText: 'New Password'.tr,
              obscureText: false,
            ),
            const SizedBox(
              height: 18,
            ),
            CustomTextFieldPassword(
              textInputAction: TextInputAction.next,
              enabled: true,
              focusNode: controller.mFocusNodeReEnterPass,
              controller: controller.reEnterNewPassword,
              hintText: 'Re-Enter Password'.tr,
              obscureText: false,
            ),
            const SizedBox(
              height: 18,
            ),
            CustomTextFieldWithIcon(
              textInputAction: TextInputAction.next,
              enabled: true,
              focusNode: controller.mFocusNodeCode,
              controller: controller.code,
              hintText: 'Enter Token'.tr,
              obscureText: false,
              inputFormatters: const [],
              keyboardType: TextInputType.text,
            ),
            Container(
              margin: const EdgeInsets.only(top: AppDimens.dimens_50),
              child: CustomButton(isRoundBorder: true, onPressed: () => controller.resetPassword(context), strTitle: Constants.TXT_SUBMIT.tr),
            ),
          ],
        ),
      ));
}

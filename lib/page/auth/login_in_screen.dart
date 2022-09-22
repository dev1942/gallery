import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/controllers/auth_controllers/login_controller.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_images.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/widgets/custom_button.dart';
import 'package:otobucks/widgets/custom_textfield_password.dart';
import 'package:otobucks/widgets/custom_textfield_with_icon.dart';
import 'package:otobucks/widgets/language_dropdown.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (model) {
        return SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: AppColors.colorWhite,
                body: Stack(
                  children: [
                    Container(
                      decoration: AppViews.getGradientBoxDecoration(),
                    ),
                    Container(
                        padding: const EdgeInsets.only(
                            left: AppDimens.dimens_18,
                            right: AppDimens.dimens_18,
                            top: AppDimens.dimens_10,
                            bottom: AppDimens.dimens_10),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerRight,
                                margin:
                                    EdgeInsets.only(top: size.height * 0.04),
                                child: const LanguageDropdown(isWhite: true),
                              ),
                              Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(
                                      left: AppDimens.dimens_24,
                                      top: AppDimens.dimens_90,
                                      bottom: AppDimens.dimens_80,
                                      right: AppDimens.dimens_24),
                                  child: Image.asset(AppImages.icAppIconWhite)),
                              SizedBox(
                                child: CustomTextFieldWithIcon(
                                  textInputAction: TextInputAction.next,
                                  enabled: true,
                                  onTap: () => model.onTapTextField(),
                                  focusNode: model.mFocusNodeEmail,
                                  controller: model.controllerEmail,
                                  keyboardType: TextInputType.emailAddress,
                                  hintText: Constants.STR_EMAIL.tr,
                                  inputFormatters: const [],
                                  obscureText: false,
                                  onChanged: (String value) {},
                                  suffixIcon: SizedBox(
                                    child: Image.asset(
                                      AppImages.ic_email,
                                      width: AppDimens.dimens_18,
                                      color: AppColors.colorIconGray,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: AppDimens.dimens_18),
                                child: CustomTextFieldPassword(
                                    textInputAction: TextInputAction.done,
                                    enabled: true,
                                    hintText: Constants.STR_PASSWORD.tr,
                                    controller: model.controllerPassword,
                                    focusNode: model.mFocusNodePassword,
                                    obscureText: model.obscureTextM,
                                    onChanged: (bool value) =>
                                        model.textObscureTap(value)),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: AppDimens.dimens_5),
                                child: TextButton(
                                  onPressed: () =>
                                      model.forgoPasswordScreen(context),
                                  child: Text(
                                    Constants.TXT_FORGOT_PASSWORD.tr,
                                    style: AppStyle.textViewStyleSmall(
                                        context: context,
                                        color: AppColors.colorWhite,
                                        mDecoration: TextDecoration.underline,
                                        fontSizeDelta: -2,
                                        fontWeightDelta: -1),
                                  ),
                                ),
                                alignment: Alignment.centerRight,
                              ),
                              CustomButton(
                                  isRoundBorder: true,
                                  onPressed: () => model.loginUserTask(context),
                                  strTitle: 'LOGIN'.tr),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: AppDimens.dimens_40),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          right: AppDimens.dimens_4),
                                      child: Text(
                                        'donot have'.tr,
                                        style: AppStyle.textViewStyleSmall(
                                            context: context,
                                            color: AppColors.colorWhite,
                                            fontSizeDelta: 0,
                                            fontWeightDelta: -10),
                                      ),
                                    ),
                                    InkWell(
                                      child: Text(
                                        'create one'.tr,
                                        style: AppStyle.textViewStyleSmall(
                                            context: context,
                                            color: AppColors.colorWhite,
                                            mDecoration:
                                                TextDecoration.underline,
                                            fontSizeDelta: 0,
                                            fontWeightDelta: -10),
                                      ),
                                      onTap: () {
                                        model.pushRegisterScreen(context);
                                      },
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Checkbox(
                                      checkColor: AppColors.colorBlueStart,
                                      activeColor: Colors.white,
                                      fillColor: MaterialStateProperty.all(
                                          Colors.white),
                                      value: model.rememberMe,
                                      onChanged: (val) =>
                                          model.changeRemember(val!)),
                                  Text(
                                    'Remember me',
                                    style: AppStyle.textViewStyleSmall(
                                        context: context,
                                        color: AppColors.colorWhite,
                                        fontSizeDelta: 0,
                                        fontWeightDelta: -10),
                                  )
                                ],
                              )
                            ],
                          ),
                        )),
                    AppViews.showLoadingWithStatus(model.isShowLoader)
                  ],
                )));
      },
    );
  }
}

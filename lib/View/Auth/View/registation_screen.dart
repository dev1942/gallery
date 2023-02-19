import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_images.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/extensions.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/View/Auth/Models/country_code.dart';
import 'package:otobucks/widgets/country_code_bottomsheet.dart';
import 'package:otobucks/widgets/custom_button.dart';
import 'package:otobucks/widgets/custom_textfield_mobile.dart';
import 'package:otobucks/widgets/custom_textfield_password.dart';
import 'package:otobucks/widgets/custom_textfield_with_icon.dart';
import 'package:otobucks/widgets/custom_ui/bottom_sheet.dart';
import 'package:otobucks/widgets/language_dropdown.dart';
import 'package:otobucks/widgets/media_type_bottomsheet.dart';

import '../controllers/registration_controller.dart';

class RegistrationScreen extends StatefulWidget {
  final String referCode;
  const RegistrationScreen({Key? key, this.referCode = ''}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  var controller = Get.put(RegistrationScreenController());

  @override
  void initState() {
    controller.onIniteScreen();
    Future.delayed(Duration.zero, () {
      controller.setUpInviteCode(widget.referCode);
      controller.controllerCountry.text = "United Arab Emirates";
      FocusScope.of(context).requestFocus(controller.mFocusNodeFirstName);
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.onDisposeScreen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                        left: AppDimens.dimens_18, right: AppDimens.dimens_18, top: AppDimens.dimens_10, bottom: AppDimens.dimens_10),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerRight,
                            margin: const EdgeInsets.only(top: AppDimens.dimens_50),
                            child: const LanguageDropdown(isWhite: true),
                          ),
                          Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(
                                  left: AppDimens.dimens_24, top: AppDimens.dimens_10, bottom: AppDimens.dimens_36, right: AppDimens.dimens_24),
                              child: Image.asset(AppImages.icAppIconWhite)),
                          GetBuilder<RegistrationScreenController>(init: RegistrationScreenController(), builder: (model) => staticTextFileds(model)),
                          GetBuilder<RegistrationScreenController>(builder: (model) => getCountryTextFiled(model)),
                          GetBuilder<RegistrationScreenController>(builder: (model) => textFiledMobile(model)),
                          GetBuilder<RegistrationScreenController>(builder: (model) => knowAboutUsDropDown(model)),
                          GetBuilder<RegistrationScreenController>(
                              builder: (model) => (Global.checkNull(model.controllerHowAboutUs.text.toString()) &&
                                      Global.equalsIgnoreCase(model.controllerHowAboutUs.text.toString(), "Other"))
                                  ? Container(
                                      margin: const EdgeInsets.only(top: AppDimens.dimens_18),
                                      child: CustomTextFieldWithIcon(
                                        textInputAction: TextInputAction.next,
                                        enabled: true,
                                        focusNode: model.mFocusNodeInviteCode,
                                        controller: model.controllerInviteCode,
                                        keyboardType: TextInputType.text,
                                        hintText: 'Invitation Code'.tr,
                                        inputFormatters: const [],
                                        obscureText: false,
                                        onChanged: (String value) {},
                                      ),
                                    )
                                  : Container()),
                          GetBuilder<RegistrationScreenController>(builder: (model) {
                            return Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: AppDimens.dimens_18),
                                  child: CustomTextFieldPassword(
                                    textInputAction: TextInputAction.done,
                                    enabled: true,
                                    hintText: Constants.STR_PASSWORD.tr,
                                    controller: model.controllerPassword,
                                    focusNode: model.mFocusNodePassword,
                                    obscureText: model.obscureTextM,
                                    onChanged: (bool value) {
                                      setState(() {
                                        model.obscureTextM = value;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                CustomButton(
                                    isRoundBorder: true, onPressed: () => model.registerUserTask(context), strTitle: Constants.TXT_REGISTER.tr),
                                Container(
                                  margin: const EdgeInsets.only(top: AppDimens.dimens_40),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(right: AppDimens.dimens_4),
                                        child: Text(
                                          Constants.TXT_ALREADY_HAVE_AN_AC.tr,
                                          style: AppStyle.textViewStyleSmall(
                                              context: context, color: AppColors.colorWhite, fontSizeDelta: 0, fontWeightDelta: -10),
                                        ),
                                      ),
                                      InkWell(
                                        child: Text(
                                          'Login'.tr,
                                          style: AppStyle.textViewStyleSmall(
                                              context: context,
                                              color: AppColors.colorWhite,
                                              mDecoration: TextDecoration.underline,
                                              fontSizeDelta: 0,
                                              fontWeightDelta: -10),
                                        ),
                                        onTap: () {
                                          model.pushRegisterScreen1(context);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    )),
                GetBuilder<RegistrationScreenController>(builder: (model) => AppViews.showLoadingWithStatus(model.isShowLoader))
              ],
            )));
  }

  Widget staticTextFileds(RegistrationScreenController model) {
    return Column(
      children: [
        CustomTextFieldWithIcon(
          textInputAction: TextInputAction.next,
          enabled: true,
          focusNode: model.mFocusNodeFirstName,
          controller: model.controllerFirstName,
          keyboardType: TextInputType.text,
          hintText: Constants.STR_FIRST_NAME.tr,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))],
          obscureText: false,
          onChanged: (String value) {},
          suffixIcon: Image.asset(
            AppImages.ic_user_sufix,
            width: AppDimens.dimens_15,
            color: AppColors.colorIconGray,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: AppDimens.dimens_18),
          child: CustomTextFieldWithIcon(
            textInputAction: TextInputAction.next,
            enabled: true,
            // focusNode: model.mFocusNodeLastName,
            controller: model.controllerLastName,
            keyboardType: TextInputType.text,
            hintText: 'Last Name'.tr,
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))],
            obscureText: false,
            onChanged: (String value) {},
            suffixIcon: Image.asset(
              AppImages.ic_user_sufix,
              width: AppDimens.dimens_15,
              color: AppColors.colorIconGray,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: AppDimens.dimens_18),
          child: CustomTextFieldWithIcon(
            textInputAction: TextInputAction.next,
            enabled: true,
            // focusNode: model.mFocusNodeEmail,
            controller: model.controllerEmail,
            keyboardType: TextInputType.emailAddress,
            hintText: 'Email'.tr,
            inputFormatters: const [],
            obscureText: false,
            onChanged: (String value) {},
            suffixIcon: Image.asset(
              AppImages.ic_email,
              width: AppDimens.dimens_18,
              color: AppColors.colorIconGray,
            ),
          ),
        ),
      ],
    );
  }

  Widget textFiledMobile(RegistrationScreenController model) {
    return Container(
      margin: const EdgeInsets.only(top: AppDimens.dimens_18),
      child: CustomTextFieldMobile(
        strCountyCode: model.strCountyCode,
        textInputAction: TextInputAction.done,
        enabled: true,
        controller: model.controllerPhone,
        // focusNode: model.mFocusNodePhone,
      ),
    );
  }

  Widget knowAboutUsDropDown(RegistrationScreenController model) {
    return Container(
      margin: const EdgeInsets.only(top: AppDimens.dimens_18),
      child: InkWell(
        child: CustomTextFieldWithIcon(
          textInputAction: TextInputAction.next,
          enabled: false,
          focusNode: model.mFocusNodeHowAboutUs,
          controller: model.controllerHowAboutUs,
          keyboardType: TextInputType.text,
          hintText: Constants.STR_HOW_DID.tr,
          inputFormatters: const [],
          obscureText: false,
          suffixIcon: Icon(
            Icons.keyboard_arrow_down_rounded,
            size: AppDimens.dimens_18,
            color: AppColors.colorIconGray,
          ),
        ),
        onTap: () {
          showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return CustomBottomSheet(
                    child: MediaTypeBottomSheet(
                  onTap: (String strType) => model.updateKnowAboutUs(strType),
                ));
              });
        },
      ),
    );
  }

  Widget getCountryTextFiled(RegistrationScreenController model) {
    return Container(
      margin: const EdgeInsets.only(top: AppDimens.dimens_18),
      child: InkWell(
        child: CustomTextFieldWithIcon(
          textInputAction: TextInputAction.next,
          enabled: false,
          focusNode: model.mFocusNodeCountry,
          controller: model.controllerCountry,
          keyboardType: TextInputType.text,
          hintText: 'Country'.tr,
          inputFormatters: const [],
          obscureText: false,
          onChanged: (String value) {},
          prefixIcon: SizedBox(
            height: AppDimens.dimens_40,
            width: AppDimens.dimens_30,
            child: CircleAvatar(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(AppDimens.dimens_60),
              child: Image.asset(
                'assets/images/flag_' + model.strCountyFlag + '.png',
                height: AppDimens.dimens_30,
                width: AppDimens.dimens_30,
                fit: BoxFit.fill,
              ),
            )),
          ),
        ),
        onTap: () {
          showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return CustomBottomSheet(
                    child: CountryCodeBottomSheet(
                  onTap: (CountryCode mCountryCode) => model.updateCountryCode(mCountryCode),
                ));
              });
        },
      ),
    );
  }
}

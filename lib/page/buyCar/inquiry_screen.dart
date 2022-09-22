import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_images.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/text_styles.dart';
import 'package:otobucks/page/buyCar/rating_screen.dart';
import 'package:otobucks/widgets/custom_textfield_with_icon.dart';
import 'package:otobucks/widgets/small_button.dart';

class InquiryFormScreenCarBuy extends StatefulWidget {
  const InquiryFormScreenCarBuy({Key? key}) : super(key: key);

  @override
  State<InquiryFormScreenCarBuy> createState() =>
      _InquiryFormScreenCarBuyState();
}

class _InquiryFormScreenCarBuyState extends State<InquiryFormScreenCarBuy> {
  TextEditingController controllerFirstName = TextEditingController();
  TextEditingController controllerLastName = TextEditingController();
  TextEditingController controllerCountry = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();
  TextEditingController controllerHowAboutUs = TextEditingController();
  TextEditingController controllerInviteCode = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  FocusNode mFocusNodeFirstName = FocusNode();
  FocusNode mFocusNodeEmail = FocusNode();
  FocusNode mFocusNodePassword = FocusNode();
  FocusNode mFocusNodeLastName = FocusNode();
  FocusNode mFocusNodeCountry = FocusNode();
  FocusNode mFocusNodeHowAboutUs = FocusNode();
  FocusNode mFocusNodePhone = FocusNode();
  FocusNode mFocusNodeInviteCode = FocusNode();

  final BoxDecoration _boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      border: Border.all(color: AppColors.colorGray5));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppViews.initAppBar(
        mContext: context,
        centerTitle: false,
        strTitle: 'Bank',
        isShowNotification: true,
        isShowSOS: true,
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.colorBlueStart,
            width: double.infinity,
            height: AppDimens.dimens_60,
          ),
          Expanded(
            child: ListView(padding: const EdgeInsets.all(20), children: [
              Text(
                'Name',
                style: regularText600(15),
              ),
              Container(
                decoration: _boxDecoration,
                margin:
                    const EdgeInsets.only(top: AppDimens.dimens_10, bottom: 10),
                child: CustomTextFieldWithIcon(
                  textInputAction: TextInputAction.next,
                  enabled: true,
                  focusNode: mFocusNodeLastName,
                  controller: controllerLastName,
                  keyboardType: TextInputType.text,
                  hintText: 'Last Name'.tr,
                  inputFormatters: const [],
                  obscureText: false,
                  onChanged: (String value) {},
                  suffixIcon: Image.asset(
                    AppImages.ic_user_sufix,
                    width: AppDimens.dimens_15,
                    color: AppColors.colorIconGray,
                  ),
                ),
              ),
              Text(
                'Email',
                style: regularText600(15),
              ),
              Container(
                decoration: _boxDecoration,
                margin:
                    const EdgeInsets.only(top: AppDimens.dimens_10, bottom: 10),
                child: CustomTextFieldWithIcon(
                  textInputAction: TextInputAction.next,
                  enabled: true,
                  focusNode: mFocusNodeEmail,
                  controller: controllerEmail,
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
              Text(
                "Phone Number",
                style: regularText600(15),
              ),
              Container(
                decoration: _boxDecoration,
                margin:
                    const EdgeInsets.only(top: AppDimens.dimens_10, bottom: 10),
                child: CustomTextFieldWithIcon(
                  textInputAction: TextInputAction.next,
                  enabled: true,
                  focusNode: mFocusNodeEmail,
                  controller: controllerEmail,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Phone Number',
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
              Text(
                'Note',
                style: regularText600(15),
              ),
              Container(
                decoration: _boxDecoration,
                margin:
                    const EdgeInsets.only(top: AppDimens.dimens_10, bottom: 10),
                child: CustomTextFieldWithIcon(
                  textInputAction: TextInputAction.next,
                  enabled: true,
                  focusNode: mFocusNodeEmail,
                  controller: controllerEmail,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Note',
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
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                child: PrimaryButton(
                  label: const Text('Inquiry Now'),
                  color: null,
                  onPress: () {
                    Get.to(() => const RatingScreenCarBuy());
                  },
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

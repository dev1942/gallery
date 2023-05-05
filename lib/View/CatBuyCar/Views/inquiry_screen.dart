import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/CatBuyCar/Views/rating_screen.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_images.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/text_styles.dart';
import 'package:otobucks/widgets/custom_textfield_with_icon.dart';
import 'package:otobucks/widgets/small_button.dart';

import '../../Profile/Controller/profile_screen_controller.dart';
import '../controllers/buy_car_controller.dart';

class InquiryFormScreenCarBuy extends StatefulWidget {
  final String carId;
  const InquiryFormScreenCarBuy({Key? key, required this.carId}) : super(key: key);

  @override
  State<InquiryFormScreenCarBuy> createState() => _InquiryFormScreenCarBuyState();
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
  var controller = Get.put(BuyCarController());
  var controllerUser = Get.put(ProfileScreenController());

  final BoxDecoration _boxDecoration = BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: AppColors.colorGray5));
  @override
  void initState() {
    super.initState();
    controller.updatProductId(widget.carId);
    controllerUser.getProfile().then((value) {

    controllerLastName=TextEditingController(text: controllerUser.mUserModel!.lastName);
    controller.updateName(controllerUser.mUserModel!.lastName);
    controllerEmail=TextEditingController(text: controllerUser.mUserModel!.email);
    controller.updateEmail(controllerUser.mUserModel!.email);
    controllerPhone=TextEditingController(text: controllerUser.mUserModel!.phone);
    controller.updatePhoneNumber(controllerUser.mUserModel!.phone);
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppViews.initAppBar(
        mContext: context,
        centerTitle: false,
        strTitle: 'Send inquiry'.tr,
        isShowNotification: true,
        isShowSOS: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                color: AppColors.colorBlueStart,
                width: double.infinity,
                height: AppDimens.dimens_60,
              ),
              Expanded(
                child: ListView(padding: const EdgeInsets.all(20), children: [
                  Text(
                    'Name'.tr,
                    style: regularText600(15),
                  ),
                  Container(
                    // decoration: _boxDecoration,
                    margin: const EdgeInsets.only(top: AppDimens.dimens_10, bottom: 10),
                    child: CustomTextFieldWithIcon(
                      textInputAction: TextInputAction.next,
                      enabled: true,
                      focusNode: mFocusNodeLastName,
                      controller: controllerLastName,
                      keyboardType: TextInputType.text,
                      hintText: 'Name'.tr,
                      inputFormatters: const [],
                      obscureText: false,
                      onChanged: (String value) {
                        controller.updateName(value);
                      },
                      suffixIcon: Image.asset(
                        AppImages.ic_user_sufix,
                        width: AppDimens.dimens_15,
                        color: AppColors.colorIconGray,
                      ),
                    ),
                  ),
                  Text(
                    'Email'.tr,
                    style: regularText600(15),
                  ),
                  Container(
                    // decoration: _boxDecoration,
                    margin: const EdgeInsets.only(top: AppDimens.dimens_10, bottom: 10),
                    child: CustomTextFieldWithIcon(
                      textInputAction: TextInputAction.next,
                      enabled: true,
                      focusNode: mFocusNodeEmail,
                      controller: controllerEmail,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Email'.tr,
                      inputFormatters: const [],
                      obscureText: false,
                      onChanged: (String value) {
                        controller.updateEmail(value);
                      },
                      suffixIcon: Image.asset(
                        AppImages.ic_email,
                        width: AppDimens.dimens_18,
                        color: AppColors.colorIconGray,
                      ),
                    ),
                  ),
                  Text(
                    "Mobile Number".tr,
                    style: regularText600(15),
                  ),
                  Container(
                    // decoration: _boxDecoration,
                    margin: const EdgeInsets.only(top: AppDimens.dimens_10, bottom: 10),
                    child: CustomTextFieldWithIcon(
                      textInputAction: TextInputAction.next,
                      enabled: true,
                      focusNode: mFocusNodePhone,
                      controller: controllerPhone,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Mobile Number'.tr,
                      inputFormatters: const [],
                      obscureText: false,
                      onChanged: (String value) {
                        controller.updatePhoneNumber(value);
                      },
                      suffixIcon: Image.asset(
                        AppImages.ic_drawer_estimation,
                        width: AppDimens.dimens_18,
                        color: AppColors.colorIconGray,
                      ),
                    ),
                  ),
                  Text(
                    'Leave Note (if any)'.tr,
                    style: regularText600(15),
                  ),
                  Container(
                    // decoration: _boxDecoration,
                    margin: const EdgeInsets.only(top: AppDimens.dimens_10, bottom: 10),
                    child: CustomTextFieldWithIcon(
                      textInputAction: TextInputAction.next,
                      enabled: true,
                      focusNode: mFocusNodeInviteCode,
                      controller: controllerInviteCode,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Leave Note (if any)'.tr,
                      inputFormatters: const [],
                      obscureText: false,
                      onChanged: (String value) {
                        controller.updatenote(value);
                      },
                      suffixIcon: Image.asset(
                        AppImages.ic_edit_profile_icon,
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
                      label: Text('Submit'.tr),
                      color: null,
                      onPress: () {
                        controller.isValidInquiry(context);
                      },
                    ),
                  ),
                ]),
              ),
            ],
          ),
          GetBuilder<BuyCarController>(
            builder: (value) => AppViews.showLoadingWithStatus(value.isShowLoader),
          )
        ],
      ),
    );
  }
}

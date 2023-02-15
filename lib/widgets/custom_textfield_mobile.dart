import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/widgets/country_code_bottomsheet.dart';

import '../View/auth/controllers/registration_controller.dart';
import '../global/app_views.dart';
import '../View/Auth/Models/country_code.dart';
import 'custom_ui/bottom_sheet.dart';

// ignore: must_be_immutable
class CustomTextFieldMobile extends StatefulWidget {
  TextEditingController? controller;
  bool? enabled;
  FocusNode? focusNode;
  bool? readonly;
  double? height;
  Widget? suffixIcon;
  TextInputAction? textInputAction;
  String strCountyCode;

    CustomTextFieldMobile(
      {Key? key,
      required this.controller,
      required this.strCountyCode,
        this.readonly,
      this.focusNode,
      this.suffixIcon,
      this.height,
      this.textInputAction,
       this.enabled

      })
      : super(key: key);

  @override
  CustomTextFieldMobileState createState() => CustomTextFieldMobileState();
}

class CustomTextFieldMobileState extends State<CustomTextFieldMobile> {
  String strCountyCode = "+971";
  String strCountyFlag = "ae";

  @override
  void initState() {
    if (widget.strCountyCode.isNotEmpty) {
      strCountyCode = widget.strCountyCode;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 50,
      child: TextField(
        keyboardType: TextInputType.phone,
        maxLength: 10,
        readOnly:widget.readonly??false,
        enabled: widget.enabled,
        textInputAction: widget.textInputAction ?? TextInputAction.done,
        focusNode: widget.focusNode,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: AppStyle.textViewStyleNormalBodyText2(
            color: AppColors.colorBlack,
            fontSizeDelta: 0,
            fontWeightDelta: 0,
            context: context),
        controller: widget.controller,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          prefixIconConstraints:
              const BoxConstraints(minWidth: AppDimens.dimens_33),
          suffixIconConstraints:
              const BoxConstraints(minWidth: AppDimens.dimens_33),
          // counter: SizedBox.shrink(),
          counterText: "",
          contentPadding: const EdgeInsetsDirectional.only(top: 7),

          prefixIcon: SizedBox(
              width: 110,
              child: Row(
                children: [
                  Container(
                    // width: Responsive.screenWidth,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: BorderDirectional(
                        end: BorderSide(
                            width: AppDimens.dimens_2,
                            color: AppColors.colorIconGray),
                      ),
                    ),
                    child: InkWell(
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsetsDirectional.only(
                                  start: AppDimens.dimens_12),
                              height: AppDimens.dimens_40,
                              width: AppDimens.dimens_30,
                              child: CircleAvatar(
                                  child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(AppDimens.dimens_60),
                                child: Image.asset(
                                  'assets/images/flag_' +
                                      strCountyFlag +
                                      '.png',
                                  height: AppDimens.dimens_30,
                                  width: AppDimens.dimens_30,
                                  fit: BoxFit.fill,
                                ),
                              )),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                left: AppDimens.dimens_10,
                                right: AppDimens.dimens_10,
                              ),
                              child: Text(
                                strCountyCode,
                                style: AppStyle.textViewStyleNormalBodyText2(
                                    color: AppColors.colorBlack,
                                    fontSizeDelta: 0,
                                    fontWeightDelta: 0,
                                    context: context),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                return CustomBottomSheet(
                                    child: CountryCodeBottomSheet(
                                  onTap: (CountryCode mCountryCode) {
                                    Get.put(RegistrationScreenController())
                                        .strCountyCode = mCountryCode.dialCode;

                                    setState(() {
                                      strCountyCode = mCountryCode.dialCode;
                                      widget.strCountyCode =
                                          mCountryCode.dialCode;
                                      strCountyFlag =
                                          mCountryCode.code.toLowerCase();
                                    });
                                  },
                                ));
                              });
                        }),
                    // width: AppDimens.dimens_20,
                  ),
                  const SizedBox(
                    width: 10,
                  )
                ],
              )),
          suffixIcon: widget.suffixIcon != null
              ? Container(
                  margin: const EdgeInsetsDirectional.only(
                      end: AppDimens.dimens_12),
                  alignment: Alignment.center,
                  child: widget.suffixIcon,
                  width: AppDimens.dimens_23,
                )
              : null,
          focusedBorder: AppViews.textFieldRoundBorder(),
          border: AppViews.textFieldRoundBorder(),
          disabledBorder: AppViews.textFieldRoundBorder(),
          focusedErrorBorder: AppViews.textFieldRoundBorder(),
          hintText: Constants.STR_MOBILE_NUMBER.tr,
          filled: true,
          fillColor: AppColors.colorWhite,
          hintStyle: AppStyle.textViewStyleNormalBodyText2(
              color: AppColors.colorTextFieldHint,
              fontSizeDelta: 0,
              fontWeightDelta: 0,
              context: context),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/controllers/home_screen_controller.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';

import '../custom_ui/drop_down/dropdown_button2.dart';
import '../global/app_style.dart';

class LanguageDropdown extends StatefulWidget {
  final Function? onCallBack;
  final bool isWhite;

  const LanguageDropdown({Key? key, required this.isWhite, this.onCallBack})
      : super(key: key);

  @override
  LanguageDropdownState createState() => LanguageDropdownState();
}

class LanguageDropdownState extends State<LanguageDropdown> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(builder: (value) {
      return DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: false,
          items: value.languages
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Row(
                      children: [
                        SizedBox(
                          child: Text(
                            item,
                            style: AppStyle.textViewStyleSmall(
                                context: context,
                                color: widget.isWhite
                                    ? AppColors.colorBlack
                                    : AppColors.colorWhite,
                                fontSizeDelta: -3,
                                fontWeightDelta: 0),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
          value: value.selectedLanguage,
          onChanged: (locale) {
            if (widget.onCallBack != null) {
              widget.onCallBack!();
            }

            setState(() {
              value.changeLocale(locale as String);
            });
          },
          icon: const Icon(
            Icons.keyboard_arrow_down,
          ),
          iconSize: AppDimens.dimens_20,
          iconEnabledColor: AppColors.colorIconGray,
          iconDisabledColor: Colors.grey,
          buttonHeight: AppDimens.dimens_33,
          buttonWidth: AppDimens.dimens_80,
          buttonPadding: const EdgeInsets.only(
              left: AppDimens.dimens_10, right: AppDimens.dimens_10),
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.dimens_5),
            color: widget.isWhite
                ? AppColors.colorWhite
                : AppColors.colorBlueStart,
          ),
          buttonElevation: 2,
          itemHeight: AppDimens.dimens_33,
          dropdownMaxHeight: AppDimens.dimens_100,
          dropdownWidth: AppDimens.dimens_80,
          dropdownPadding: null,
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.dimens_5),
            color: widget.isWhite
                ? AppColors.colorWhite
                : AppColors.colorBlueStart,
          ),
          dropdownElevation: 8,
          scrollbarRadius: const Radius.circular(AppDimens.dimens_5),
          scrollbarThickness: 1,
          scrollbarAlwaysShow: true,
          offset: const Offset(0, 0),
        ),
      );
    });
  }
}

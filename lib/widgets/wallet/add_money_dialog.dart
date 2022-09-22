import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/controllers/home_screen_controller.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/text_styles.dart';
import 'package:otobucks/model/card_model.dart';

import '../../global/app_colors.dart';
import '../../global/app_dimens.dart';
import '../../global/app_style.dart';
import '../../global/enum.dart';
import '../../global/global.dart';
import '../custom_button.dart';
import '../custom_textfield_with_icon.dart';

class AddMoneyDialogBox extends StatefulWidget {
  final Function onTap;
  final String balance;
  final List<CardModel> accounts;

  const AddMoneyDialogBox(
      {Key? key,
      required this.onTap,
      required this.balance,
      required this.accounts})
      : super(key: key);

  @override
  _AddMoneyDialogBoxState createState() => _AddMoneyDialogBoxState();
}

class _AddMoneyDialogBoxState extends State<AddMoneyDialogBox> {
  TextEditingController controllerAmount = TextEditingController();

  String selectCurrency = '\$';
  late CardModel selectAccount;

  FocusNode mFocusAmount = FocusNode();

  List<String> currencies = [
    '₹',
    "\$",
    "CA\$",
    "\u20ac",
    "£",
    "¥",
    "₤",
    "₱",
    "₣",
    "U+0192",
    "د.ج.‏",
    "\u20BD‏",
    "Mex\$‏",
    "CHF",
    "öS"
  ];
  List<CardModel> accounts = [];

  @override
  void initState() {
    selectAccount = widget.accounts.first;
    accounts = widget.accounts;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.dimens_5),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      padding: const EdgeInsets.only(
          top: AppDimens.dimens_20, bottom: AppDimens.dimens_20),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimens.dimens_5),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(0, 3),
                blurRadius: 5),
          ]),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(
                    left: AppDimens.dimens_15,
                    bottom: AppDimens.dimens_10,
                    right: AppDimens.dimens_15),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        Constants.TXT_ADD_MONEY,
                        style: AppStyle.textViewStyleLarge(
                            context: context,
                            color: AppColors.colorBlack,
                            fontWeightDelta: 1,
                            fontSizeDelta: 3),
                      ),
                    )),
                    InkWell(
                      child: const Icon(
                        Icons.clear,
                        size: AppDimens.dimens_20,
                      ),
                      onTap: () {
                        Navigator.of(context).pop(true);
                      },
                    )
                  ],
                ),
              ),
              AppViews.addDivider(),
              Container(
                margin: const EdgeInsets.only(top: AppDimens.dimens_10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        height: 40,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                Get.find<HomeScreenController>()
                                    .fullName
                                    .capitalize!,
                                style: regularText(12),
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  'Wallet Balance',
                                  style: regularText(9),
                                ),
                                Text(
                                  widget.balance,
                                  style: regularText(11),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    AppViews.addDivider(),
                    Container(
                      margin: const EdgeInsets.only(left: AppDimens.dimens_10),
                      child: Text(
                        'Add Amount',
                        style: AppStyle.textViewStyleNormalSubtitle2(
                            context: context,
                            color: AppColors.colorBlack,
                            fontWeightDelta: 0,
                            fontSizeDelta: -1),
                      ),
                    ),
                    Container(
                      height: 40,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(
                          top: AppDimens.dimens_5,
                          left: AppDimens.dimens_10,
                          right: 10),
                      decoration: AppViews.getRoundBorder(
                          cBoxBgColor: AppColors.colorWhite,
                          cBorderColor: AppColors.colorBorder2,
                          dRadius: AppDimens.dimens_5,
                          dBorderWidth: AppDimens.dimens_1),
                      child: Row(
                        children: [
                          DropdownButton(
                            underline: Container(),
                            value: selectCurrency,
                            items: currencies.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              selectCurrency = value!;
                              setState(() {});
                            },
                          ),
                          const VerticalDivider(
                            thickness: 1,
                          ),
                          Expanded(
                            child: Container(
                                margin: const EdgeInsets.only(
                                    top: AppDimens.dimens_5),
                                child: CustomTextFieldWithIcon(
                                  height: AppDimens.dimens_36,
                                  textInputAction: TextInputAction.next,
                                  enabled: true,
                                  focusNode: mFocusAmount,
                                  controller: controllerAmount,
                                  keyboardType: TextInputType.number,
                                  hintText: 'Amount',
                                  inputFormatters: const [],
                                  autofillHints: const <String>[
                                    AutofillHints.creditCardName
                                  ],
                                  onEditingComplete: () {
                                    FocusScope.of(context)
                                        .requestFocus(mFocusAmount);
                                  },
                                  obscureText: false,
                                  onChanged: (String value) {},
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: AppDimens.dimens_10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: AppDimens.dimens_10, right: 10),
                      child: Text(
                        'Select Account',
                        style: AppStyle.textViewStyleNormalSubtitle2(
                            context: context,
                            color: AppColors.colorBlack,
                            fontWeightDelta: 0,
                            fontSizeDelta: -1),
                      ),
                    ),
                    Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(
                          right: AppDimens.dimens_10,
                          top: AppDimens.dimens_5,
                          left: AppDimens.dimens_10),
                      decoration: AppViews.getRoundBorder(
                          cBoxBgColor: AppColors.colorWhite,
                          cBorderColor: AppColors.colorBorder2,
                          dRadius: AppDimens.dimens_5,
                          dBorderWidth: AppDimens.dimens_1),
                      child: DropdownButton(
                        isExpanded: true,
                        underline: Container(),
                        value: selectAccount,
                        items: accounts.map((CardModel card) {
                          return DropdownMenuItem<CardModel>(
                            value: card,
                            child: Text(
                              '**** **** **** ${card.last4}',
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                        onChanged: (CardModel? value) {
                          selectAccount = value!;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: AppDimens.dimens_20),
                child: CustomButton(
                  width: AppDimens.dimens_200,
                  height: AppDimens.dimens_40,
                  onPressed: () {
                    if (isValid()) {
                      widget.onTap(
                          selectAccount.id, int.parse(controllerAmount.text));

                      Navigator.of(context).pop(true);
                    }
                  },
                  isGradient: true,
                  fontColor: AppColors.colorWhite,
                  strTitle: Constants.TXT_ADD_MONEY,
                ),
                padding: const EdgeInsets.only(
                    left: AppDimens.dimens_10, right: AppDimens.dimens_10),
              ),
            ],
          ),
        ),
      ),
    );
  }

  isValid() {
    String strBankName = controllerAmount.text.toString();

    if (!Global.checkNull(strBankName)) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_ENTER_BANK_NAME,
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusAmount);
      return false;
    }
    return true;
  }
}

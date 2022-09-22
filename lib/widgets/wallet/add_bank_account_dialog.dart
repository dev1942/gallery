import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:otobucks/custom_ui/bottom_sheet.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/model/Add_bank_account_model.dart';
import 'package:otobucks/model/country_code.dart';
import 'package:otobucks/widgets/country_code_bottomsheet.dart';

import '../../global/app_colors.dart';
import '../../global/app_dimens.dart';
import '../../global/app_style.dart';
import '../../global/enum.dart';
import '../../global/global.dart';
import '../custom_button.dart';
import '../custom_textfield_with_icon.dart';

class AddBankAccountDialogBox extends StatefulWidget {
  final Function onTap;

  const AddBankAccountDialogBox({Key? key, required this.onTap})
      : super(key: key);

  @override
  _AddBankAccountDialogBoxState createState() =>
      _AddBankAccountDialogBoxState();
}

class _AddBankAccountDialogBoxState extends State<AddBankAccountDialogBox> {
  TextEditingController controllerBankName = TextEditingController();
  TextEditingController controllerAccHolderName = TextEditingController();
  TextEditingController controllerAccHolderType = TextEditingController();
  TextEditingController controllerAccNumber = TextEditingController();
  TextEditingController controllerIbanNumber = TextEditingController();
  TextEditingController controllerSwiftCode = TextEditingController();
  TextEditingController controllerBranchName = TextEditingController();
  TextEditingController controllerRoutingNumber = TextEditingController();
  TextEditingController controllerCountry = TextEditingController();
  TextEditingController controllerCurrency = TextEditingController();

  FocusNode mFocusNodeBankName = FocusNode();
  FocusNode mFocusNodeAccHolderName = FocusNode();
  FocusNode mFocusNodeAccNumber = FocusNode();
  FocusNode mFocusNodeIbanNumber = FocusNode();
  FocusNode mFocusNodeSwiftCode = FocusNode();
  FocusNode mFocusNodeBranchName = FocusNode();
  FocusNode mFocusNodeRoutingNumber = FocusNode();
  FocusNode mFocusNodeAccountHolderType = FocusNode();
  FocusNode mFocusNodeCountry = FocusNode();
  FocusNode mFocusNodeHolderType = FocusNode();

  List<String> currencies = [
    'INR',
    "USD",
    "EUR",
    "CAD",
    "GBP",
    "DEM",
    "FRF",
    "JPY",
    "NLG",
    "ITL",
    "CHF",
    "DZD",
    "ATS",
    "CNY",
    "MXP",
    "RUR",
    "PKR",
  ];

  var selectCurrency = 'USD';

  String strCountyFlag = 'ae';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
      child: Container(
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
                          Constants.TXT_ADD_NEW_BANK,
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
                      Container(
                        margin: const EdgeInsets.only(left: AppDimens.dimens_5),
                        child: Text(
                          Constants.TXT_BANK_NAME,
                          style: AppStyle.textViewStyleNormalSubtitle2(
                              context: context,
                              color: AppColors.colorBlack,
                              fontWeightDelta: 0,
                              fontSizeDelta: -1),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(
                            right: AppDimens.dimens_5,
                            top: AppDimens.dimens_5,
                            left: AppDimens.dimens_5),
                        decoration: AppViews.getRoundBorder(
                            cBoxBgColor: AppColors.colorWhite,
                            cBorderColor: AppColors.colorBorder2,
                            dRadius: AppDimens.dimens_5,
                            dBorderWidth: AppDimens.dimens_1),
                        child: Container(
                            margin:
                                const EdgeInsets.only(top: AppDimens.dimens_5),
                            child: CustomTextFieldWithIcon(
                              height: AppDimens.dimens_36,
                              textInputAction: TextInputAction.next,
                              enabled: true,
                              focusNode: mFocusNodeBankName,
                              controller: controllerBankName,
                              keyboardType: TextInputType.text,
                              hintText: Constants.TXT_BANK_NAME_HINT,
                              inputFormatters: const [],
                              autofillHints: const <String>[
                                AutofillHints.creditCardName
                              ],
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(mFocusNodeAccHolderName);
                              },
                              obscureText: false,
                              onChanged: (String value) {},
                            )),
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
                        margin: const EdgeInsets.only(left: AppDimens.dimens_5),
                        child: Text(
                          Constants.TXT_ACCOUNT_HOLDER_NAME,
                          style: AppStyle.textViewStyleNormalSubtitle2(
                              context: context,
                              color: AppColors.colorBlack,
                              fontWeightDelta: 0,
                              fontSizeDelta: -1),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(
                            right: AppDimens.dimens_5,
                            top: AppDimens.dimens_5,
                            left: AppDimens.dimens_5),
                        decoration: AppViews.getRoundBorder(
                            cBoxBgColor: AppColors.colorWhite,
                            cBorderColor: AppColors.colorBorder2,
                            dRadius: AppDimens.dimens_5,
                            dBorderWidth: AppDimens.dimens_1),
                        child: Container(
                            margin:
                                const EdgeInsets.only(top: AppDimens.dimens_5),
                            child: CustomTextFieldWithIcon(
                              height: AppDimens.dimens_36,
                              textInputAction: TextInputAction.next,
                              enabled: true,
                              focusNode: mFocusNodeAccHolderName,
                              controller: controllerAccHolderName,
                              keyboardType: TextInputType.text,
                              hintText: Constants.TXT_ACCOUNT_HOLDER_NAME_HINT,
                              inputFormatters: const [],
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(mFocusNodeAccNumber);
                              },
                              obscureText: false,
                              onChanged: (String value) {},
                            )),
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
                        margin: const EdgeInsets.only(left: AppDimens.dimens_5),
                        child: Text(
                          Constants.TXT_ACCOUNT_NUMBER,
                          style: AppStyle.textViewStyleNormalSubtitle2(
                              context: context,
                              color: AppColors.colorBlack,
                              fontWeightDelta: 0,
                              fontSizeDelta: -1),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(
                            right: AppDimens.dimens_5,
                            top: AppDimens.dimens_5,
                            left: AppDimens.dimens_5),
                        decoration: AppViews.getRoundBorder(
                            cBoxBgColor: AppColors.colorWhite,
                            cBorderColor: AppColors.colorBorder2,
                            dRadius: AppDimens.dimens_5,
                            dBorderWidth: AppDimens.dimens_1),
                        child: Container(
                            margin:
                                const EdgeInsets.only(top: AppDimens.dimens_5),
                            child: CustomTextFieldWithIcon(
                              height: AppDimens.dimens_36,
                              textInputAction: TextInputAction.next,
                              enabled: true,
                              focusNode: mFocusNodeAccNumber,
                              controller: controllerAccNumber,
                              keyboardType: TextInputType.phone,
                              hintText: Constants.TXT_ACCOUNT_NUMBER,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(mFocusNodeIbanNumber);
                              },
                              obscureText: false,
                              onChanged: (String value) {},
                            )),
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
                        margin: const EdgeInsets.only(left: AppDimens.dimens_5),
                        child: Text(
                          Constants.TXT_ROUTING,
                          style: AppStyle.textViewStyleNormalSubtitle2(
                              context: context,
                              color: AppColors.colorBlack,
                              fontWeightDelta: 0,
                              fontSizeDelta: -1),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(
                            right: AppDimens.dimens_5,
                            top: AppDimens.dimens_5,
                            left: AppDimens.dimens_5),
                        decoration: AppViews.getRoundBorder(
                            cBoxBgColor: AppColors.colorWhite,
                            cBorderColor: AppColors.colorBorder2,
                            dRadius: AppDimens.dimens_5,
                            dBorderWidth: AppDimens.dimens_1),
                        child: Container(
                            margin:
                                const EdgeInsets.only(top: AppDimens.dimens_5),
                            child: CustomTextFieldWithIcon(
                              height: AppDimens.dimens_36,
                              textInputAction: TextInputAction.next,
                              enabled: true,
                              focusNode: mFocusNodeRoutingNumber,
                              controller: controllerRoutingNumber,
                              keyboardType: TextInputType.phone,
                              hintText: Constants.TXT_ROUTING_HINT,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(mFocusNodeRoutingNumber);
                              },
                              obscureText: false,
                              onChanged: (String value) {},
                            )),
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
                        margin: const EdgeInsets.only(left: AppDimens.dimens_5),
                        child: Text(
                          Constants.TXT_ACCOUNT_TYPE,
                          style: AppStyle.textViewStyleNormalSubtitle2(
                              context: context,
                              color: AppColors.colorBlack,
                              fontWeightDelta: 0,
                              fontSizeDelta: -1),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(
                            right: AppDimens.dimens_5,
                            top: AppDimens.dimens_5,
                            left: AppDimens.dimens_5),
                        decoration: AppViews.getRoundBorder(
                            cBoxBgColor: AppColors.colorWhite,
                            cBorderColor: AppColors.colorBorder2,
                            dRadius: AppDimens.dimens_5,
                            dBorderWidth: AppDimens.dimens_1),
                        child: Container(
                            margin:
                                const EdgeInsets.only(top: AppDimens.dimens_5),
                            child: CustomTextFieldWithIcon(
                              height: AppDimens.dimens_36,
                              textInputAction: TextInputAction.next,
                              enabled: true,
                              focusNode: mFocusNodeAccountHolderType,
                              controller: controllerAccHolderType,
                              keyboardType: TextInputType.text,
                              hintText: Constants.TXT_ACCOUNT_TYPE_HINT,
                              inputFormatters: const [],
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(mFocusNodeAccountHolderType);
                              },
                              obscureText: false,
                              onChanged: (String value) {},
                            )),
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
                        margin: const EdgeInsets.only(left: AppDimens.dimens_5),
                        child: Text(
                          Constants.TXT_IBAN_NUMBER,
                          style: AppStyle.textViewStyleNormalSubtitle2(
                              context: context,
                              color: AppColors.colorBlack,
                              fontWeightDelta: 0,
                              fontSizeDelta: -1),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(
                            right: AppDimens.dimens_5,
                            top: AppDimens.dimens_5,
                            left: AppDimens.dimens_5),
                        decoration: AppViews.getRoundBorder(
                            cBoxBgColor: AppColors.colorWhite,
                            cBorderColor: AppColors.colorBorder2,
                            dRadius: AppDimens.dimens_5,
                            dBorderWidth: AppDimens.dimens_1),
                        child: Container(
                            margin:
                                const EdgeInsets.only(top: AppDimens.dimens_5),
                            child: CustomTextFieldWithIcon(
                              height: AppDimens.dimens_36,
                              textInputAction: TextInputAction.next,
                              enabled: true,
                              focusNode: mFocusNodeIbanNumber,
                              controller: controllerIbanNumber,
                              keyboardType: TextInputType.text,
                              hintText: Constants.TXT_IBAN_NUMBER,
                              inputFormatters: const [],
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(mFocusNodeSwiftCode);
                              },
                              obscureText: false,
                              onChanged: (String value) {},
                            )),
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
                        margin: const EdgeInsets.only(left: AppDimens.dimens_5),
                        child: Text(
                          Constants.TXT_SWIFT_CODE,
                          style: AppStyle.textViewStyleNormalSubtitle2(
                              context: context,
                              color: AppColors.colorBlack,
                              fontWeightDelta: 0,
                              fontSizeDelta: -1),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(
                            right: AppDimens.dimens_5,
                            top: AppDimens.dimens_5,
                            left: AppDimens.dimens_5),
                        decoration: AppViews.getRoundBorder(
                            cBoxBgColor: AppColors.colorWhite,
                            cBorderColor: AppColors.colorBorder2,
                            dRadius: AppDimens.dimens_5,
                            dBorderWidth: AppDimens.dimens_1),
                        child: Container(
                            margin:
                                const EdgeInsets.only(top: AppDimens.dimens_5),
                            child: CustomTextFieldWithIcon(
                              height: AppDimens.dimens_36,
                              textInputAction: TextInputAction.next,
                              enabled: true,
                              focusNode: mFocusNodeSwiftCode,
                              controller: controllerSwiftCode,
                              keyboardType: TextInputType.text,
                              hintText: Constants.TXT_SWIFT_CODE_HINT,
                              inputFormatters: const [],
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(mFocusNodeBranchName);
                              },
                              obscureText: false,
                              onChanged: (String value) {},
                            )),
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
                        margin: const EdgeInsets.only(left: AppDimens.dimens_5),
                        child: Text(
                          'Currency',
                          style: AppStyle.textViewStyleNormalSubtitle2(
                              context: context,
                              color: AppColors.colorBlack,
                              fontWeightDelta: 0,
                              fontSizeDelta: -1),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(
                            right: AppDimens.dimens_5,
                            top: AppDimens.dimens_5,
                            left: AppDimens.dimens_5),
                        decoration: AppViews.getRoundBorder(
                            cBoxBgColor: AppColors.colorWhite,
                            cBorderColor: AppColors.colorBorder2,
                            dRadius: AppDimens.dimens_5,
                            dBorderWidth: AppDimens.dimens_1),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          height: 40,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(),
                          child: DropdownButton(
                            isExpanded: true,
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
                        ),
                      ),
                    ],
                  ),
                ),
                getCountryTextFiled(),
                Container(
                  margin: const EdgeInsets.only(top: AppDimens.dimens_10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: AppDimens.dimens_5),
                        child: Text(
                          Constants.TXT_BRANCH_NAME,
                          style: AppStyle.textViewStyleNormalSubtitle2(
                              context: context,
                              color: AppColors.colorBlack,
                              fontWeightDelta: 0,
                              fontSizeDelta: -1),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(
                            right: AppDimens.dimens_5,
                            top: AppDimens.dimens_5,
                            left: AppDimens.dimens_5),
                        decoration: AppViews.getRoundBorder(
                            cBoxBgColor: AppColors.colorWhite,
                            cBorderColor: AppColors.colorBorder2,
                            dRadius: AppDimens.dimens_5,
                            dBorderWidth: AppDimens.dimens_1),
                        child: Container(
                            margin:
                                const EdgeInsets.only(top: AppDimens.dimens_5),
                            child: CustomTextFieldWithIcon(
                              height: AppDimens.dimens_36,
                              textInputAction: TextInputAction.done,
                              enabled: true,
                              focusNode: mFocusNodeBranchName,
                              controller: controllerBranchName,
                              keyboardType: TextInputType.text,
                              hintText: Constants.TXT_BRANCH_NAME_HINT,
                              inputFormatters: const [],
                              obscureText: false,
                              onChanged: (String value) {},
                            )),
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
                        AddBankAccountModel bankAccountModel =
                            AddBankAccountModel(
                                ibanNumber: controllerIbanNumber.text,
                                accHolderName: controllerAccHolderName.text,
                                accHolderType: controllerAccHolderType.text,
                                accountNumber: controllerAccNumber.text,
                                bankName: controllerBankName.text,
                                branchName: controllerBranchName.text,
                                country: controllerCountry.text,
                                currency: selectCurrency,
                                routingNumber: controllerRoutingNumber.text,
                                swiftCode: controllerSwiftCode.text);
                        Navigator.of(context).pop(true);
                        widget.onTap(bankAccountModel);
                      }
                    },
                    isGradient: true,
                    fontColor: AppColors.colorWhite,
                    strTitle: Constants.TXT_SAVE,
                  ),
                  padding: const EdgeInsets.only(
                      left: AppDimens.dimens_10, right: AppDimens.dimens_10),
                ),
              ],
            ),
          )),
    );
  }

  Widget getCountryTextFiled() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10, left: AppDimens.dimens_5),
          child: Text(
            Constants.STR_COUNTRY,
            style: AppStyle.textViewStyleNormalSubtitle2(
                context: context,
                color: AppColors.colorBlack,
                fontWeightDelta: 0,
                fontSizeDelta: -1),
          ),
        ),
        Container(
          decoration: AppViews.getRoundBorder(
              cBoxBgColor: AppColors.colorWhite,
              cBorderColor: AppColors.colorBorder2,
              dRadius: AppDimens.dimens_5,
              dBorderWidth: AppDimens.dimens_1),
          margin: const EdgeInsets.only(
              top: AppDimens.dimens_10, left: 6, right: 6),
          child: InkWell(
            child: CustomTextFieldWithIcon(
              height: AppDimens.dimens_40,
              textInputAction: TextInputAction.next,
              enabled: false,
              focusNode: mFocusNodeCountry,
              controller: controllerCountry,
              keyboardType: TextInputType.text,
              hintText: 'Country'.tr,
              inputFormatters: const [],
              obscureText: false,
              onChanged: (String value) {},
              prefixIcon: SizedBox(
                height: AppDimens.dimens_30,
                width: AppDimens.dimens_30,
                child: CircleAvatar(
                    child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppDimens.dimens_60),
                  child: Image.asset(
                    'assets/images/flag_' + strCountyFlag + '.png',
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
                    return CustomBottomSheet(child: CountryCodeBottomSheet(
                      onTap: (CountryCode mCountryCode) {
                        controllerCountry.text =
                            mCountryCode.code.toUpperCase();
                        strCountyFlag = mCountryCode.code.toLowerCase();
                        setState(() {});
                      },
                    ));
                  });
            },
          ),
        ),
      ],
    );
  }

  isValid() {
    String strBankName = controllerBankName.text.toString();
    String strAccHolderName = controllerAccHolderName.text.toString();
    String strAccNumber = controllerAccNumber.text.toString();
    String strIbanNumber = controllerIbanNumber.text.toString();
    String strSwiftCode = controllerSwiftCode.text.toString();
    String strBranchName = controllerBranchName.text.toString();
    String strRouting = controllerRoutingNumber.text.toString();
    String strAccType = controllerAccHolderType.text.toString();
    String strCountry = controllerCountry.text.toString();

    if (!Global.checkNull(strBankName)) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_ENTER_BANK_NAME,
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeBankName);
      return false;
    } else if (!Global.checkNull(strAccHolderName)) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_ENTER_AC_HOLDER_NAME,
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeAccHolderName);
      return false;
    } else if (!Global.checkNull(strAccNumber)) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_ENTER_AC_NUMBER,
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeAccNumber);
      return false;
    } else if (!Global.checkNull(strIbanNumber)) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_ENTER_IBAN_NUMBER,
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeIbanNumber);
      return false;
    } else if (!Global.checkNull(strSwiftCode)) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_ENTER_SWIFT_CODE,
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeSwiftCode);
      return false;
    } else if (!Global.checkNull(strBranchName)) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_ENTER_BARNCH_NAME,
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeBranchName);
      return false;
    } else if (!Global.checkNull(strAccType)) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: "please enter account type",
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeAccountHolderType);
      return false;
    } else if (!Global.checkNull(strCountry)) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: "Please select country",
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeCountry);
      return false;
    } else if (!Global.checkNull(strRouting)) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_ENTER_BARNCH_NAME,
          toastType: TOAST_TYPE.toastError);
      FocusScope.of(context).requestFocus(mFocusNodeRoutingNumber);
      return false;
    }
    return true;
  }
}

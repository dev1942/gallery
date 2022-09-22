import 'package:flutter/material.dart';
import 'package:otobucks/global/global.dart';

import '../../global/app_colors.dart';
import '../../global/app_dimens.dart';
import '../../global/app_style.dart';
import '../../global/app_views.dart';
import '../../global/constants.dart';
import '../../widgets/custom_textfield_with_icon.dart';
import 'flutter_credit_card.dart';

class CreditCardForm extends StatefulWidget {
  const CreditCardForm({
    Key? key,
    required this.cardNumber,
    required this.expiryDate,
    required this.cardHolderName,
    required this.cvvCode,
    this.obscureCvv = false,
    this.obscureNumber = false,
    required this.onCreditCardModelChange,
    required this.formKey,
    this.cvvValidationMessage = 'Please input a valid CVV',
    this.dateValidationMessage = 'Please input a valid date',
    this.numberValidationMessage = 'Please input a valid number',
    this.isHolderNameVisible = true,
    this.isCardNumberVisible = true,
    this.isExpiryDateVisible = true,
  }) : super(key: key);

  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  final String cvvValidationMessage;
  final String dateValidationMessage;
  final String numberValidationMessage;
  final void Function(CreditCardModel) onCreditCardModelChange;

  final bool obscureCvv;
  final bool obscureNumber;
  final bool isHolderNameVisible;
  final bool isCardNumberVisible;
  final bool isExpiryDateVisible;
  final GlobalKey<FormState> formKey;

  @override
  _CreditCardFormState createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  late String cardNumber;
  late String expiryDate;
  late String cardHolderName;
  late String cvvCode;
  bool isCvvFocused = false;
  late Color themeColor;

  late void Function(CreditCardModel) onCreditCardModelChange;
  late CreditCardModel creditCardModel;

  final MaskedTextController _cardNumberController =
      MaskedTextController(mask: '0000 0000 0000 0000');
  final TextEditingController _expiryDateController =
      MaskedTextController(mask: '00/00');
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _cvvCodeController =
      MaskedTextController(mask: '0000');

  FocusNode cvvFocusNode = FocusNode();
  FocusNode expiryDateNode = FocusNode();
  FocusNode cardNumberNode = FocusNode();
  FocusNode cardHolderNode = FocusNode();

  void textFieldFocusDidChange() {
    creditCardModel.isCvvFocused = cvvFocusNode.hasFocus;
    onCreditCardModelChange(creditCardModel);
  }

  void createCreditCardModel() {
    cardNumber = widget.cardNumber;
    expiryDate = widget.expiryDate;
    cardHolderName = widget.cardHolderName;
    cvvCode = widget.cvvCode;
    if (Global.checkNull(widget.cardNumber)) {
      _cardNumberController.text = widget.cardNumber;
    }
    if (Global.checkNull(widget.expiryDate)) {
      _expiryDateController.text = widget.expiryDate;
    }
    if (Global.checkNull(widget.cardHolderName)) {
      _cardHolderNameController.text = widget.cardHolderName;
    }
    if (Global.checkNull(widget.cvvCode)) {
      _cvvCodeController.text = widget.cvvCode;
    }

    creditCardModel = CreditCardModel(
        cardNumber, expiryDate, cardHolderName, cvvCode, isCvvFocused);
  }

  @override
  void initState() {
    super.initState();

    createCreditCardModel();

    onCreditCardModelChange = widget.onCreditCardModelChange;

    cvvFocusNode.addListener(textFieldFocusDidChange);

    _cardNumberController.addListener(() {
      setState(() {
        cardNumber = _cardNumberController.text;
        creditCardModel.cardNumber = cardNumber;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _expiryDateController.addListener(() {
      setState(() {
        expiryDate = _expiryDateController.text;
        creditCardModel.expiryDate = expiryDate;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _cardHolderNameController.addListener(() {
      setState(() {
        cardHolderName = _cardHolderNameController.text;
        creditCardModel.cardHolderName = cardHolderName;
        onCreditCardModelChange(creditCardModel);
      });
    });

    _cvvCodeController.addListener(() {
      setState(() {
        cvvCode = _cvvCodeController.text;
        creditCardModel.cvvCode = cvvCode;
        onCreditCardModelChange(creditCardModel);
      });
    });
  }

  @override
  void dispose() {
    cardHolderNode.dispose();
    cvvFocusNode.dispose();
    cardNumberNode.dispose();
    expiryDateNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: <Widget>[
          Visibility(
              visible: widget.isHolderNameVisible,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: AppDimens.dimens_5),
                    child: Text(
                      Constants.TXT_CARD_HOLDER_NAME,
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
                        margin: const EdgeInsets.only(top: AppDimens.dimens_5),
                        child: CustomTextFieldWithIcon(
                          height: AppDimens.dimens_36,
                          textInputAction: TextInputAction.next,
                          enabled: true,
                          focusNode: cardHolderNode,
                          controller: _cardHolderNameController,
                          keyboardType: TextInputType.text,
                          hintText: Constants.TXT_CARD_HOLDER_NAME,
                          inputFormatters: const [],
                          autofillHints: const <String>[
                            AutofillHints.creditCardName
                          ],
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(cardNumberNode);
                          },
                          obscureText: false,
                          onChanged: (String value) {},
                        )),
                  ),
                ],
              )),
          Visibility(
              visible: widget.isHolderNameVisible,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: AppDimens.dimens_5, top: AppDimens.dimens_20),
                    child: Text(
                      Constants.TXT_CARD_NUMBER,
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
                        margin: const EdgeInsets.only(top: AppDimens.dimens_5),
                        height: AppDimens.dimens_36,
                        child: TextFormField(
                          obscureText: widget.obscureNumber,
                          controller: _cardNumberController,
                          focusNode: cardNumberNode,
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(expiryDateNode);
                          },
                          style: AppStyle.textViewStyleNormalBodyText2(
                              color: AppColors.colorBlack,
                              fontSizeDelta: 0,
                              fontWeightDelta: 0,
                              context: context),
                          decoration: InputDecoration(
                            counter: const SizedBox(
                              height: 0,
                              width: 0,
                            ),
                            counterText: "",
                            errorStyle: AppStyle.textViewStyleXSmall(
                                context: context,
                                color: AppColors.colorRED,
                                fontSizeDelta: -3),
                            contentPadding: const EdgeInsets.only(
                                top: AppDimens.dimens_7,
                                left: AppDimens.dimens_15),
                            focusedBorder: AppViews.textFieldRoundBorder(),
                            border: AppViews.textFieldRoundBorder(),
                            disabledBorder: AppViews.textFieldRoundBorder(),
                            focusedErrorBorder: AppViews.textFieldRoundBorder(),
                            hintText: Constants.TXT_CARD_NUMBER,
                            filled: true,
                            fillColor: AppColors.colorWhite,
                            hintStyle: AppStyle.textViewStyleNormalBodyText2(
                                color: AppColors.colorTextFieldHint,
                                fontSizeDelta: 0,
                                fontWeightDelta: 0,
                                context: context),
                          ),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          autofillHints: const <String>[
                            AutofillHints.creditCardNumber
                          ],
                          validator: (String? value) {
                            // Validate less that 13 digits +3 white spaces
                            if (value!.isEmpty ||
                                value.replaceAll(" ", "").length < 16) {
                              return widget.numberValidationMessage;
                            }
                            return null;
                          },
                        )),
                  ),
                ],
              )),
          Row(
            children: <Widget>[
              Visibility(
                visible: widget.isExpiryDateVisible,
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            left: AppDimens.dimens_5, top: AppDimens.dimens_20),
                        child: Text(
                          Constants.TXT_EXPIRY_DATE,
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
                            height: AppDimens.dimens_36,
                            child: TextFormField(
                              controller: _expiryDateController,
                              focusNode: expiryDateNode,
                              onEditingComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(cvvFocusNode);
                              },
                              style: AppStyle.textViewStyleNormalBodyText2(
                                  color: AppColors.colorBlack,
                                  fontSizeDelta: 0,
                                  fontWeightDelta: 0,
                                  context: context),
                              decoration: InputDecoration(
                                prefixIconConstraints: const BoxConstraints(
                                    minWidth: AppDimens.dimens_33),
                                suffixIconConstraints: const BoxConstraints(
                                    minWidth: AppDimens.dimens_33),
                                contentPadding: const EdgeInsets.only(
                                    top: AppDimens.dimens_7,
                                    left: AppDimens.dimens_15),
                                focusedBorder: AppViews.textFieldRoundBorder(),
                                border: AppViews.textFieldRoundBorder(),
                                disabledBorder: AppViews.textFieldRoundBorder(),
                                focusedErrorBorder:
                                    AppViews.textFieldRoundBorder(),
                                errorStyle: AppStyle.textViewStyleXSmall(
                                    context: context,
                                    color: AppColors.colorRED,
                                    fontSizeDelta: -3),
                                hintText: "MM/YY",
                                filled: true,
                                fillColor: AppColors.colorWhite,
                                hintStyle:
                                    AppStyle.textViewStyleNormalBodyText2(
                                        color: AppColors.colorTextFieldHint,
                                        fontSizeDelta: 0,
                                        fontWeightDelta: 0,
                                        context: context),
                              ),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              autofillHints: const <String>[
                                AutofillHints.creditCardExpirationDate
                              ],
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return widget.dateValidationMessage;
                                }
                                final DateTime now = DateTime.now();
                                final List<String> date =
                                    value.split(RegExp(r'/'));
                                final int month = int.parse(date.first);
                                final int year = int.parse('20${date.last}');
                                final DateTime cardDate = DateTime(year, month);

                                if (cardDate.isBefore(now) ||
                                    month > 12 ||
                                    month == 0) {
                                  return widget.dateValidationMessage;
                                }
                                return null;
                              },
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: AppDimens.dimens_5, top: AppDimens.dimens_20),
                      child: Text(
                        Constants.TXT_CVV,
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
                          height: AppDimens.dimens_36,
                          child: TextFormField(
                            obscureText: widget.obscureCvv,
                            maxLength: 3,
                            focusNode: cvvFocusNode,
                            controller: _cvvCodeController,
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                              onCreditCardModelChange(creditCardModel);
                            },
                            style: AppStyle.textViewStyleNormalBodyText2(
                                color: AppColors.colorBlack,
                                fontSizeDelta: 0,
                                fontWeightDelta: 0,
                                context: context),
                            decoration: InputDecoration(
                              prefixIconConstraints: const BoxConstraints(
                                  minWidth: AppDimens.dimens_33),
                              counter: const SizedBox(
                                height: 0,
                                width: 0,
                              ),
                              counterText: "",
                              suffixIconConstraints: const BoxConstraints(
                                  minWidth: AppDimens.dimens_33),
                              contentPadding: const EdgeInsets.only(
                                  top: AppDimens.dimens_7,
                                  left: AppDimens.dimens_15),
                              focusedBorder: AppViews.textFieldRoundBorder(),
                              border: AppViews.textFieldRoundBorder(),
                              disabledBorder: AppViews.textFieldRoundBorder(),
                              focusedErrorBorder:
                                  AppViews.textFieldRoundBorder(),
                              hintText: Constants.TXT_CVV,
                              filled: true,
                              fillColor: AppColors.colorWhite,
                              hintStyle: AppStyle.textViewStyleNormalBodyText2(
                                  color: AppColors.colorTextFieldHint,
                                  fontSizeDelta: 0,
                                  fontWeightDelta: 0,
                                  context: context),
                            ),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            autofillHints: const <String>[
                              AutofillHints.creditCardSecurityCode
                            ],
                            onChanged: (String text) {
                              setState(() {
                                cvvCode = text;
                              });
                            },
                            validator: (String? value) {
                              if (value!.isEmpty || value.length < 3) {
                                return widget.cvvValidationMessage;
                              }
                              return null;
                            },
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

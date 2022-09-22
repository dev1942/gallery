import 'package:flutter/material.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/constants.dart';

import '../../custom_ui/card/credit_card_form.dart';
import '../../custom_ui/card/credit_card_model.dart';
import '../../global/app_colors.dart';
import '../../global/app_dimens.dart';
import '../../global/app_style.dart';
import '../../global/enum.dart';
import '../../global/global.dart';
import '../../model/card_model.dart';
import '../custom_button.dart';

class AddEditCardDialogBox extends StatefulWidget {
  final Function onTap;
  final CardModel? mCardModel;

  const AddEditCardDialogBox({Key? key, required this.onTap, this.mCardModel})
      : super(key: key);

  @override
  _AddEditCardDialogBoxState createState() => _AddEditCardDialogBoxState();
}

class _AddEditCardDialogBoxState extends State<AddEditCardDialogBox> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  @override
  void initState() {
    if (widget.mCardModel != null) {
      cardNumber = widget.mCardModel!.last4;
      expiryDate =
          '${widget.mCardModel!.expMonth}/${widget.mCardModel!.expYear}';
      cardHolderName = widget.mCardModel!.name;
      cvvCode = '';
    }
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                    widget.mCardModel != null
                        ? Constants.TXT_EDIT_CARD
                        : Constants.TXT_ADD_NEW_CARD,
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
            child: CreditCardForm(
              formKey: formKey,
              obscureCvv: false,
              obscureNumber: false,
              cardNumber: cardNumber,
              cvvCode: cvvCode,
              isHolderNameVisible: true,
              isCardNumberVisible: true,
              isExpiryDateVisible: true,
              cardHolderName: cardHolderName,
              expiryDate: expiryDate,
              onCreditCardModelChange: onCreditCardModelChange,
            ),
            margin: const EdgeInsets.all(AppDimens.dimens_10),
          ),
          Container(
            child: CustomButton(
              width: AppDimens.dimens_200,
              height: AppDimens.dimens_40,
              onPressed: () {
                if (isValid()) {
                  widget.onTap(CardModel(
                      id: 'id',
                      object: 'object',
                      brand: 'brand',
                      country: 'country',
                      customer: 'customer',
                      cvcCheck: cvvCode,
                      expMonth: int.parse(expiryDate.split('/')[0]),
                      expYear: int.parse(expiryDate.split('/')[1]) + 2000,
                      fingerprint: 'fingerprint',
                      last4: cardNumber,
                      name: cardHolderName));
                  // log(expiryDate);
                  Navigator.of(context).pop(true);
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
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  isValid() {
    if (!Global.checkNull(cardHolderName)) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_ENTER_CARD_HOLDER_NAME,
          toastType: TOAST_TYPE.toastError);

      return false;
    } else if (!Global.checkNull(cardNumber)) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_ENTER_CARD_NUMBER,
          toastType: TOAST_TYPE.toastError);

      return false;
    } else if (Global.checkNull(cardNumber) &&
        cardNumber.replaceAll(" ", "").length < 16) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_ENTER_VALID_CARD_NUMBER,
          toastType: TOAST_TYPE.toastError);

      return false;
    } else if (!Global.checkNull(expiryDate)) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_ENTER_CARD_EXPIRY,
          toastType: TOAST_TYPE.toastError);

      return false;
    } else if (!Global.checkNull(cvvCode)) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_ENTER_CARD_CVV,
          toastType: TOAST_TYPE.toastError);

      return false;
    } else if (Global.checkNull(cvvCode) && cvvCode.length < 3) {
      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: AppAlert.ALERT_ENTER_VALID_CVV,
          toastType: TOAST_TYPE.toastError);

      return false;
    }
    return true;
  }
}

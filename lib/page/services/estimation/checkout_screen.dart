import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/controllers/estimation_sidebar_controllers/estimation_checkout.dart';
import 'package:otobucks/custom_ui/card/simple_card.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/global/text_styles.dart';

import '../../../../global/app_colors.dart';
import '../../../../global/app_dimens.dart';
import '../../../../global/app_style.dart';
import '../../../../global/app_views.dart';
import '../../../../global/constants.dart';
import '../../../custom_ui/carousel_slider/carousel_slider.dart';
import '../../../model/card_model.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/wallet/add_card_dialog.dart';

class CheckoutScreen extends StatefulWidget {
  final String estimateId;
  final String sourceId;
  final String paymentStatus;
  const CheckoutScreen(
      {Key? key,
      required this.estimateId,
      required this.sourceId,
      required this.paymentStatus})
      : super(key: key);

  @override
  CheckoutScreenState createState() => CheckoutScreenState();
}

class CheckoutScreenState extends State<CheckoutScreen> {
  var controller = Get.put(EstCheckOutController());
  @override
  void initState() {
    controller.getCardsMine();
    super.initState();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppViews.initAppBar(
        mContext: context,
        centerTitle: false,
        strTitle: Constants.TXT_CHECKOUT,
        isShowNotification: false,
        isShowSOS: false,
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.getMainBgColor(),
      body: Stack(
        children: [
          Container(
            color: AppColors.colorBlueStart,
            height: AppDimens.dimens_120,
          ),
          GetBuilder<EstCheckOutController>(
              init: EstCheckOutController(),
              builder: (value) {
                return AppViews.getSetData(
                    context,
                    value.mShowData,
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          // profile pic and name
                          Container(
                              margin: const EdgeInsets.only(
                                  right: AppDimens.dimens_40,
                                  top: AppDimens.dimens_20),
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                child: Text("+" + Constants.TXT_ADD_NEW_CARD,
                                    style: AppStyle.textViewStyleSmall(
                                        context: context,
                                        color: AppColors.colorWhite,
                                        fontWeightDelta: 0,
                                        fontSizeDelta: -2)),
                                onTap: () {
                                  _displayAddCard();
                                },
                              )),
                          Container(
                              margin: const EdgeInsets.only(
                                  left: AppDimens.dimens_10,
                                  top: AppDimens.dimens_10),
                              child: Column(children: [
                                CarouselSlider(
                                  options: CarouselOptions(
                                      autoPlay: false,
                                      enlargeCenterPage: true,
                                      enableInfiniteScroll: false,
                                      height: 200,
                                      onPageChanged: (index, reason) =>
                                          value.onPageChange(index)),
                                  items: List.generate(value.alCardModel.length,
                                      (index) {
                                    CardModel mCardModel =
                                        value.alCardModel[index];
                                    return SimpleCard(
                                      onTap: () {
                                        value.deletecard(mCardModel.id);
                                      },
                                      lastNumber: mCardModel.last4,
                                      holderName: mCardModel.name,
                                      expiryDate:
                                          '${mCardModel.expMonth.toString()}/${mCardModel.expYear.toString().substring(mCardModel.expYear.toString().length - 2)}',
                                      brand: mCardModel.brand,
                                    );
                                  }),
                                  carouselController: value.controller,
                                ),
                              ])),

                          Container(
                              margin: const EdgeInsets.all(AppDimens.dimens_20),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Credit Card Number',
                                        style: lightText(12),
                                      ),
                                      TextField(
                                        controller: value.cardNumber,
                                        enabled: false,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Card Holder Name',
                                        style: lightText(12),
                                      ),
                                      TextField(
                                        controller: value.cardHolderName,
                                        enabled: false,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Expiry Date',
                                                style: lightText(12),
                                              ),
                                              SizedBox(
                                                width: 90,
                                                child: TextField(
                                                  controller: value.expiryDate,
                                                  enabled: false,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                'CVV Check',
                                                style: lightText(12),
                                              ),
                                              SizedBox(
                                                width: 90,
                                                child: TextField(
                                                  controller: value.cvvCode,
                                                  enabled: false,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )),

                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(
                                top: AppDimens.dimens_20,
                                bottom: AppDimens.dimens_20,
                                left: AppDimens.dimens_10,
                                right: AppDimens.dimens_10),
                            child: CustomButton(
                                isGradient: true,
                                isRoundBorder: true,
                                fontColor: AppColors.colorWhite,
                                fontSize: 0,
                                width: size.width / 1.5,
                                onPressed: () {
                                  widget.estimateId == ''
                                      ? Global.inProgressAlert(context)
                                      : value.bookEstimation(
                                          widget.estimateId,
                                          widget.sourceId,
                                          widget.paymentStatus);
                                },
                                strTitle: Constants.TXT_PROCEES_TO_PAY),
                          ),

                          // Expanded(child: Container()),
                        ],
                      ),
                    ));
              })
        ],
      ),
    );
  }

  _displayAddCard() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AddEditCardDialogBox(
            onTap: (CardModel mCardModelInserted) {
              controller.addNewCard(
                  mCardModelInserted.last4,
                  mCardModelInserted.expMonth,
                  mCardModelInserted.expYear,
                  mCardModelInserted.cvcCheck,
                  mCardModelInserted.name);
            },
          );
        });
  }
}

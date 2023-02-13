// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/Wallet/Controllers/wallet_controller.dart';
import 'package:otobucks/View/Wallet/Widgets/add_money_dialog.dart';

import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/text_styles.dart';
import 'package:otobucks/widgets/custom_button.dart';

import '../../../../../../global/app_colors.dart';
import '../../../../../../global/app_dimens.dart';
import '../../../../../../global/app_style.dart';
import '../../../../../../global/app_views.dart';
import '../../../../../../global/constants.dart';
import '../../../../../../global/global.dart';
import '../../../widgets/custom_ui/card/simple_card.dart';
import '../../../widgets/custom_ui/carousel_slider/carousel_slider.dart';
import '../../../widgets/custom_ui/loader/circle.dart';
import '../../CheckOut/Models/card_model.dart';
import '../../Transactions/Models/add_bank_account_model.dart';
import '../Widgets/add_bank_account_dialog.dart';
import '../Widgets/add_card_dialog.dart';
import '../Widgets/delete_card_dialog.dart';
import '../Widgets/withdraw_money_dialog.dart';
import '../Widgets/withdraw_option_dialog.dart';

class WalletFragment extends StatefulWidget {
  const WalletFragment({Key? key}) : super(key: key);

  @override
  WalletFragmentState createState() => WalletFragmentState();
}

class WalletFragmentState extends State<WalletFragment> {
  var controller = Get.put(WalletController());
  @override
  void initState() {
    controller.getAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget widgetM = Container();

    Widget mShowWidget = ListView(
      children: [
        // top view
        // Container(
        //   margin: const EdgeInsets.all(AppDimens.dimens_10),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Expanded(
        //           child: Card(
        //         child: Container(
        //           padding: const EdgeInsets.all(AppDimens.dimens_8),
        //           alignment: Alignment.center,
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               InkWell(
        //                 child: Container(
        //                   alignment: Alignment.bottomRight,
        //                   padding: const EdgeInsets.all(2),
        //                   child: Text("+" + Constants.TXT_ADD_MONEY,
        //                       style: regularText(9)),
        //                 ),
        //                 onTap: () => _displayAddMoney(),
        //               ),
        //               Row(
        //                 crossAxisAlignment: CrossAxisAlignment.center,
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 children: [
        //                   RoundDot(
        //                       mColor: AppColors.colorGreen,
        //                       size: AppDimens.dimens_8),
        //                   Expanded(
        //                     child:
        //                         GetBuilder<WalletController>(builder: (value) {
        //                       return AppViews.getSetDataCustomLoader(
        //                           context,
        //                           value.loadingWalletBalance,
        //                           Container(
        //                             margin: const EdgeInsets.only(
        //                                 left: AppDimens.dimens_4),
        //                             child: Text(
        //                               Global.replaceCurrencySign(
        //                                       value.mWalletModel.currency) +
        //                                   double.parse(
        //                                           value.mWalletModel.balance)
        //                                       .toStringAsFixed(2),
        //                               style:
        //                                   AppStyle.textViewStyleNormalSubtitle2(
        //                                       context: context,
        //                                       color: AppColors.colorGreen,
        //                                       fontSizeDelta: 2,
        //                                       fontWeightDelta: 3),
        //                             ),
        //                           ),
        //                           SpinKitCircle(
        //                             color: AppColors.colorAccent,
        //                             size: AppDimens.dimens_20,
        //                             key: const ValueKey('value'),
        //                           ),
        //                           '0');
        //                     }),
        //                   ),
        //                 ],
        //               ),
        //               Container(
        //                 margin: const EdgeInsets.only(top: AppDimens.dimens_5),
        //                 child: Text(Constants.TXT_TOTAL_WALLET_BALANCE,
        //                     style: AppStyle.textViewStyleSmall(
        //                         context: context,
        //                         color: AppColors.colorBlack,
        //                         fontSizeDelta: -2),),
        //               ),
        //             ],
        //           ),
        //         ),
        //       )),
        //       const SizedBox(width: AppDimens.dimens_5, height: 0),
        //       Expanded(
        //           child: Card(
        //         child: Container(
        //           padding: const EdgeInsets.all(AppDimens.dimens_8),
        //           alignment: Alignment.center,
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               InkWell(
        //                 child: Container(
        //                   alignment: Alignment.bottomRight,
        //                   padding: const EdgeInsets.all(2),
        //                   child: Text('+Earn Money', style: regularText(9)),
        //                 ),
        //                 onTap: () => Get.find<HomeScreenController>()
        //                     .callback(PageType.invite),
        //               ),
        //               Row(
        //                 crossAxisAlignment: CrossAxisAlignment.center,
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 children: [
        //                   RoundDot(
        //                       mColor: AppColors.colorOrange,
        //                       size: AppDimens.dimens_8),
        //                   Expanded(
        //                     child:
        //                         GetBuilder<WalletController>(builder: (value) {
        //                       return AppViews.getSetDataCustomLoader(
        //                           context,
        //                           value.loadingWalletBalance,
        //                           Container(
        //                             margin: const EdgeInsets.only(
        //                                 left: AppDimens.dimens_4),
        //                             child: Text(
        //                               Global.replaceCurrencySign(
        //                                       value.mWalletModel.currency) +
        //                                   value.mWalletModel.earning,
        //                               style:
        //                                   AppStyle.textViewStyleNormalSubtitle2(
        //                                       context: context,
        //                                       color: AppColors.colorOrange,
        //                                       fontSizeDelta: 2,
        //                                       fontWeightDelta: 3),
        //                             ),
        //                           ),
        //                           SpinKitCircle(
        //                             color: AppColors.colorAccent,
        //                             size: AppDimens.dimens_20,
        //                             key: const ValueKey('value'),
        //                           ),
        //                           '0');
        //                     }),
        //                   ),
        //                 ],
        //               ),
        //               Container(
        //                 margin: const EdgeInsets.only(top: AppDimens.dimens_5),
        //                 child: Text(Constants.TXT_TOTAL_EARNINGS,
        //                     style: AppStyle.textViewStyleSmall(
        //                         context: context,
        //                         color: AppColors.colorBlack,
        //                         fontSizeDelta: -2)),
        //               )
        //             ],
        //           ),
        //         ),
        //       )),
        //     ],
        //   ),
        // ),
        // Container(
        //   margin: const EdgeInsets.all(AppDimens.dimens_10),
        //   child: Row(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Expanded(
        //           child: Card(
        //         child: Container(
        //           padding: const EdgeInsets.all(AppDimens.dimens_8),
        //           alignment: Alignment.center,
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               Row(
        //                 crossAxisAlignment: CrossAxisAlignment.center,
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 children: [
        //                   RoundDot(
        //                       mColor: AppColors.colorOrange,
        //                       size: AppDimens.dimens_8),
        //                   Expanded(
        //                     child:
        //                         GetBuilder<WalletController>(builder: (value) {
        //                       return AppViews.getSetDataCustomLoader(
        //                           context,
        //                           value.loadingWalletBalance,
        //                           Container(
        //                             margin: const EdgeInsets.only(
        //                                 left: AppDimens.dimens_4),
        //                             child: Text(
        //                               Global.replaceCurrencySign(
        //                                       value.mWalletModel.currency) +
        //                                   double.parse(value
        //                                           .mWalletModel.totalWithdraw)
        //                                       .toStringAsFixed(2),
        //                               style:
        //                                   AppStyle.textViewStyleNormalSubtitle2(
        //                                       context: context,
        //                                       color: AppColors.colorOrange,
        //                                       fontSizeDelta: 2,
        //                                       fontWeightDelta: 3),
        //                             ),
        //                           ),
        //                           SpinKitCircle(
        //                             color: AppColors.colorAccent,
        //                             size: AppDimens.dimens_20,
        //                             key: const ValueKey('value'),
        //                           ),
        //                           '0');
        //                     }),
        //                   ),
        //                 ],
        //               ),
        //               Container(
        //                 margin: const EdgeInsets.only(top: AppDimens.dimens_5),
        //                 child: Text(Constants.TXT_TOTAL_WITHDRAWALS,
        //                     style: AppStyle.textViewStyleSmall(
        //                         context: context,
        //                         color: AppColors.colorBlack,
        //                         fontSizeDelta: -2)),
        //               )
        //             ],
        //           ),
        //         ),
        //       )),
        //     ],
        //   ),
        // ),
//------------------------------------------------------------------------
        Container(
          margin: const EdgeInsets.only(bottom: AppDimens.dimens_10, top: AppDimens.dimens_10, left: AppDimens.dimens_18, right: AppDimens.dimens_18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    child: Text(
                      "+" + Constants.TXT_ADD_NEW_CARD,
                      style: regularText(14),
                    ),
                    onTap: () {
                      _displayAddCard();
                    },
                  ),
                ),
              )
            ],
          ),
        ),

        GetBuilder<WalletController>(
            init: WalletController(),
            builder: (value) {
              return AppViews.getSetDataCustomLoader(
                  context,
                  value.loadingCards,
                  Container(
                      margin: const EdgeInsets.only(left: AppDimens.dimens_10, top: AppDimens.dimens_10, bottom: 20),
                      child: Column(children: [
                        CarouselSlider(
                          options: CarouselOptions(
                              autoPlay: false,
                              enlargeCenterPage: true,
                              enableInfiniteScroll: false,
                              height: 200,
                              onPageChanged: (index, reason) => {}),
                          items: List.generate(value.alCardModel.length, (index) {
                            CardModel mCardModel = value.alCardModel[index];
                            return SimpleCard(
                              onTap: () {
                                _displayDeleteCard(mCardModel);
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
                  SpinKitCircle(
                    color: AppColors.colorAccent,
                    size: AppDimens.dimens_20,
                    key: const ValueKey('value'),
                  ),
                  '');
            }),

        // divider
        AppViews.addDivider(),
        Container(
          margin: const EdgeInsets.only(left: AppDimens.dimens_20, right: AppDimens.dimens_20, top: AppDimens.dimens_10, bottom: AppDimens.dimens_10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GetBuilder<WalletController>(builder: (value) {
                    return AppViews.getSetDataCustomLoader(
                        context,
                        value.loadingWalletBalance,
                        Text(
                          Global.replaceCurrencySign("USD") + value.mWalletModel.balance,
                          style: AppStyle.textViewStyleNormalSubtitle2(
                              context: context, color: AppColors.colorBlack, fontSizeDelta: 2, fontWeightDelta: 3),
                        ),
                        SpinKitCircle(
                          color: AppColors.colorAccent,
                          size: AppDimens.dimens_20,
                          key: const ValueKey('value'),
                        ),
                        '0');
                  }),
                  Text(Constants.TXT_CURRENT_BALANCE,
                      style: AppStyle.textViewStyleSmall(context: context, color: AppColors.colorBlack, fontSizeDelta: -2))
                ],
              ),
              // 
            ],
          ),
        ),
        AppViews.addDivider(),
        // AppViews.addDivider(),
        // //Withdraw History
        // Container(
        //   alignment: Alignment.centerLeft,
        //   margin: const EdgeInsets.only(
        //       left: AppDimens.dimens_20, top: AppDimens.dimens_20),
        //   child: Text(Constants.TXT_WITHDRAW_HISTORY,
        //       style: AppStyle.textViewStyleSmall(
        //           context: context,
        //           color: AppColors.colorBlack,
        //           fontWeightDelta: 1,
        //           fontSizeDelta: 0)),
        // ),
        // ListView.builder(
        //     padding: const EdgeInsets.all(AppDimens.dimens_13),
        //     shrinkWrap: true,
        //     physics: const NeverScrollableScrollPhysics(),
        //     itemBuilder: (BuildContext contextM, index) {
        //       return Container(
        //         child: Card(
        //           child: Container(
        //             padding: const EdgeInsets.all(AppDimens.dimens_8),
        //             alignment: Alignment.center,
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Container(
        //                   child: Row(
        //                     crossAxisAlignment: CrossAxisAlignment.center,
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       Container(
        //                         child: Text(
        //                           Global.replaceCurrencySign("USD") +
        //                               "3,00,000",
        //                           style: AppStyle.textViewStyleNormalSubtitle2(
        //                               context: context,
        //                               color: AppColors.colorBlack,
        //                               fontSizeDelta: 2,
        //                               fontWeightDelta: 1),
        //                         ),
        //                       ),
        //                       Container(
        //                         child: Text(
        //                           "Panding",
        //                           style: AppStyle.textViewStyleNormalSubtitle2(
        //                               context: context,
        //                               color: AppColors.colorRED,
        //                               fontSizeDelta: 2,
        //                               fontWeightDelta: 0),
        //                         ),
        //                       )
        //                     ],
        //                   ),
        //                 ),
        //                 Container(
        //                   margin:
        //                       const EdgeInsets.only(left: AppDimens.dimens_4),
        //                   alignment: Alignment.centerLeft,
        //                   child: Text("Mastercard",
        //                       style: AppStyle.textViewStyleSmall(
        //                           context: context,
        //                           color: AppColors.grayDashboardText,
        //                           fontWeightDelta: -1,
        //                           fontSizeDelta: -1)),
        //                 ),
        //                 Container(
        //                   margin:
        //                       const EdgeInsets.only(right: AppDimens.dimens_4),
        //                   alignment: Alignment.centerRight,
        //                   child: Text("JAN 4, 2022, 10:04 am",
        //                       style: AppStyle.textViewStyleSmall(
        //                           context: context,
        //                           color: AppColors.grayDashboardText,
        //                           fontWeightDelta: -1,
        //                           fontSizeDelta: -1)),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //         margin: const EdgeInsets.only(bottom: AppDimens.dimens_10),
        //       );
        //     },
        //     itemCount: 5),
        // AppViews.addDivider(),

        // //wallet earning History
        // Container(
        //   alignment: Alignment.centerLeft,
        //   margin: const EdgeInsets.only(
        //       left: AppDimens.dimens_20, top: AppDimens.dimens_20),
        //   child: Text(Constants.TXT_WALLET_EARNING_HISTORY,
        //       style: AppStyle.textViewStyleSmall(
        //           context: context,
        //           color: AppColors.colorBlack,
        //           fontWeightDelta: 1,
        //           fontSizeDelta: 0)),
        // ),
        // ListView.builder(
        //     padding: const EdgeInsets.all(AppDimens.dimens_13),
        //     shrinkWrap: true,
        //     physics: const NeverScrollableScrollPhysics(),
        //     itemBuilder: (BuildContext contextM, index) {
        //       return Container(
        //         child: Card(
        //           child: Container(
        //             padding: const EdgeInsets.all(AppDimens.dimens_8),
        //             alignment: Alignment.center,
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Container(
        //                   child: Row(
        //                     crossAxisAlignment: CrossAxisAlignment.center,
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       Container(
        //                         child: Text(
        //                           "Adam Hughes",
        //                           style: AppStyle.textViewStyleNormalSubtitle2(
        //                               context: context,
        //                               color: AppColors.colorBlack,
        //                               fontSizeDelta: 2,
        //                               fontWeightDelta: 1),
        //                         ),
        //                       ),
        //                       Container(
        //                         child: Text(
        //                           Global.replaceCurrencySign("USD") +
        //                               "3,00,000",
        //                           style: AppStyle.textViewStyleNormalSubtitle2(
        //                               context: context,
        //                               color: AppColors.colorBlack,
        //                               fontSizeDelta: 2,
        //                               fontWeightDelta: 1),
        //                         ),
        //                       )
        //                     ],
        //                   ),
        //                 ),
        //                 Container(
        //                   margin:
        //                       const EdgeInsets.only(left: AppDimens.dimens_4),
        //                   alignment: Alignment.centerLeft,
        //                   child: Text("burnside",
        //                       style: AppStyle.textViewStyleSmall(
        //                           context: context,
        //                           color: AppColors.grayDashboardText,
        //                           fontWeightDelta: -1,
        //                           fontSizeDelta: -2)),
        //                 ),
        //                 Container(
        //                   margin: const EdgeInsets.only(
        //                       left: AppDimens.dimens_4,
        //                       right: AppDimens.dimens_4,
        //                       top: AppDimens.dimens_2,
        //                       bottom: AppDimens.dimens_2),
        //                   alignment: Alignment.centerLeft,
        //                   child: Text(
        //                       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam facilisis, nulla nec bibendum porttitor",
        //                       style: AppStyle.textViewStyleSmall(
        //                           context: context,
        //                           color: AppColors.grayDashboardText,
        //                           fontWeightDelta: -1,
        //                           fontSizeDelta: -2)),
        //                 ),
        //                 Container(
        //                   margin:
        //                       const EdgeInsets.only(right: AppDimens.dimens_4),
        //                   alignment: Alignment.centerRight,
        //                   child: Text("JAN 4, 2022, 10:04 am",
        //                       style: AppStyle.textViewStyleSmall(
        //                           context: context,
        //                           color: AppColors.grayDashboardText,
        //                           fontWeightDelta: -1,
        //                           fontSizeDelta: -1)),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //         margin: const EdgeInsets.only(bottom: AppDimens.dimens_10),
        //       );
        //     },
        //     itemCount: 5),
      ],
    );
    widgetM = mShowWidget;

    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: AppColors.getMainBgColor(),
            body: Stack(
              children: [
                Container(
                  color: AppColors.colorBlueStart,
                  //height: AppDimens.dimens_120,
                  height: 0,
                ),
                // Container(height: size.height, child: widgetM),
                widgetM,
                GetBuilder<WalletController>(builder: (value) {
                  return AppViews.showLoadingWithStatus(value.isShowLoader);
                })
              ],
            )));
  }

  Future<void> withdrawAlert() async {
    Global.inProgressAlert(context);
    return showDialog(
        context: context,
        builder: (context) {
          return OnWithdrawDialogBox(
            onAddAccount: () {
              _displayAddBankAccount();
            },
            onWithdraw: () {
              _displayWithdrawMoney();
            },
          );
        });
  }

  Future<void> _displayAddBankAccount() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AddBankAccountDialogBox(
            onTap: (AddBankAccountModel model) => controller.addBankAccount(model),
          );
        });
  }

  Future<void> _displayWithdrawMoney() async {
    return showDialog(
        context: context,
        builder: (context) {
          return WithdrawMoneyDialogBox(
            title: Constants.TXT_WITHDRAW_MONEY,
            onTap: () {},
          );
        });
  }

  _displayAddCard() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AddEditCardDialogBox(
            onTap: (CardModel mCardModelInserted) {
              controller.addNewCard(mCardModelInserted.last4, mCardModelInserted.expMonth, mCardModelInserted.expYear, mCardModelInserted.cvcCheck,
                  mCardModelInserted.name);
            },
          );
        });
  }

  _displayDeleteCard(CardModel cardModel) async {
    return showDialog(
        context: context,
        builder: (context) {
          return DeleteCardDialogBox(
            onTap: () {
              controller.deletecard(cardModel.id);
            },
          );
        });
  }

  Future<void> _displayAddMoney() async {
    if (controller.alCardModel.isEmpty) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: 'Please Add a card first.', toastType: TOAST_TYPE.toastError);
      return;
    }
    return showDialog(
        context: context,
        builder: (context) {
          return AddMoneyDialogBox(
            onTap: (String id, int amount) {
              controller.addMoney(id, amount);
            },
            accounts: controller.alCardModel,
            balance: controller.mWalletModel.balance,
          );
        });
  }
}

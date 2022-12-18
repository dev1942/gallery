import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/app/locator.dart';
import 'package:otobucks/controllers/home_screen_controller.dart';
import 'package:otobucks/controllers/transaction_controller.dart';
import 'package:otobucks/model/transaction_model.dart';
import 'package:otobucks/viewmodels/main_viewmodel.dart';
import 'package:otobucks/widgets/fade_in_image.dart';
import 'package:otobucks/widgets/gradient_text.dart';
import 'package:stacked/stacked.dart';
import '../../../../global/app_colors.dart';
import '../../../../global/app_dimens.dart';
import '../../../../global/app_style.dart';
import '../../../../global/app_views.dart';
import '../../../../global/global.dart';
import '../page/transaction_detail_screen.dart';
class TransactionHistoryFragment extends StatefulWidget {
  const TransactionHistoryFragment({Key? key}) : super(key: key);
  @override
  TransactionHistoryFragmentState createState() =>
      TransactionHistoryFragmentState();
}
class TransactionHistoryFragmentState
    extends State<TransactionHistoryFragment> {
  var controller = Get.put(TransactionController());

  @override
  void initState() {
    controller.getTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => locator<MainViewModel>(),
      disposeViewModel: false,
      onModelReady: (model) {},
      builder: (context, model, child) {
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
                      height: 0,
                    ),
                    GetBuilder<TransactionController>(
                        init: TransactionController(),
                        builder: (value) {
                          return AppViews.getSetData(
                              context,
                              controller.mShowData,
                              Column(
                                children: [
                                  // profile pic and name
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: AppDimens.dimens_50,
                                        top: AppDimens.dimens_25,
                                        bottom: AppDimens.dimens_32),
                                    alignment: Alignment.center,
                                    color: AppColors.colorBlueStart,
                                    child: Row(
                                      children: [
                                        Container(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                AppDimens.dimens_50),
                                            child: NetworkImageCustom(
                                                image: Get.find<
                                                        HomeScreenController>()
                                                    .image,
                                                fit: BoxFit.fill,
                                                height: AppDimens.dimens_60,
                                                width: AppDimens.dimens_60),
                                          ),
                                          margin: const EdgeInsets.only(
                                              right: AppDimens.dimens_10),
                                        ),
                                        Flexible(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                                alignment: Alignment.centerLeft,
                                                margin: const EdgeInsets.only(
                                                    top: AppDimens.dimens_5,
                                                    bottom: AppDimens.dimens_2),
                                                child: Text(
                                                  Get.find<
                                                          HomeScreenController>()
                                                      .fullName
                                                      .trim()
                                                      .capitalize!,
                                                  style: AppStyle
                                                      .textViewStyleNormalBodyText2(
                                                          context: context,
                                                          color: AppColors
                                                              .colorWhite,
                                                          fontSizeDelta: 0,
                                                          fontWeightDelta: -1),
                                                )),
                                            Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "Car Owner",
                                                  style: AppStyle
                                                      .textViewStyleSmall(
                                                          context: context,
                                                          color: AppColors
                                                              .colorWhite
                                                              .withOpacity(0.7),
                                                          fontSizeDelta: -2,
                                                          fontWeightDelta: 0),
                                                )),
                                          ],
                                        )),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: AppDimens.dimens_30,
                                        left: AppDimens.dimens_7,
                                        right: AppDimens.dimens_7),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: GetBuilder<
                                              TransactionController>(
                                              builder: (context) {
                                                return InkWell(
                                                  onTap: () {
                                                    value.dateRangerPicker();
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        left: 8,right: 8),
                                                    alignment: Alignment
                                                        .centerLeft,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(3),
                                                        border:
                                                        Border.all(
                                                            color: Colors.grey)),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          value.isRangePicked == true
                                                              ? "${value.startDate} to ${value.endDate}":
                                                          "Search by date",
                                                          style: AppStyle
                                                              .textViewStyleSmall(
                                                              context: Get.context!,
                                                              color: AppColors
                                                                  .lightGrey),
                                                        ),
                                                        Icon(Icons.calendar_today,size: AppDimens.dimens_18,color: Colors.yellow.shade700,)
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }
                                          ),
                                        ),
                                        addHorizontalSpace(AppDimens.dimens_8),
                                        Expanded(
                                          child: SizedBox(
                                              height: 30,
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                    suffixIcon: Icon(Icons.title_outlined,size: AppDimens.dimens_18,color: Colors.yellow.shade700,),
                                                    contentPadding:
                                                    EdgeInsets.all(10),
                                                    hintText: "Search by title",
                                                    hintStyle:
                                                    AppStyle.textViewStyleSmall(
                                                        context: context,
                                                        color:
                                                        AppColors.lightGrey),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.grey)),
                                                    focusColor: Colors.yellow,
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors.grey),
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            3))),
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      child: ListView.builder(
                                          padding: const EdgeInsets.all(
                                              AppDimens.dimens_20),
                                          itemBuilder:
                                              (BuildContext contextM, index) {
                                            TransactionModel transaction =
                                                value.transactions[index];

                                            return Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: AppDimens.dimens_14),
                                              color: Colors.transparent,
                                              child: Card(
                                                  elevation: AppDimens.dimens_3,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppDimens.dimens_5),
                                                  ),
                                                  child: InkWell(
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding:
                                                          const EdgeInsets.only(
                                                        right:
                                                            AppDimens.dimens_10,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                              right: AppDimens
                                                                  .dimens_10,
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          AppDimens
                                                                              .dimens_5),
                                                              child: NetworkImageCustom(
                                                                  image: transaction
                                                                              .metadata
                                                                              .provider ==
                                                                          null
                                                                      ? Get.find<HomeScreenController>()
                                                                          .image
                                                                      : transaction
                                                                          .metadata
                                                                          .provider!
                                                                          .image,
                                                                  fit:
                                                                      BoxFit
                                                                          .fill,
                                                                  height: AppDimens
                                                                      .dimens_90,
                                                                  width: AppDimens
                                                                      .dimens_90),
                                                            ),
                                                          ),
                                                          Expanded(
                                                              child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Expanded(
                                                                      child: Container(
                                                                          alignment: Alignment.centerLeft,
                                                                          child: Text(
                                                                            transaction.metadata.provider == null
                                                                                ? Get.find<HomeScreenController>().fullName
                                                                                : transaction.metadata.provider!.firstName + " " + transaction.metadata.provider!.lastName,
                                                                            maxLines:
                                                                                5,
                                                                            style: AppStyle.textViewStyleNormalBodyText2(
                                                                                context: context,
                                                                                color: AppColors.colorYellowShade,
                                                                                fontSizeDelta: 0,
                                                                                fontWeightDelta: 1),
                                                                          )),
                                                                    ),
                                                                    Container(
                                                                        alignment:
                                                                            Alignment
                                                                                .centerLeft,
                                                                        child:
                                                                            GradientText(
                                                                          Global.replaceCurrencySign(transaction.currency) +
                                                                              "" +
                                                                              "${transaction.amount}/-",
                                                                          style: AppStyle.textViewStyleNormalBodyText2(
                                                                              context: context,
                                                                              color: AppColors.grayDashboardText,
                                                                              fontSizeDelta: 2,
                                                                              fontWeightDelta: 3),
                                                                        )),
                                                                  ],
                                                                ),
                                                                margin: const EdgeInsets
                                                                        .only(
                                                                    top: AppDimens
                                                                        .dimens_5,
                                                                    bottom: AppDimens
                                                                        .dimens_2),
                                                              ),
                                                              Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      bottom: AppDimens
                                                                          .dimens_5),
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: Text(
                                                                    transaction.metadata.service ==
                                                                            null
                                                                        ? ''
                                                                        : transaction
                                                                            .metadata
                                                                            .service!
                                                                            .title,
                                                                    maxLines: 1,
                                                                    style: AppStyle.textViewStyleSmall(
                                                                        context:
                                                                            context,
                                                                        color: AppColors
                                                                            .grayDashboardText,
                                                                        fontSizeDelta:
                                                                            -2,
                                                                        fontWeightDelta:
                                                                            0),
                                                                  )),
                                                              Text(transaction.createdAt),
                                                              Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  child: Text(
                                                                    transaction
                                                                        .metadata
                                                                        .type,
                                                                    style: AppStyle.textViewStyleNormalBodyText2(
                                                                        context:
                                                                            context,
                                                                        color: AppColors
                                                                            .colorGreen,
                                                                        fontSizeDelta:
                                                                            0,
                                                                        fontWeightDelta:
                                                                            1),
                                                                  )),
                                                            ],
                                                          )),
                                                        ],
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TransactionDetailScreen(
                                                                    transactionModel:
                                                                        transaction,
                                                                  )));
                                                    },
                                                  )),
                                            );
                                          },
                                          itemCount: value.transactions.length))
                                ],
                              ));
                        })
                  ],
                )));
      },
    );
  }
}



// Container(
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       Container(
        //         width: size.width / 3,
        //         alignment: Alignment.center,
        //         color: Colors.white,
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Container(
        //               margin: const EdgeInsets.only(left: AppDimens.dimens_8),
        //               child: Text(
        //                 Constants.STR_NAME,
        //                 style: AppStyle.textViewStyleNormalSubtitle2(
        //                     context: context,
        //                     color: AppColors.colorBlack,
        //                     fontWeightDelta: 0,
        //                     fontSizeDelta: -1),
        //               ),
        //             ),
        //             Container(
        //               alignment: Alignment.center,
        //               margin: const EdgeInsets.only(
        //                   right: AppDimens.dimens_5,
        //                   top: AppDimens.dimens_5,
        //                   left: AppDimens.dimens_5),
        //               decoration: AppViews.getRoundBorder(
        //                   cBoxBgColor: AppColors.colorWhite,
        //                   cBorderColor: AppColors.colorBorder3,
        //                   dRadius: AppDimens.dimens_5,
        //                   dBorderWidth: AppDimens.dimens_1),
        //               child: Container(
        //                   margin:
        //                       const EdgeInsets.only(top: AppDimens.dimens_5),
        //                   child: CustomTextFieldWithIcon(
        //                     height: height,
        //                     textInputAction: TextInputAction.next,
        //                     enabled: true,
        //                     focusNode: controller.nodeName,
        //                     controller: controller.controllerName,
        //                     keyboardType: TextInputType.text,
        //                     hintText: Constants.TXT_ENTER_NAME,
        //                     inputFormatters: [],
        //                     obscureText: false,
        //                     onChanged: (String value) {},
        //                   )),
        //             ),
        //           ],
        //         ),
        //       ),
        //       Container(
        //         alignment: Alignment.center,
        //         width: size.width / 3,
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Container(
        //               margin: const EdgeInsets.only(left: AppDimens.dimens_8),
        //               child: Text(
        //                 Constants.TXT_STATUS,
        //                 style: AppStyle.textViewStyleNormalSubtitle2(
        //                     context: context,
        //                     color: AppColors.colorBlack,
        //                     fontWeightDelta: 0,
        //                     fontSizeDelta: -1),
        //               ),
        //             ),
        //             Container(
        //               alignment: Alignment.center,
        //               margin: const EdgeInsets.only(
        //                   right: AppDimens.dimens_5,
        //                   top: AppDimens.dimens_5,
        //                   left: AppDimens.dimens_5),
        //               decoration: AppViews.getRoundBorder(
        //                   cBoxBgColor: AppColors.colorWhite,
        //                   cBorderColor: AppColors.colorBorder3,
        //                   dRadius: AppDimens.dimens_5,
        //                   dBorderWidth: AppDimens.dimens_1),
        //               child: Container(
        //                   margin:
        //                       const EdgeInsets.only(top: AppDimens.dimens_5),
        //                   child: DropdownButtonHideUnderline(
        //                     child: DropdownButton2(
        //                       isExpanded: true,
        //                       items: controller.items
        //                           .map((item) => DropdownMenuItem<String>(
        //                                 value: item,
        //                                 child: Row(
        //                                   children: [
        //                                     Container(
        //                                       child: Text(
        //                                         item,
        //                                         style:
        //                                             AppStyle.textViewStyleSmall(
        //                                                 context: context,
        //                                                 color: AppColors
        //                                                     .colorBlack,
        //                                                 fontSizeDelta: 0,
        //                                                 fontWeightDelta: 0),
        //                                         overflow: TextOverflow.ellipsis,
        //                                       ),
        //                                     ),
        //                                   ],
        //                                 ),
        //                               ))
        //                           .toList(),
        //                       value: controller.selectedValue,
        //                       onChanged: (value) {
        //                         setState(() {
        //                           controller.selectedValue = value as String;
        //                         });
        //                       },
        //                       icon: const Icon(
        //                         Icons.keyboard_arrow_down,
        //                       ),
        //                       iconSize: AppDimens.dimens_20,
        //                       iconEnabledColor: AppColors.colorIconGray,
        //                       iconDisabledColor: Colors.grey,
        //                       buttonHeight: height,
        //                       // buttonWidth: AppDimens.dimens_80,
        //                       buttonPadding: const EdgeInsets.only(
        //                           left: AppDimens.dimens_10,
        //                           right: AppDimens.dimens_10),
        //                       buttonDecoration: BoxDecoration(
        //                         borderRadius:
        //                             BorderRadius.circular(AppDimens.dimens_5),
        //                         color: AppColors.colorWhite,
        //                       ),
        //                       buttonElevation: 0,
        //                       itemHeight: AppDimens.dimens_33,
        //                       // dropdownMaxHeight: AppDimens.dimens_100,
        //                       // dropdownWidth: AppDimens.dimens_80,
        //                       dropdownPadding: null,
        //                       // dropdownDecoration: BoxDecoration(
        //                       //   borderRadius: BorderRadius.circular(AppDimens.dimens_5),
        //                       //   color:
        //                       //   widget.isWhite ? AppColors.colorWhite : AppColors.colorBlueStart,
        //                       // ),
        //                       dropdownElevation: 8,
        //                       scrollbarRadius:
        //                           const Radius.circular(AppDimens.dimens_5),
        //                       scrollbarThickness: 1,
        //                       scrollbarAlwaysShow: true,
        //                       offset: const Offset(0, 0),
        //                     ),
        //                   )
        //                   // child: CustomTextFieldWithIcon(
        //                   //   height: height,
        //                   //   textInputAction: TextInputAction.next,
        //                   //   enabled: true,
        //                   //   focusNode: nodeName,
        //                   //   controller: controllerName,
        //                   //   keyboardType: TextInputType.text,
        //                   //   hintText: Constants.TXT_ENTER_NAME,
        //                   //   inputFormatters: [],
        //                   //   obscureText: false,
        //                   //   onChanged: (String value) {},
        //                   // )
        //                   ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       Container(
        //         width: size.width / 3,
        //         alignment: Alignment.center,
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Container(
        //               margin: const EdgeInsets.only(left: AppDimens.dimens_8),
        //               child: Text(
        //                 Constants.TXT_SEARCH_BY_PRICE,
        //                 style: AppStyle.textViewStyleNormalSubtitle2(
        //                     context: context,
        //                     color: AppColors.colorBlack,
        //                     fontWeightDelta: 0,
        //                     fontSizeDelta: -1),
        //               ),
        //             ),
        //             Container(
        //               alignment: Alignment.center,
        //               margin: const EdgeInsets.only(
        //                   right: AppDimens.dimens_5,
        //                   top: AppDimens.dimens_5,
        //                   left: AppDimens.dimens_5),
        //               decoration: AppViews.getRoundBorder(
        //                   cBoxBgColor: AppColors.colorWhite,
        //                   cBorderColor: AppColors.colorBorder3,
        //                   dRadius: AppDimens.dimens_5,
        //                   dBorderWidth: AppDimens.dimens_1),
        //               child: Container(
        //                   margin:
        //                       const EdgeInsets.only(top: AppDimens.dimens_5),
        //                   child: CustomTextFieldWithIcon(
        //                     height: height,
        //                     textInputAction: TextInputAction.next,
        //                     enabled: true,
        //                     focusNode: controller.nodePrice,
        //                     controller: controller.controllerPrice,
        //                     keyboardType: TextInputType.text,
        //                     hintText: Constants.TXT_PRICE,
        //                     inputFormatters: [],
        //                     obscureText: false,
        //                     onChanged: (String value) {},
        //                   )),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        //   alignment: Alignment.center,
        //   height: AppDimens.dimens_80,
        // ),
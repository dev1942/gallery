import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/controllers/invite_and_earn_controller.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_images.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/container_properties.dart';
import 'package:otobucks/widgets/fade_in_image.dart';
import 'package:otobucks/widgets/gradient_text.dart';
import 'package:share_plus/share_plus.dart';

class InviteFriendFragment extends StatefulWidget {
  const InviteFriendFragment({Key? key}) : super(key: key);

  @override
  InviteFriendFragmentState createState() => InviteFriendFragmentState();
}

class InviteFriendFragmentState extends State<InviteFriendFragment> {
  var controller = Get.put(InviteAndEarnController());

  @override
  void initState() {
    controller.getInviteCode();
    controller.getMyInvites();
    super.initState();
  }

  double marginBoth = AppDimens.dimens_20;
  double height = AppDimens.dimens_32;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: AppColors.getMainBgColor(),
            body: SingleChildScrollView(
                child: Column(
              children: [_inviteSection(), _myInvitedSection()],
            ))));
  }

  _inviteSection() {
    return GetBuilder<InviteAndEarnController>(builder: (value) {
      return LayoutBuilder(builder: (context, size) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(AppDimens.dimens_30),
              child: Image.asset(AppImages.ic_invite_friend_top_image,
                  height: size.maxWidth / 2),
            ),

            Container(
                margin: const EdgeInsets.only(
                    top: AppDimens.dimens_5, bottom: AppDimens.dimens_5),
                alignment: Alignment.center,
                child: Text(
                  Constants.TXT_INVITE_FRIENDS,
                  style: AppStyle.textViewStyleNormalBodyText2(
                      context: context,
                      color: AppColors.colorBlack,
                      fontSizeDelta: 1,
                      fontWeightDelta: 1),
                )),
            Container(
                margin: const EdgeInsets.all(AppDimens.dimens_15),
                alignment: Alignment.center,
                child: Text(
                  "Now you can earn by inviting your friends, relative or anyone to the application. If they will use your refered code while signup then you will get a reward in return of that.",
                  textAlign: TextAlign.center,
                  style: AppStyle.textViewStyleSmall(
                      context: context,
                      color: AppColors.grayDashboardText,
                      fontSizeDelta: -2,
                      fontWeightDelta: 0),
                )),
            AppViews.getSetDataWithReturn(
                context,
                value.loadingInvite,
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      right: marginBoth, top: marginBoth, left: marginBoth),
                  decoration: AppViews.getRoundBorder(
                      cBoxBgColor: AppColors.colorWhite,
                      cBorderColor: AppColors.colorBorder2,
                      dRadius: AppDimens.dimens_5,
                      dBorderWidth: AppDimens.dimens_1),
                  child: Container(
                      height: AppDimens.dimens_46,
                      padding: const EdgeInsets.only(
                          left: AppDimens.dimens_10,
                          right: AppDimens.dimens_10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    value.inviteLink,
                                    textAlign: TextAlign.center,
                                    style: AppStyle.textViewStyleSmall(
                                        context: context,
                                        color: AppColors.colorBlack4,
                                        fontSizeDelta: -1,
                                        fontWeightDelta: 1),
                                  ))),
                          InkWell(
                            onTap: () => value.copyText(),
                            child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "COPY",
                                  textAlign: TextAlign.center,
                                  style: AppStyle.textViewStyleSmall(
                                      context: context,
                                      color: AppColors.colorBlue2,
                                      fontSizeDelta: 2,
                                      fontWeightDelta: 3),
                                )),
                          )
                        ],
                      )),
                ),
                'Invitation code not available right now!'),
            InkWell(
              onTap: () => Share.share(value.customLink),
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    right: marginBoth, top: marginBoth, left: marginBoth),
                child: Container(
                    height: AppDimens.dimens_46,
                    padding: const EdgeInsets.only(
                        left: AppDimens.dimens_10, right: AppDimens.dimens_10),
                    child: Wrap(
                      children: [
                        Text(
                          Constants.TXT_SHARE_WITH_YOUR_FRIENDS,
                          textAlign: TextAlign.center,
                          style: AppStyle.textViewStyleSmall(
                              context: context,
                              color: AppColors.colorBlack4,
                              fontSizeDelta: -1,
                              fontWeightDelta: 1),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          AppImages.ic_fb_share,
                          height: AppDimens.dimens_20,
                          width: AppDimens.dimens_20,
                        ),
                        addHorizontalSpace(9),
                        Image.asset(
                          'assets/images/ic_linked.png',
                          height: AppDimens.dimens_20,
                          width: AppDimens.dimens_20,
                        ),
                        addHorizontalSpace(9),

                        Image.asset(
                          AppImages.ic_twitter,
                          height: AppDimens.dimens_20,
                          width: AppDimens.dimens_20,
                        ),
                        addHorizontalSpace(9),
                        Image.asset(
                          AppImages.ic_whatsapp,
                          height: AppDimens.dimens_20,
                          width: AppDimens.dimens_20,
                        ),
                      ],
                    )),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: marginBoth, left: marginBoth),
              child: AppViews.addDividerSimple(),
            ),
          ],
        );
      });
    });
  }

  _myInvitedSection() => Column(
        children: [
          Container(
              margin: const EdgeInsets.only(right: 10, top: 20, left: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                Constants.TXT_INVITED_FRIENDS,
                style: AppStyle.textViewStyleNormalBodyText2(
                    context: context,
                    color: AppColors.colorBlack,
                    fontSizeDelta: 1,
                    fontWeightDelta: 1),
              )),
          GetBuilder<InviteAndEarnController>(builder: (value) {
            return AppViews.getSetDataWithReturn(
                context,
                value.loadingjoiners,
                ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: value.inviteJoiners.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (value.inviteJoiners[index].joiner.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return Container(
                        decoration: ContainerProperties.shadowDecoration(
                            blurRadius: 15.0),
                        margin:
                            const EdgeInsets.only(bottom: AppDimens.dimens_14),
                        child: InkWell(
                          child: Container(
                            alignment: Alignment.center,
                            height: AppDimens.dimens_90,
                            padding: const EdgeInsets.only(
                              right: AppDimens.dimens_10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                    right: AppDimens.dimens_10,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        AppDimens.dimens_5),
                                    child: NetworkImageCustom(
                                        image: value.inviteJoiners[index]
                                            .joiner[0].image,
                                        fit: BoxFit.fill,
                                        height: AppDimens.dimens_90,
                                        width: AppDimens.dimens_90),
                                  ),
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    //title
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                value.inviteJoiners[index]
                                                        .joiner[0].firstName +
                                                    ' ' +
                                                    value.inviteJoiners[index]
                                                        .joiner[0].lastName,
                                                style: AppStyle
                                                    .textViewStyleNormalBodyText2(
                                                        context: context,
                                                        color: AppColors
                                                            .grayDashboardText,
                                                        fontSizeDelta: 1,
                                                        fontWeightDelta: 1),
                                              )),
                                          Container(
                                              alignment: Alignment.centerLeft,
                                              child: GradientText(
                                                "",
                                                style: AppStyle
                                                    .textViewStyleNormalBodyText2(
                                                        context: context,
                                                        color: AppColors
                                                            .grayDashboardText,
                                                        fontSizeDelta: 2,
                                                        fontWeightDelta: 3),
                                              )),
                                        ],
                                      ),
                                      margin: const EdgeInsets.only(
                                          top: AppDimens.dimens_5,
                                          bottom: AppDimens.dimens_5),
                                    ),
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          value.inviteJoiners[index].joiner[0]
                                              .getDate()
                                              .toString(),
                                          style: AppStyle
                                              .textViewStyleNormalBodyText2(
                                                  context: context,
                                                  color: AppColors
                                                      .grayDashboardText,
                                                  fontSizeDelta: -2,
                                                  fontWeightDelta: 0),
                                        )),
                                    //Date
                                  ],
                                )),
                              ],
                            ),
                          ),
                          onTap: () {
                            // onTapMain();
                          },
                        ),
                      );
                    }),
                'No Invited Friends');
          }),
        ],
      );
}

//  Widget mShowWidget = SingleChildScrollView(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: const [
//           // Container(
//           //     margin: EdgeInsets.only(
//           //         right: margin_both, top: margin_both, left: margin_both),
//           //     alignment: Alignment.centerLeft,
//           //     child: Text(
//           //       Constants.TXT_INVITED_FRIENDS,
//           //       style: AppStyle.textViewStyleNormalBodyText2(
//           //           context: context,
//           //           color: AppColors.colorBlack,
//           //           fontSizeDelta: 1,
//           //           fontWeightDelta: 1),
//           //     )),
//           // Container(
//           //   child: Row(
//           //     mainAxisAlignment: MainAxisAlignment.center,
//           //     crossAxisAlignment: CrossAxisAlignment.center,
//           //     children: [
//           //       Container(
//           //         width: size.width / 3,
//           //         alignment: Alignment.center,
//           //         color: Colors.white,
//           //         child: Column(
//           //           crossAxisAlignment: CrossAxisAlignment.start,
//           //           mainAxisAlignment: MainAxisAlignment.center,
//           //           children: [
//           //             Container(
//           //               margin: const EdgeInsets.only(left: AppDimens.dimens_8),
//           //               child: Text(
//           //                 Constants.STR_NAME,
//           //                 style: AppStyle.textViewStyleNormalSubtitle2(
//           //                     context: context,
//           //                     color: AppColors.colorBlack,
//           //                     fontWeightDelta: 0,
//           //                     fontSizeDelta: -1),
//           //               ),
//           //             ),
//           //             Container(
//           //               alignment: Alignment.center,
//           //               margin: const EdgeInsets.only(
//           //                   right: AppDimens.dimens_5,
//           //                   top: AppDimens.dimens_5,
//           //                   left: AppDimens.dimens_5),
//           //               decoration: AppViews.getRoundBorder(
//           //                   cBoxBgColor: AppColors.colorWhite,
//           //                   cBorderColor: AppColors.colorBorder3,
//           //                   dRadius: AppDimens.dimens_5,
//           //                   dBorderWidth: AppDimens.dimens_1),
//           //               child: Container(
//           //                   margin:
//           //                       const EdgeInsets.only(top: AppDimens.dimens_5),
//           //                   child: CustomTextFieldWithIcon(
//           //                     height: height,
//           //                     textInputAction: TextInputAction.next,
//           //                     enabled: true,
//           //                     focusNode: nodeName,
//           //                     controller: controllerName,
//           //                     keyboardType: TextInputType.text,
//           //                     hintText: Constants.TXT_ENTER_NAME,
//           //                     inputFormatters: [],
//           //                     obscureText: false,
//           //                     onChanged: (String value) {},
//           //                   )),
//           //             ),
//           //           ],
//           //         ),
//           //       ),
//           //       Container(
//           //         alignment: Alignment.center,
//           //         width: size.width / 3.6,
//           //         child: Column(
//           //           crossAxisAlignment: CrossAxisAlignment.start,
//           //           mainAxisAlignment: MainAxisAlignment.center,
//           //           children: [
//           //             Container(
//           //               margin: const EdgeInsets.only(left: AppDimens.dimens_8),
//           //               child: Text(
//           //                 Constants.TXT_STATUS,
//           //                 style: AppStyle.textViewStyleNormalSubtitle2(
//           //                     context: context,
//           //                     color: AppColors.colorBlack,
//           //                     fontWeightDelta: 0,
//           //                     fontSizeDelta: -1),
//           //               ),
//           //             ),
//           //             Container(
//           //               alignment: Alignment.center,
//           //               margin: const EdgeInsets.only(
//           //                   right: AppDimens.dimens_5,
//           //                   top: AppDimens.dimens_5,
//           //                   left: AppDimens.dimens_5),
//           //               decoration: AppViews.getRoundBorder(
//           //                   cBoxBgColor: AppColors.colorWhite,
//           //                   cBorderColor: AppColors.colorBorder3,
//           //                   dRadius: AppDimens.dimens_5,
//           //                   dBorderWidth: AppDimens.dimens_1),
//           //               child: Container(
//           //                   margin:
//           //                       const EdgeInsets.only(top: AppDimens.dimens_5),
//           //                   child: DropdownButtonHideUnderline(
//           //                     child: DropdownButton2(
//           //                       isExpanded: true,
//           //                       items: items
//           //                           .map((item) => DropdownMenuItem<String>(
//           //                                 value: item,
//           //                                 child: Row(
//           //                                   children: [
//           //                                     Container(
//           //                                       child: Text(
//           //                                         item,
//           //                                         style: AppStyle
//           //                                             .textViewStyleSmall(
//           //                                                 context: context,
//           //                                                 color: AppColors
//           //                                                     .colorBlack,
//           //                                                 fontSizeDelta: 0,
//           //                                                 fontWeightDelta: 0),
//           //                                         overflow:
//           //                                             TextOverflow.ellipsis,
//           //                                       ),
//           //                                     ),
//           //                                   ],
//           //                                 ),
//           //                               ))
//           //                           .toList(),
//           //                       value: selectedValue,
//           //                       onChanged: (value) {
//           //                         setState(() {
//           //                           selectedValue = value as String;
//           //                         });
//           //                       },
//           //                       icon: const Icon(
//           //                         Icons.keyboard_arrow_down,
//           //                       ),
//           //                       iconSize: AppDimens.dimens_20,
//           //                       iconEnabledColor: AppColors.colorIconGray,
//           //                       iconDisabledColor: Colors.grey,
//           //                       buttonHeight: height,
//           //                       // buttonWidth: AppDimens.dimens_80,
//           //                       buttonPadding: const EdgeInsets.only(
//           //                           left: AppDimens.dimens_10,
//           //                           right: AppDimens.dimens_10),
//           //                       buttonDecoration: BoxDecoration(
//           //                         borderRadius:
//           //                             BorderRadius.circular(AppDimens.dimens_5),
//           //                         color: AppColors.colorWhite,
//           //                       ),
//           //                       buttonElevation: 0,
//           //                       itemHeight: AppDimens.dimens_33,
//           //                       // dropdownMaxHeight: AppDimens.dimens_100,
//           //                       // dropdownWidth: AppDimens.dimens_80,
//           //                       dropdownPadding: null,
//           //                       // dropdownDecoration: BoxDecoration(
//           //                       //   borderRadius: BorderRadius.circular(AppDimens.dimens_5),
//           //                       //   color:
//           //                       //   widget.isWhite ? AppColors.colorWhite : AppColors.colorBlueStart,
//           //                       // ),
//           //                       dropdownElevation: 8,
//           //                       scrollbarRadius:
//           //                           const Radius.circular(AppDimens.dimens_5),
//           //                       scrollbarThickness: 1,
//           //                       scrollbarAlwaysShow: true,
//           //                       offset: const Offset(0, 0),
//           //                     ),
//           //                   )
//           //                   // child: CustomTextFieldWithIcon(
//           //                   //   height: height,
//           //                   //   textInputAction: TextInputAction.next,
//           //                   //   enabled: true,
//           //                   //   focusNode: nodeName,
//           //                   //   controller: controllerName,
//           //                   //   keyboardType: TextInputType.text,
//           //                   //   hintText: Constants.TXT_ENTER_NAME,
//           //                   //   inputFormatters: [],
//           //                   //   obscureText: false,
//           //                   //   onChanged: (String value) {},
//           //                   // )
//           //                   ),
//           //             ),
//           //           ],
//           //         ),
//           //       ),
//           //       Container(
//           //         width: size.width / 2.8,
//           //         alignment: Alignment.center,
//           //         child: Column(
//           //           crossAxisAlignment: CrossAxisAlignment.start,
//           //           mainAxisAlignment: MainAxisAlignment.center,
//           //           children: [
//           //             Container(
//           //               margin: const EdgeInsets.only(left: AppDimens.dimens_8),
//           //               child: Text(
//           //                 Constants.TXT_SEARCH_BY_DATE,
//           //                 style: AppStyle.textViewStyleNormalSubtitle2(
//           //                     context: context,
//           //                     color: AppColors.colorBlack,
//           //                     fontWeightDelta: 0,
//           //                     fontSizeDelta: -1),
//           //               ),
//           //             ),
//           //             Container(
//           //               alignment: Alignment.center,
//           //               margin: const EdgeInsets.only(
//           //                   right: AppDimens.dimens_5,
//           //                   top: AppDimens.dimens_5,
//           //                   left: AppDimens.dimens_5),
//           //               decoration: AppViews.getRoundBorder(
//           //                   cBoxBgColor: AppColors.colorWhite,
//           //                   cBorderColor: AppColors.colorBorder3,
//           //                   dRadius: AppDimens.dimens_5,
//           //                   dBorderWidth: AppDimens.dimens_1),
//           //               child: Container(
//           //                   margin:
//           //                       const EdgeInsets.only(top: AppDimens.dimens_5),
//           //                   child: CustomTextFieldWithIcon(
//           //                     height: height,
//           //                     textInputAction: TextInputAction.next,
//           //                     enabled: true,
//           //                     focusNode: nodeDate,
//           //                     controller: controllerDate,
//           //                     keyboardType: TextInputType.text,
//           //                     hintText: Constants.TXT_START_DATE_END_DATE,
//           //                     inputFormatters: [],
//           //                     obscureText: false,
//           //                     onChanged: (String value) {},
//           //                   )),
//           //             ),
//           //           ],
//           //         ),
//           //       ),
//           //     ],
//           //   ),
//           //   alignment: Alignment.center,
//           //   height: AppDimens.dimens_80,
//           // ),
//           // ListView.builder(
//           //     padding: const EdgeInsets.all(AppDimens.dimens_10),
//           //     shrinkWrap: true,
//           //     physics: const NeverScrollableScrollPhysics(),
//           //     itemBuilder: (BuildContext contextM, index) {
//           //       return Container(
//           //         margin: const EdgeInsets.only(bottom: AppDimens.dimens_14),
//           //         color: Colors.transparent,
//           //         child: Card(
//           //             elevation: AppDimens.dimens_3,
//           //             shape: RoundedRectangleBorder(
//           //               borderRadius: BorderRadius.circular(AppDimens.dimens_5),
//           //             ),
//           //             child: InkWell(
//           //               child: Container(
//           //                 alignment: Alignment.center,
//           //                 height: AppDimens.dimens_90,
//           //                 padding: const EdgeInsets.only(
//           //                   right: AppDimens.dimens_10,
//           //                 ),
//           //                 child: Row(
//           //                   mainAxisAlignment: MainAxisAlignment.center,
//           //                   crossAxisAlignment: CrossAxisAlignment.start,
//           //                   children: [
//           //                     Container(
//           //                       margin: const EdgeInsets.only(
//           //                         right: AppDimens.dimens_10,
//           //                       ),
//           //                       child: ClipRRect(
//           //                         borderRadius:
//           //                             BorderRadius.circular(AppDimens.dimens_5),
//           //                         child: const NetworkImageCustom(
//           //                             image:
//           //                                 "https://qph.cf2.quoracdn.net/main-thumb-1278318002-200-ydzfegagslcexelzgsnplcklfkienzfr.jpeg",
//           //                             fit: BoxFit.fill,
//           //                             height: AppDimens.dimens_90,
//           //                             width: AppDimens.dimens_90),
//           //                       ),
//           //                     ),
//           //                     Expanded(
//           //                         child: Column(
//           //                       crossAxisAlignment: CrossAxisAlignment.start,
//           //                       mainAxisAlignment: MainAxisAlignment.start,
//           //                       children: [
//           //                         Container(
//           //                           child: Row(
//           //                             mainAxisAlignment:
//           //                                 MainAxisAlignment.spaceBetween,
//           //                             crossAxisAlignment:
//           //                                 CrossAxisAlignment.center,
//           //                             children: [
//           //                               Container(
//           //                                   alignment: Alignment.centerLeft,
//           //                                   child: Text(
//           //                                     "Jhon Doe",
//           //                                     style: AppStyle
//           //                                         .textViewStyleNormalBodyText2(
//           //                                             context: context,
//           //                                             color: AppColors
//           //                                                 .grayDashboardText,
//           //                                             fontSizeDelta: 1,
//           //                                             fontWeightDelta: 1),
//           //                                   )),
//           //                               Container(
//           //                                   alignment: Alignment.centerLeft,
//           //                                   child: GradientText(
//           //                                     "Active",
//           //                                     style: AppStyle
//           //                                         .textViewStyleNormalBodyText2(
//           //                                             context: context,
//           //                                             color:
//           //                                                 AppColors.colorGreen,
//           //                                             fontSizeDelta: 1,
//           //                                             fontWeightDelta: 1),
//           //                                   )),
//           //                             ],
//           //                           ),
//           //                         ),
//           //                         Container(
//           //                             alignment: Alignment.centerLeft,
//           //                             child: Text(
//           //                               "Burnside",
//           //                               style: AppStyle.textViewStyleSmall(
//           //                                   context: context,
//           //                                   color: AppColors.grayDashboardText,
//           //                                   fontSizeDelta: -2,
//           //                                   fontWeightDelta: 0),
//           //                             )),
//           //                         Container(
//           //                             alignment: Alignment.centerLeft,
//           //                             child: Text(
//           //                               "whatsapp",
//           //                               style: AppStyle.textViewStyleSmall(
//           //                                   context: context,
//           //                                   color: AppColors.grayDashboardText,
//           //                                   fontSizeDelta: -2,
//           //                                   fontWeightDelta: 0),
//           //                             )),
//           //                         Container(
//           //                             alignment: Alignment.centerRight,
//           //                             child: Text(
//           //                               "JAN 4, 2022",
//           //                               style: AppStyle.textViewStyleSmall(
//           //                                   context: context,
//           //                                   color: AppColors.grayDashboardText,
//           //                                   fontSizeDelta: -2,
//           //                                   fontWeightDelta: 0),
//           //                             )),
//           //                       ],
//           //                     )),
//           //                   ],
//           //                 ),
//           //               ),
//           //               onTap: () {},
//           //             )),
//           //       );
//           //     },
//           //     itemCount: 10)
//         ],
//       ),
//     );
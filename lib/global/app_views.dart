import 'package:flutter/material.dart';
import 'package:flutter_circular_text/circular_text.dart';
import 'package:get/get.dart';
import 'package:otobucks/custom_ui/loader/three_bounce.dart';
import 'package:shimmer/shimmer.dart';

import 'app_colors.dart';
import 'app_dimens.dart';
import 'app_images.dart';
import 'app_style.dart';
import 'constants.dart';
import 'enum.dart';
import 'global.dart';

class AppViews {
  // App bar inti

  static initAppBar({
    required BuildContext mContext,
    required String strTitle,
    required bool centerTitle,
    required bool isShowSOS,
    required bool isShowNotification,
    Function? menuTap,
    Function? sosTap,
    Icon? icon,
  }) {
    List<Widget> actionsList = [];

    if (isShowSOS) {
      actionsList.add(GestureDetector(
        onTap: () {
          Global.inProgressAlert(mContext);
        },
        child: SizedBox(
          // margin: const EdgeInsetsDirectional.only(end: AppDimens.dimens_20),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                AppImages.ic_sos,
                height: 29,
              ),
              CircularText(
                children: [
                  TextItem(
                    text: Text(
                      "Emergency".toUpperCase(),
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    space: 19,
                    startAngle: -90,
                    startAngleAlignment: StartAngleAlignment.center,
                    direction: CircularTextDirection.clockwise,
                  ),
                ],
                radius: 70,
                position: CircularTextPosition.inside,
                // backgroundPaint: Paint()..color = Colors.grey.shade200,
              ),
            ],
          ),

          height: 30,
          width: 80,
        ),
      ));
    }

    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.colorBlueStart,
      leading: Container(
        height: AppDimens.dimens_26,
        width: AppDimens.dimens_26,
        margin: const EdgeInsets.only(right: AppDimens.dimens_10),
        child: InkWell(
          child: icon == null
              ? Icon(
                  centerTitle ? Icons.menu : Icons.keyboard_arrow_left,
                  color: AppColors.colorWhite,
                  size: AppDimens.dimens_26,
                )
              : Container(),
          onTap: () {
            if (menuTap != null) {
              menuTap();
            } else {
              Navigator.of(mContext).pop(true);
            }
          },
        ),
      ),
      title: centerTitle
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Text(strTitle,
                      textScaleFactor: Global.getScalFactor(),
                      softWrap: true,
                      maxLines: 1,
                      style: AppStyle.textViewStyleLarge(
                          context: mContext,
                          color: AppColors.colorWhite,
                          fontWeightDelta: 2)),
                  margin: const EdgeInsets.only(bottom: 1),
                ),
                Text("welcome to outobucks".tr,
                    textScaleFactor: Global.getScalFactor(),
                    softWrap: true,
                    maxLines: 1,
                    style: AppStyle.textViewStyleSmall(
                        context: mContext,
                        color: AppColors.colorWhite,
                        fontWeightDelta: -2,
                        fontSizeDelta: -1)),
              ],
            )
          : Text(
              strTitle,
              style: Theme.of(mContext)
                  .textTheme
                  .subtitle1
                  ?.apply(color: AppColors.colorWhite, fontWeightDelta: 1),
            ),
      centerTitle: centerTitle,
      actions: actionsList,
    );
  }

  static initAppBarHome(
      {required BuildContext mContext, required String strTitle}) {
    List<Widget> actionsList = [];

    actionsList.add(Container(
      margin: const EdgeInsets.only(right: AppDimens.dimens_20),
      child: InkResponse(
        child: Image.asset(AppImages.ic_user_filled),
        onTap: () {},
      ),
      height: AppDimens.dimens_18,
      width: AppDimens.dimens_18,
    ));

    // actionsList.add(Container(
    //     margin: EdgeInsets.only(right: AppDimens.dimens_15),
    //     alignment: Alignment.center,
    //     decoration: new BoxDecoration(
    //       color: AppColors.colorAccent.withOpacity(0.1),
    //       shape: BoxShape.circle,
    //     ),
    //     child: InkResponse(
    //       child: Global.checkNull(strUserImgae)
    //           ? ClipRRect(
    //           borderRadius: BorderRadius.circular(30.0),
    //           child: FadeInImage.assetNetwork(
    //               placeholderScale: 1.0,
    //               placeholder: AppImages.ic_place_holder,
    //               image: strUserImgae,
    //               imageErrorBuilder: (BuildContext context,
    //                   Object exception, StackTrace stackTrace) {
    //                 return AppViews.getErrorImage(
    //                     AppDimens.dimens_40, AppDimens.dimens_40);
    //               },
    //               fit: BoxFit.fill))
    //           : Text(
    //         strTitle,
    //         style: Theme.of(mContext).textTheme.button!.apply(
    //             color: AppColors.colorAccent,
    //             fontWeightDelta: -1,
    //             letterSpacingDelta: 0),
    //       ),
    //       onTap: () {
    //        // gotoMyProfile();
    //       },
    //     ),
    //     height: AppDimens.dimens_40,
    //     width: AppDimens.dimens_40));

    return AppBar(
      titleSpacing: 0,
      backgroundColor: AppColors.colorWhite,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.colorAccent),
      title: Text(
        strTitle,
        style: Theme.of(mContext)
            .textTheme
            .subtitle1
            ?.apply(color: AppColors.colorTextFieldHint, fontWeightDelta: 3),
      ),
      actions: actionsList,
    );
  }

  static initEmptyAppBar() {
    return AppBar(
      toolbarHeight: AppDimens.dimens_10,
      titleSpacing: 0,
      backgroundColor: AppColors.colorBlueStart,
      leading: const SizedBox(
        height: 0,
        width: 0,
      ),
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.colorBlueStart),
      title: const Text(
        "",
      ),
    );
  }

  // Show Center Loading
  static showLoading() {
    return Center(
      child: SpinKitThreeBounce(
          color: AppColors.colorAccent, size: AppDimens.dimens_34),
    );
  } // Show Footer Loading Icon

  static showLoadingWithStatus(bool isShowLoader) {
    return isShowLoader
        ? Container(
            child: AppViews.showLoading(),
            color: Colors.white70,
          )
        : const SizedBox(
            height: 0,
            width: 0,
          );
  } // Show Footer Loading Icon

  static showLoadingChatWithStatus(bool isShowLoader) {
    return isShowLoader
        ? Container(
            child: AppViews.shimmerChat(),
            // color: Colors.white70,
          )
        : const SizedBox(
            height: 0,
            width: 0,
          );
  }

  static showFooterLoading(bool isProgressBarBottomShown) {
    if (isProgressBarBottomShown) {
      return SizedBox(
        height: AppDimens.dimens_34,
        child: Center(
          child: SpinKitThreeBounce(
            color: AppColors.colorAccent,
            size: AppDimens.dimens_34,
          ),
        ),
      );
    } else {
      return const SizedBox(
        height: 0,
        width: 0,
      );
    }
  }

  static addDividerDrawer() {
    // divider
    return Container(
      color: AppColors.colorDividerDrawer.withOpacity(0.2),
      height: AppDimens.dimens_1,
    );
  }

  static addDividerDrawerSmall() {
    // divider
    return Container(
      margin: const EdgeInsets.only(
          top: AppDimens.margin_normal, bottom: AppDimens.margin_normal),
      color: AppColors.colorDividerDrawer.withOpacity(0.3),
      height: AppDimens.dimens_1,
    );
  }

  static setNoData(String strTitle, BuildContext context) {
    return Center(
        child: Text(
      strTitle,
      textAlign: TextAlign.center,
      style: AppStyle.textViewStyleLarge(
          context: context,
          color: AppColors.colorBlack,
          fontWeightDelta: 0,
          fontSizeDelta: 0),
    ));
  }

  static addDivider() {
    // divider
    return Container(
      margin: const EdgeInsets.only(
          top: AppDimens.margin_xxx_small, bottom: AppDimens.margin_xxx_small),
      color: AppColors.colorDividerDrawer.withOpacity(0.1),
      height: AppDimens.dimens_1,
    );
  }

  static addDividerSimple() {
    // divider
    return Container(
      margin: const EdgeInsets.only(
          top: AppDimens.margin_xx_small, bottom: AppDimens.margin_xx_small),
      color: AppColors.colorDividerDrawer.withOpacity(0.1),
      height: AppDimens.dimens_1,
    );
  }

  static getRoundBorder(
      {required Color cBoxBgColor,
      required Color cBorderColor,
      required double dRadius,
      required double dBorderWidth}) {
    return BoxDecoration(
      color: cBoxBgColor,
      borderRadius: BorderRadius.circular(dRadius),
      border: Border.all(
        width: dBorderWidth,
        color: cBorderColor,
      ),
    );
  }

  static getErrorImage(double mHeight, double mWidth) {
    return Image.asset(AppImages.ic_place_holder,
        height: mHeight, width: mWidth, fit: BoxFit.contain);
  }

  static getProgressImage(double mHeight, double mWidth) {
    return SizedBox(
      width: 200.0,
      height: 100.0,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
            decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        )),
      ),
    );
  }

  static getSetData(
    BuildContext context,
    ShowData mShowData,
    Widget showWidget,
  ) {
    Widget widgetM = Container();

    switch (mShowData) {
      case ShowData.showLoading:
        widgetM = Container(
          child: AppViews.showLoading(),
          color: Theme.of(context).colorScheme.surface,
        );
        break;

      case ShowData.showData:
        widgetM = showWidget;

        break;
      case ShowData.showNoDataFound:
        widgetM = Center(
          child: Text(
            AppAlert.MSG_NO_RECORDS_FOUND,
            textAlign: TextAlign.center,
            style: AppStyle.textViewStyleLarge(
                context: context,
                color: AppColors.colorBlack,
                fontWeightDelta: 0,
                fontSizeDelta: 0),
          ),
        );
        break;
      case ShowData.showError:
        widgetM = Container(
          child:
              AppViews.setNoData(AppAlert.ALERT_SERVER_NOT_RESPONDING, context),
        );
        break;
    }

    return widgetM;
  }

  static getSetDataNotification(
    BuildContext context,
    ShowData mShowData,
    Widget showWidget,
  ) {
    Widget widgetM = Container();

    switch (mShowData) {
      case ShowData.showLoading:
        widgetM = Container(
          child: ListView.builder(
            padding: const EdgeInsets.all(AppDimens.dimens_20),
            itemCount: 15,
            itemBuilder: (context, i) {
              return AppViews.shimmerNotification();
            },
          ),
          color: Theme.of(context).colorScheme.surface,
        );
        break;

      case ShowData.showData:
        widgetM = showWidget;

        break;
      case ShowData.showNoDataFound:
        widgetM = Center(
          child: Text(
            AppAlert.MSG_NO_RECORDS_FOUND,
            textAlign: TextAlign.center,
            style: AppStyle.textViewStyleLarge(
                context: context,
                color: AppColors.colorBlack,
                fontWeightDelta: 0,
                fontSizeDelta: 0),
          ),
        );
        break;
      case ShowData.showError:
        widgetM = Container(
          child:
              AppViews.setNoData(AppAlert.ALERT_SERVER_NOT_RESPONDING, context),
        );
        break;
    }

    return widgetM;
  }

  static getSetDataChat(
    BuildContext context,
    ShowData mShowData,
    Widget showWidget,
  ) {
    Widget widgetM = Container();

    switch (mShowData) {
      case ShowData.showLoading:
        widgetM = Container(
          child: ListView.builder(
            padding: const EdgeInsets.all(AppDimens.dimens_15),
            itemCount: 15,
            itemBuilder: (context, i) {
              return AppViews.shimmerChat();
            },
          ),
          color: Theme.of(context).colorScheme.surface,
        );
        break;

      case ShowData.showData:
        widgetM = showWidget;

        break;
      case ShowData.showNoDataFound:
        widgetM = Center(
          child: Text(
            AppAlert.MSG_NO_RECORDS_FOUND,
            textAlign: TextAlign.center,
            style: AppStyle.textViewStyleLarge(
                context: context,
                color: AppColors.colorBlack,
                fontWeightDelta: 0,
                fontSizeDelta: 0),
          ),
        );
        break;
      case ShowData.showError:
        widgetM = Container(
          child:
              AppViews.setNoData(AppAlert.ALERT_SERVER_NOT_RESPONDING, context),
        );
        break;
    }

    return widgetM;
  }

  static getSetDataCustomLoader(BuildContext context, ShowData mShowData,
      Widget showWidget, Widget loader, String noData) {
    Widget widgetM = Container();

    switch (mShowData) {
      case ShowData.showLoading:
        widgetM = Container(
          child: loader,
          color: Theme.of(context).colorScheme.surface,
        );
        break;

      case ShowData.showData:
        widgetM = showWidget;

        break;
      case ShowData.showNoDataFound:
        widgetM = Center(
          child: Text(
            noData,
            textAlign: TextAlign.center,
            style: AppStyle.textViewStyleLarge(
                context: context,
                color: AppColors.colorBlack,
                fontWeightDelta: 0,
                fontSizeDelta: 0),
          ),
        );
        break;
      case ShowData.showError:
        widgetM = Container(
          child:
              AppViews.setNoData(AppAlert.ALERT_SERVER_NOT_RESPONDING, context),
        );
        break;
    }

    return widgetM;
  }

  static getSetDataWithReturn(BuildContext context, ShowData mShowData,
      Widget showWidget, String onReturn) {
    Widget widgetM = Container();

    switch (mShowData) {
      case ShowData.showLoading:
        widgetM = Container(
          child: AppViews.showLoading(),
          color: Theme.of(context).colorScheme.surface,
        );
        break;

      case ShowData.showData:
        widgetM = showWidget;

        break;
      case ShowData.showNoDataFound:
        widgetM = Center(
          child: Text(
            onReturn,
            textAlign: TextAlign.center,
            style: AppStyle.textViewStyleLarge(
                context: context,
                color: AppColors.colorBlack,
                fontWeightDelta: 0,
                fontSizeDelta: 0),
          ),
        );

        break;
      case ShowData.showError:
        widgetM = Container(
          child:
              AppViews.setNoData(AppAlert.ALERT_SERVER_NOT_RESPONDING, context),
        );
        break;
    }

    return widgetM;
  }

  static getSetDataGridView(
      BuildContext context, ShowData mShowData, Widget showWidget) {
    Widget widgetM = Container();

    switch (mShowData) {
      case ShowData.showLoading:
        widgetM = Container(
          alignment: Alignment.topCenter,
          child: SpinKitThreeBounce(
              color: AppColors.colorAccent, size: AppDimens.dimens_34),
          color: Theme.of(context).colorScheme.surface,
        );
        break;

      case ShowData.showData:
        widgetM = showWidget;

        break;
      case ShowData.showNoDataFound:
        widgetM = Container(
          child: AppViews.setNoData(AppAlert.MSG_NO_RECORDS_FOUND, context),
        );
        break;
      case ShowData.showError:
        widgetM = Container(
          child:
              AppViews.setNoData(AppAlert.ALERT_SERVER_NOT_RESPONDING, context),
        );
        break;
    }

    return widgetM;
  }

  static getBorderDecor() {
    return BoxDecoration(
      border:
          Border.all(width: 1.0, color: AppColors.lightGrey.withOpacity(0.2)),
      borderRadius: const BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
          ),
    );

    // return BoxDecoration(
    //   borderRadius: BorderRadius.all(Radius.circular(AppDimens.dimens_5)),
    //   boxShadow: [
    //     BoxShadow(
    //       color: AppColors.colorAccent.withOpacity(0.15),
    //       offset: const Offset(
    //         AppDimens.dimens_5,
    //         AppDimens.dimens_5,
    //       ),
    //       blurRadius: AppDimens.dimens_10,
    //       spreadRadius: AppDimens.dimens_2,
    //     ), //BoxShadow
    //     BoxShadow(
    //       color: Colors.white,
    //       offset: const Offset(0.0, 0.0),
    //       blurRadius: 0.0,
    //       spreadRadius: 0.0,
    //     ), //BoxShadow
    //   ],
    // ); //Box
  }

  static getBoxDecorColorVise(Color mColor) {
    return BoxDecoration(
      color: mColor,
      borderRadius: BorderRadius.circular(AppDimens.dimens_2),
    );
  }

  static getFadeInNetworkImage(
      {required double height, required double width, required String image}) {
    if (height != 0 && width != 0) {
      return FadeInImage.assetNetwork(
          placeholder: AppImages.ic_place_holder,
          height: height,
          width: width,
          image: image,
          imageErrorBuilder: (BuildContext? context, Object? exception,
              StackTrace? stackTrace) {
            return AppViews.getErrorImage(height, width);
          },
          fit: BoxFit.contain);
    } else if (height != 0) {
      return FadeInImage.assetNetwork(
          placeholder: AppImages.ic_place_holder,
          height: height,
          image: image,
          imageErrorBuilder: (BuildContext? context, Object? exception,
              StackTrace? stackTrace) {
            return AppViews.getErrorImage(height, AppDimens.dimens_200);
          },
          fit: BoxFit.contain);
    } else if (width != 0) {
      return FadeInImage.assetNetwork(
          placeholder: AppImages.ic_place_holder,
          width: width,
          image: image,
          imageErrorBuilder: (BuildContext? context, Object? exception,
              StackTrace? stackTrace) {
            return AppViews.getErrorImage(AppDimens.dimens_200, width);
          },
          fit: BoxFit.contain);
    }
  }

  static getAddressTypeIcon(String strAddressType) {
    Widget mIcon = const Icon(Icons.location_on_outlined);
    if (Global.checkNull(strAddressType)) {
      switch (strAddressType) {
        case "home":
          mIcon = const Icon(Icons.home_outlined);
          break;
        case "work":
          mIcon = const Icon(Icons.work_outline);
          break;
        case "other":
          mIcon = const Icon(Icons.location_on_outlined);
          break;
        default:
          mIcon = const Icon(Icons.location_on_outlined);
          break;
      }
    }
    return mIcon;
  }

  static BoxDecoration getBoxDecorationByStatus(bool isSelected) {
    return BoxDecoration(
      border: Border(
        bottom: BorderSide(
          //                   <--- left side
          color: isSelected
              ? AppColors.colorAccent
              : Colors.black.withOpacity(0.5),
          width: 2.5,
        ),
      ),
    );
  }

  static Color getColourByStatus(bool isSelected) {
    return isSelected ? AppColors.colorAccent : AppColors.colorTextFieldHint;
  }

  static showCustomAlert(
      {required BuildContext context,
      required String strTitle,
      required String strMessage,
      String? strLeftBtnText,
      String? strRightBtnText,
      Function? onTapLeftBtn,
      Function? onTapRightBtn}) {
    return showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return Directionality(
            textDirection: TextDirection.ltr,
            child: Material(
              color: Colors.transparent,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, bottom: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            strTitle,
                            style: AppStyle.textViewStyleLarge(
                                fontWeightDelta: 2,
                                fontSizeDelta: 2,
                                context: context,
                                color: AppColors.colorBlack),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            strMessage,
                            style: AppStyle.textViewStyleLarge(
                                fontWeightDelta: -1,
                                fontSizeDelta: 1,
                                context: context,
                                color: AppColors.colorBlack.withOpacity(0.7)),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            margin: const EdgeInsets.only(
                                right: AppDimens.dimens_10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Global.checkNull(strLeftBtnText)
                                    ? TextButton(
                                        style: TextButton.styleFrom(
                                            foregroundColor:
                                                AppColors.colorAccent,
                                            disabledForegroundColor:
                                                AppColors.colorAccent,
                                            backgroundColor:
                                                AppColors.colorAccent),
                                        onPressed: () {
                                          if (onTapLeftBtn != null) {
                                            onTapLeftBtn();
                                          } else {
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: Text(
                                          strLeftBtnText!,
                                          style: AppStyle
                                              .textViewStyleNormalButton(
                                                  context: context,
                                                  fontWeightDelta: 2,
                                                  fontSizeDelta: 1,
                                                  color: AppColors.colorWhite),
                                        ),
                                      )
                                    : const SizedBox(
                                        height: 0,
                                        width: 0,
                                      ),
                                const SizedBox(
                                  height: 0,
                                  width: 10,
                                ),
                                Global.checkNull(strRightBtnText)
                                    ? TextButton(
                                        style: TextButton.styleFrom(
                                            foregroundColor:
                                                AppColors.colorAccent,
                                            disabledForegroundColor: AppColors
                                                .colorAccent
                                                .withOpacity(0.38),
                                            backgroundColor:
                                                AppColors.colorAccent),
                                        onPressed: () {
                                          if (onTapRightBtn != null) {
                                            onTapRightBtn();
                                          } else {
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: Text(
                                          strRightBtnText!,
                                          style: AppStyle
                                              .textViewStyleNormalButton(
                                                  context: context,
                                                  fontWeightDelta: 2,
                                                  fontSizeDelta: 1,
                                                  color: AppColors.colorWhite),
                                        ),
                                      )
                                    : const SizedBox(
                                        height: 0,
                                        width: 0,
                                      ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  static getGradientBoxDecoration({double? mBorderRadius}) {
    return BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.colorBlueEnd,
            AppColors.colorBlueStart,
          ],
        ),
        borderRadius: BorderRadius.circular(mBorderRadius ?? 0));
  }

  static getGreyGradientBoxDecoration({double? mBorderRadius}) {
    return BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.grayStart,
            AppColors.grayEnd,
          ],
        ),
        borderRadius: BorderRadius.circular(mBorderRadius ?? 0));
  }

  static getGrayDecoration({double? mBorderRadius}) {
    return BoxDecoration(
        color: AppColors.greyOTPBg,
        borderRadius: BorderRadius.circular(mBorderRadius ?? 0));
  }

  static getColorDecor({double? mBorderRadius, required Color mColor}) {
    return BoxDecoration(
        color: mColor, borderRadius: BorderRadius.circular(mBorderRadius ?? 0));
  }

  static getRoundBorderDecor({double? mBorderRadius, required Color mColor}) {
    return BoxDecoration(
        border: Border.all(color: mColor),
        borderRadius: BorderRadius.circular(mBorderRadius ?? 0));
  }

  static textFieldGrayRoundBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        width: 1,
        color: AppColors.greyOTPBg,
        style: BorderStyle.none,
      ),
    );
  }

  static textFieldRoundBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide:  BorderSide(
        width: 2,
        color: AppColors.colorAccent,
        style: BorderStyle.solid,
      ),
    );
  }

  static shimmerChat() {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: AppColors.colorChatBgLeft,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(AppDimens.dimens_10)),
                      ),
                      padding: const EdgeInsets.all(AppDimens.dimens_12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 20,
                            width: 100,
                            color: Colors.grey.shade400,
                          ),
                          Container(
                            height: 20,
                            color: Colors.grey.shade100,
                          ),
                        ],
                      )),
                ],
              )),
            ],
          ),
        ));
  }

  static shimmerNotification() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(5)),
              margin: const EdgeInsets.only(
                right: AppDimens.dimens_10,
              ),
              // child:
              //  ClipRRect(
              //   borderRadius: BorderRadius.circular(AppDimens.dimens_5),
              //   child: NetworkImageCustom(
              //       image: Global.checkNull(mNotificationModel.image)
              //           ? mNotificationModel.image
              //           : "https://qph.cf2.quoracdn.net/main-thumb-1278318002-200-ydzfegagslcexelzgsnplcklfkienzfr.jpeg",
              //       fit: BoxFit.fill,
              //       height: 90,
              //       width: 90),
              // ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 25,
                  width: 200,
                  color: Colors.grey.shade300,

                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(
                      top: AppDimens.dimens_5, bottom: AppDimens.dimens_5),
                  // child:
                  // Text(
                  //   mNotificationModel.type.contains('estimate')
                  //       ? 'Estimation Submitted '
                  //       : mNotificationModel.title,
                  //   maxLines: 2,
                  //   style: AppStyle.textViewStyleNormalBodyText2(
                  //       context: context,
                  //       color: AppColors.grayDashboardText,
                  //       fontSizeDelta: 0,
                  //       fontWeightDelta: 2),
                  // )
                ),
                const SizedBox(height: 10),
                Container(
                  height: 20,
                  width: 100,
                  color: Colors.grey.shade300,
                  margin: const EdgeInsets.only(bottom: AppDimens.dimens_5),
                  alignment: Alignment.centerLeft,
                  // child:
                  //  Text(
                  //   mNotificationModel.getDate(),
                  //   style: AppStyle.textViewStyleSmall(
                  //       context: context,
                  //       color: AppColors.grayDashboardText,
                  //       fontSizeDelta: -2,
                  //       fontWeightDelta: 0),
                  // )
                ),
              ],
            )),
            // SizedBox(
            //   height: 90,

            //   child: Icon(Icons.arrow_forward_ios_rounded,
            //       size: AppDimens.dimens_13, color: AppColors.colorBlueStart),
            // )
          ],
        ),
      ),
    );
  }
}

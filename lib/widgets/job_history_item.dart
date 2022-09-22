import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/controllers/booking_history_controllers/inprogress_booking_controller.dart';
import 'package:otobucks/custom_ui/loader/circle.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/model/estimates_model.dart';
import 'package:otobucks/widgets/fade_in_image.dart';

import 'gradient_text.dart';

// ignore: must_be_immutable
class JobHistoryItem extends StatelessWidget {
  EstimatesModel mEstimatesModel;
  EstimationStatus mEstimationStatus;
  Function onTapMain;
  Function? onTapChatNow;
  Function? onTapRateNow;
  Function? onTapReBook;

  JobHistoryItem(
      {Key? key,
      required this.onTapMain,
      this.onTapChatNow,
      this.onTapRateNow,
      this.onTapReBook,
      required this.mEstimatesModel,
      required this.mEstimationStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget mRow = Flexible(
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Constants.TXT_VIEW_BOOKING,
                    style: AppStyle.textViewStyleSmall(
                        context: context,
                        color: AppColors.colorTextBlue2,
                        fontSizeDelta: -2,
                        fontWeightDelta: 0),
                  )),
              onTap: () {
                onTapMain();
              },
            ),
            Container(
                alignment: Alignment.centerLeft,
                child: GradientText(
                  mEstimatesModel.status,
                  style: AppStyle.textViewStyleNormalBodyText2(
                      context: context,
                      color: AppColors.grayDashboardText,
                      fontSizeDelta: 0,
                      fontWeightDelta: 1),
                )),
          ],
        ),
      ),
    );
    switch (mEstimatesModel.status) {
      case 'pending':
        mRow = Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              child: Container(
                  height: 30,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Constants.TXT_VIEW_BOOKING,
                    style: AppStyle.textViewStyleSmall(
                        context: context,
                        color: AppColors.colorTextBlue2,
                        fontSizeDelta: -2,
                        fontWeightDelta: 0),
                  )),
              onTap: () {
                onTapMain();
              },
            ),
            Container(
                alignment: Alignment.centerLeft,
                child: GradientText(
                  mEstimatesModel.status,
                  style: AppStyle.textViewStyleNormalBodyText2(
                      context: context,
                      color: AppColors.grayDashboardText,
                      fontSizeDelta: 0,
                      fontWeightDelta: 1),
                )),
          ],
        );
        break;
      case 'inProgress':
        mRow = Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: InkWell(
                child: Container(
                    height: 30,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      Constants.TXT_VIEW_BOOKING,
                      style: AppStyle.textViewStyleSmall(
                          context: context,
                          color: AppColors.colorTextBlue2,
                          fontSizeDelta: -2,
                          fontWeightDelta: 0),
                    )),
                onTap: () {
                  onTapMain();
                },
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: GetBuilder<InProgressBookingController>(builder: (value) {
                return value.chatNowLoading
                    ? Center(
                        child: SpinKitCircle(
                          color: AppColors.colorBlueStart,
                          size: 15,
                          key: const ValueKey(''),
                        ),
                      )
                    : InkWell(
                        child: Container(
                            height: AppDimens.dimens_23,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(
                                top: AppDimens.dimens_4,
                                bottom: AppDimens.dimens_4,
                                left: AppDimens.dimens_6,
                                right: AppDimens.dimens_6),
                            decoration: AppViews.getGradientBoxDecoration(
                                mBorderRadius: AppDimens.dimens_12),
                            child: Text(
                              Constants.TXT_CHAT_NOW,
                              style: AppStyle.textViewStyleSmall(
                                  context: context,
                                  color: AppColors.colorWhite,
                                  fontSizeDelta: -3,
                                  fontWeightDelta: 2),
                            )),
                        onTap: () {
                          if (onTapChatNow != null) {
                            onTapChatNow!();
                          }
                        },
                      );
              }),
            ),
          ],
        );
        break;
      case 'completed':
        mRow = Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: InkWell(
                child: Container(
                    height: 30,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      Constants.TXT_RATE_THIS_SERVICE,
                      style: AppStyle.textViewStyleSmall(
                          context: context,
                          color: AppColors.colorTextBlue2,
                          fontSizeDelta: -3,
                          fontWeightDelta: 0),
                    )),
                onTap: () {
                  if (onTapRateNow != null) {
                    onTapRateNow!();
                  }
                },
              ),
            ),
            Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  mEstimatesModel.status,
                  style: AppStyle.textViewStyleNormalBodyText2(
                      context: context,
                      color: AppColors.colorGreen,
                      fontSizeDelta: 0,
                      fontWeightDelta: 1),
                )),
          ],
        );
        break;
      case 'cancelled':
        mRow = Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              child: Container(
                  height: 30,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Constants.TXT_REBOOK,
                    style: AppStyle.textViewStyleSmall(
                        context: context,
                        color: AppColors.colorTextBlue2,
                        fontSizeDelta: -2,
                        fontWeightDelta: 0),
                  )),
              onTap: () {
                if (onTapReBook != null) {
                  onTapReBook!();
                }
              },
            ),
            Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  mEstimatesModel.status,
                  style: AppStyle.textViewStyleNormalBodyText2(
                      context: context,
                      color: AppColors.colorRED,
                      fontSizeDelta: 0,
                      fontWeightDelta: 1),
                )),
          ],
        );
        break;
    }
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimens.dimens_14),
      color: Colors.transparent,
      child: Card(
          elevation: AppDimens.dimens_3,
          shadowColor: Colors.black54,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.dimens_5),
          ),
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
                      borderRadius: BorderRadius.circular(AppDimens.dimens_5),
                      child: NetworkImageCustom(
                          image: mEstimatesModel.getProviderImage(),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  mEstimatesModel.getProviderName(),
                                  style: AppStyle.textViewStyleNormalBodyText2(
                                      context: context,
                                      color: AppColors.grayDashboardText,
                                      fontSizeDelta: 1,
                                      fontWeightDelta: 1),
                                )),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: GradientText(
                                  "",
                                  style: AppStyle.textViewStyleNormalBodyText2(
                                      context: context,
                                      color: AppColors.grayDashboardText,
                                      fontSizeDelta: 2,
                                      fontWeightDelta: 3),
                                )),
                          ],
                        ),
                        margin: const EdgeInsets.only(
                            top: AppDimens.dimens_5,
                            bottom: AppDimens.dimens_5),
                      ),
                      //Date
                      Container(
                          margin:
                              const EdgeInsets.only(bottom: AppDimens.dimens_5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            mEstimatesModel.getDate(),
                            style: AppStyle.textViewStyleSmall(
                                context: context,
                                color: AppColors.grayDashboardText,
                                fontSizeDelta: -2,
                                fontWeightDelta: 0),
                          )),
                      mRow
                    ],
                  )),
                ],
              ),
            ),
            onTap: () {
              // onTapMain();
            },
          )),
    );
  }
}

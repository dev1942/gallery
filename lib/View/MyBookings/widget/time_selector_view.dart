import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/model/time_model.dart';



// ignore: must_be_immutable
class TimeViewSelector extends StatefulWidget {
  //TimeModel? mTimeModel;
  String selectedDate;
  Function onSelection;

  TimeViewSelector(
      {Key? key,
       // this.mTimeModel,
        required this.selectedDate,
        required this.onSelection})
      : super(key: key);

  @override
  TimeViewSelectorState createState() => TimeViewSelectorState();
}

class TimeViewSelectorState extends State<TimeViewSelector> {
  List<TimeModel> alTimeModel = [];

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    //alTimeModel = Global.getTimeList(widget.mTimeModel);
    //timer();
  }

  // timer() {
  //   var _duration = const Duration(seconds: 1);
  //   return Timer(_duration, scrollToPosition);
  // }

  scrollToPosition() {
    for (var element in alTimeModel) {
      if (element.isSelected) {
        widget.onSelection(element);
      }
    }
    for (int itemIndex = 0; itemIndex < alTimeModel.length; itemIndex++) {
      TimeModel selected = alTimeModel[itemIndex];
      if (selected.isSelected) {
        _animateToIndex(itemIndex);
      }
    }
  }

  void _animateToIndex(int index) {
    _controller.animateTo(
      index * AppDimens.dimens_60,
      duration: const Duration(seconds: 1),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: _controller,
        padding: const EdgeInsets.only(left: 0),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext contextM, index) {
          TimeModel mTimeModel = alTimeModel[index];
          Color textColor = AppColors.colorBlack;
          var mBoxDecoration = AppViews.getColorDecor(
              mColor: AppColors.greyDateBG, mBorderRadius: AppDimens.dimens_5);

          if (mTimeModel.isSelected) {
            textColor = AppColors.colorWhite;
            mBoxDecoration = AppViews.getGradientBoxDecoration(
                mBorderRadius: AppDimens.dimens_5);
          }
          return InkWell(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(
                  left: AppDimens.dimens_10, right: AppDimens.dimens_10),
              margin: const EdgeInsets.only(
                  bottom: AppDimens.dimens_15, right: AppDimens.dimens_15),
              decoration: mBoxDecoration,
              child: Text(
                mTimeModel.time_24hr,
                style: AppStyle.textViewStyleSmall(
                    context: context, color: textColor, fontWeightDelta: -2),
                maxLines: 1,
              ),
            ),
            onTap: () {
              setState(() {
                DateType mDateType = Global.checkIsToday(widget.selectedDate);

                switch (mDateType) {
                  case DateType.today:
                    int hour = DateTime.now().hour;
                    for (var element in alTimeModel) {
                      element.isSelected = false;
                      if (hour >= element.t24hr) {
                        element.isEnable = false;
                      }
                    }
                    if (mTimeModel.isEnable) {
                      mTimeModel.isSelected = true;
                      widget.onSelection(mTimeModel);
                    } else {
                      Global.showToastAlert(
                          context: context,
                          strTitle: "",
                          strMsg: AppAlert.ALERT_PLEASE_SELECT_FUTURE_TIME,
                          toastType: TOAST_TYPE.toastWarning);
                    }
                    break;
                  case DateType.past:
                    for (var element in alTimeModel) {
                      element.isSelected = false;
                      element.isEnable = false;
                    }
                    if (mTimeModel.isEnable) {
                      mTimeModel.isSelected = true;
                      widget.onSelection(mTimeModel);
                    } else {
                      Global.showToastAlert(
                          context: context,
                          strTitle: "",
                          strMsg:
                          AppAlert.ALERT_PLEASE_SELECT_FUTURE_DATE_AND_TIME,
                          toastType: TOAST_TYPE.toastWarning);
                    }

                    break;
                  case DateType.none:
                    for (var element in alTimeModel) {
                      element.isSelected = false;
                    }
                    mTimeModel.isSelected = true;
                    widget.onSelection(mTimeModel);
                    break;
                }

                // if (mDateType == DateType.TODAY) {
                //   int hour = DateTime.now().hour;
                //   alTimeModel.forEach((element) {
                //     element.isSelected = false;
                //     if (hour >= element.t24hr) {
                //       element.isEnable = false;
                //     }
                //   });
                //   if (mTimeModel.isEnable) {
                //     mTimeModel.isSelected = true;
                //     widget.onSelection(mTimeModel);
                //   } else {
                //     Global.showToastAlert(
                //         context: context,
                //         strTitle: "",
                //         strMsg: AppAlert.ALERT_PLEASE_SELECT_FUTURE_TIME,
                //         mTOAST_TYPE: TOAST_TYPE.TOAST_WARNING);
                //   }
                // } else {
                //
                // }
              });

              },
          );
        },
        itemCount: alTimeModel.length);
  }
}

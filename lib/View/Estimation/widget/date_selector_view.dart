import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/model/date_model.dart';



// ignore: must_be_immutable
class DateViewSelector extends StatefulWidget {
  Function onSelection;
  Function? clearTimeSelection;
  DateTime? selectedDate;

  DateViewSelector(
      {Key? key,
        required this.onSelection,
        this.clearTimeSelection,
        this.selectedDate})
      : super(key: key);

  @override
  DateViewSelectorState createState() => DateViewSelectorState();
}

class DateViewSelectorState extends State<DateViewSelector> {
  List<DateModel> alDatesOfMonth = [];
  List<String> alDateModel = [];
  late String? dropdownValue = "";
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    alDateModel = Global.getMonthList(selectedDate: widget.selectedDate);
    dropdownValue = alDateModel.first;
    alDatesOfMonth = Global.getDayOfMonth(alDateModel.first);

    if (widget.selectedDate != null) {
      String mMonth =
      DateFormat(Constants.STRING_MMMM_yyyy).format(widget.selectedDate!);
      if (alDateModel.contains(mMonth)) {
        dropdownValue = mMonth;
        alDatesOfMonth =
            Global.getDayOfMonth(mMonth, selectedDate: widget.selectedDate);

        timer();
      }
    }
  }

  timer() {
    var _duration = const Duration(seconds: 1);
    return Timer(_duration, scrollToPosition);
  }

  scrollToPosition() {
    for (var element in alDatesOfMonth) {
      if (element.isSelected) {
        widget.onSelection(element.getDateString());
      }
    }
    for (int itemIndex = 0; itemIndex < alDatesOfMonth.length; itemIndex++) {
      DateModel selected = alDatesOfMonth[itemIndex];
      if (selected.isSelected) {
        _animateToIndex(itemIndex);
      }
    }
  }

  void _animateToIndex(int index) {
    _controller.animateTo(
      index * AppDimens.dimens_60,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimens.dimens_150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.keyboard_arrow_down_outlined),
            elevation: 16,
            style: AppStyle.textViewStyleNormalBodyText2(
                context: context, color: AppColors.colorBlack),
            underline: Container(
              height: 0,
            ),
            onChanged: (String? newValue) {
              /*
              DateTime parseDate =
              DateFormat(Constants.STRING_MMMM_yyyy).parse(newValue!);
              DateTime currentDate =
              DateTime(DateTime.now().year, DateTime.now().month);
              int diff = parseDate.difference(currentDate).inDays;
              if (diff >= 0) {
                setState(() {
                  dropdownValue = newValue.toString();
                  alDatesOfMonth = Global.getDayOfMonth(newValue.toString(),
                      selectedDate: DateTime.now());
                });
              } else {
                Global.showToastAlert(
                    context: context,
                    strTitle: "",
                    strMsg: "Please select a future month.",
                    toastType: TOAST_TYPE.toastWarning);
              }
              */
            },
            items: alDateModel.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                enabled: false,
                child: Text(
                  value,
                  style: AppStyle.textViewStyleNormalBodyText2(
                      context: context, color: AppColors.colorBlack),
                ),
              );
            }).toList(),
          ),
          SizedBox(
            height: AppDimens.dimens_90,
            child: ListView.builder(
                controller: _controller,
                padding: const EdgeInsets.only(left: 0),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext contextM, index) {
                  DateModel mTimeModel = alDatesOfMonth[index];
                  Color textColor = AppColors.colorBlack;
                  var mBoxDecoration = AppViews.getColorDecor(
                      mColor: AppColors.greyDateBG,
                      mBorderRadius: AppDimens.dimens_5);

                  if (mTimeModel.isSelected) {
                    textColor = AppColors.colorWhite;
                    mBoxDecoration = AppViews.getGradientBoxDecoration(
                        mBorderRadius: AppDimens.dimens_5);
                  }
                  return Container(
                    width: AppDimens.dimens_50,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(
                        left: AppDimens.dimens_10, right: AppDimens.dimens_10),
                    margin: const EdgeInsets.only(
                        bottom: AppDimens.dimens_15,
                        right: AppDimens.dimens_15),
                    decoration: mBoxDecoration,
                    child: InkWell(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            mTimeModel.date,
                            textAlign: TextAlign.center,
                            style: AppStyle.textViewStyleSmall(
                                context: context,
                                color: textColor,
                                fontWeightDelta: 1),
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: AppDimens.dimens_5,
                          ),
                          Text(
                            mTimeModel.daysOfTheWeek,
                            textAlign: TextAlign.center,
                            style: AppStyle.textViewStyleSmall(
                                context: context,
                                color: textColor,
                                fontWeightDelta: -2),
                            maxLines: 1,
                          ),
                        ],
                      ),
                      onTap: () {


                        // DateType mDateType =
                        // Global.checkIsToday(mTimeModel.getDateString());
                        //
                        // switch (mDateType) {
                        //   case DateType.past:
                        //     if (widget.clearTimeSelection != null) {
                        //       widget.clearTimeSelection!();
                        //     }
                        //     Global.showToastAlert(
                        //         context: context,
                        //         strTitle: "",
                        //         strMsg: "Please select a future month & date.",
                        //         toastType: TOAST_TYPE.toastWarning);
                        //     break;
                        //   case DateType.today:
                        //   case DateType.none:
                        //     setState(() {
                        //       for (var element in alDatesOfMonth) {
                        //         element.isSelected = false;
                        //       }
                        //       mTimeModel.isSelected = true;
                        //
                        //       widget.onSelection(mTimeModel.getDateString());
                        //     });
                        //     break;
                        // }
                      },
                    ),
                  );
                },
                itemCount: alDatesOfMonth.length),
          )
        ],
      ),
    );
  }
}

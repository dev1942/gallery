import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/MyBookings/controller/reschedule_booking_controller.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/app_views.dart';

// ignore: must_be_immutable
class TimeRescheduleSelector extends StatefulWidget {
  String selectedDate;
  //Function onSelection;
  String? time;
  bool isPending;

  TimeRescheduleSelector({
    Key? key,
    this.time,
    this.isPending = false,
    required this.selectedDate,
    // required this.onSelection
  }) : super(key: key);

  @override
  TimeRescheduleSelectorState createState() => TimeRescheduleSelectorState();
}

class TimeRescheduleSelectorState extends State<TimeRescheduleSelector> {
  var reScheduleController = Get.put(RescheduleBookingController());
  List<String> timesList = ["09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00", "20:00"];
  final ScrollController _controller = ScrollController();
  int selectedindex = 0;
  @override
  void initState() {
    super.initState();

    if (timesList.contains(widget.time!)) {
      selectedindex = timesList.indexOf(widget.time!);
      reScheduleController.selectedTime = timesList[selectedindex];
    } else {
      reScheduleController.selectedTime = timesList[selectedindex];
    }
  }

  // void _animateToIndex(int index) {
  //   _controller.animateTo(
  //     index * AppDimens.dimens_60,
  //     duration: const Duration(seconds: 1),
  //     curve: Curves.ease,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _controller,
      padding: const EdgeInsets.only(left: 0),
      scrollDirection: Axis.horizontal,
      itemCount: timesList.length, //12,//alTimeModel.length,
      itemBuilder: (BuildContext contextM, index) {
        //TimeModel mTimeModel = alTimeModel[index];
        Color textColor = AppColors.colorBlack;
        var mBoxDecoration = AppViews.getColorDecor(mColor: AppColors.greyDateBG, mBorderRadius: AppDimens.dimens_5);
        if (index == selectedindex) {
          textColor = AppColors.colorWhite;
          mBoxDecoration = AppViews.getGradientBoxDecoration(mBorderRadius: AppDimens.dimens_5);
        }
        return InkWell(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: AppDimens.dimens_10, right: AppDimens.dimens_10),
            margin: const EdgeInsets.only(bottom: AppDimens.dimens_15, right: AppDimens.dimens_15),
            decoration: mBoxDecoration,
            child: Text(
              timesList[index],
              style: AppStyle.textViewStyleSmall(context: context, color: textColor, fontWeightDelta: -2),
              maxLines: 1,
            ),
          ),
          onTap: widget.isPending
              ? () {
                  setState(() {
                    selectedindex = index;
                    reScheduleController.selectedTime = timesList[selectedindex];
                  });
                }
              : () {},
        );
      },
    );
  }
}

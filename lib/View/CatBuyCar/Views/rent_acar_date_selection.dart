import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/widgets/small_button.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../global/app_colors.dart';
import '../../../global/app_dimens.dart';
import '../../../global/app_style.dart';
import '../../../global/app_views.dart';
import '../../../global/constants.dart';
import '../../../widgets/custom_textfield_with_icon.dart';

class RentCarDateSelectionFragment extends StatefulWidget {
  const RentCarDateSelectionFragment({Key? key}) : super(key: key);

  @override
  RentCarDateSelectionFragmentState createState() => RentCarDateSelectionFragmentState();
}

class RentCarDateSelectionFragmentState extends State<RentCarDateSelectionFragment> {
  var initialDate = "14-11-2021";
  var endDate = "20-11-2021";
  TextEditingController controllerPickUp = TextEditingController();
  FocusNode mFocusNodePickUp = FocusNode();
  TextEditingController controllerDropOff = TextEditingController();
  FocusNode mFocusNodeDropOff = FocusNode();
  TextEditingController controllerNote = TextEditingController();
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    // TODO: implement your code here
  }
  List<String> createTimeSlot(Duration startTime, Duration endTime, BuildContext context,
      {Duration step = const Duration(minutes: 30)} // Gap between interval
      ) {
    var timeSlot = <String>[];

    var hourStartTime = startTime.inHours;
    var minuteStartTime = startTime.inMinutes.remainder(60);

    var hourEndTime = endTime.inHours;
    var minuteEndTime = endTime.inMinutes.remainder(60);

    do {
      timeSlot.add(TimeOfDay(hour: hourStartTime, minute: minuteStartTime).format(context));
      minuteStartTime += step.inMinutes;
      while (minuteStartTime >= 60) {
        minuteStartTime -= 60;
        hourStartTime++;
      }
    } while (hourStartTime < hourEndTime || (hourStartTime == hourEndTime && minuteStartTime <= minuteEndTime));

    debugPrint("Number of slot $timeSlot");

    return timeSlot;
  }

  @override
  Widget build(BuildContext context) {
    var timeList = createTimeSlot(const Duration(hours: 1, minutes: 30), const Duration(hours: 3, minutes: 30), context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.getMainBgColor(),
      appBar: AppViews.initAppBar(
        mContext: context,
        centerTitle: false,
        strTitle: 'Pick up a Date & time',
        isShowNotification: true,
        isShowSOS: true,
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                color: AppColors.colorBlueStart,
                width: double.infinity,
                height: AppDimens.dimens_170,
              ),
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 10,
                    margin: const EdgeInsets.only(
                        bottom: AppDimens.dimens_14, top: AppDimens.dimens_14, left: AppDimens.dimens_20, right: AppDimens.dimens_20),
                    // height: AppDimens.dimens_190,
                    child: SfDateRangePicker(
                      onSelectionChanged: _onSelectionChanged,
                      selectionMode: DateRangePickerSelectionMode.range,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "From",
                              style: TextStyle(color: Colors.black, fontSize: size.width * 0.039),
                            ),
                            Text(
                              initialDate,
                              style: TextStyle(color: Colors.grey, fontSize: size.width * 0.034),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "To",
                              style: TextStyle(color: Colors.black, fontSize: size.width * 0.039),
                            ),
                            Text(
                              endDate,
                              style: TextStyle(color: Colors.grey, fontSize: size.width * 0.034),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    child: const Text(
                      'Body Type',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(left: size.width * 0.045),
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10,
                      ),
                      itemCount: timeList.length,
                      padding: const EdgeInsets.all(4),
                      // shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Material(
                        borderRadius: BorderRadius.circular(9),
                        elevation: 2,
                        child: Container(
                          // margin: EdgeInsets.only(right: 10),

                          width: size.width * 0.18,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                          child: Center(child: Text(timeList[index])),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    child: const Text(
                      'Pickup Location',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CustomTextFieldWithIcon(
                        textInputAction: TextInputAction.next,
                        enabled: true,
                        focusNode: mFocusNodePickUp,
                        controller: controllerPickUp,
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'PickUp',
                        inputFormatters: const [],
                        obscureText: false,
                        onChanged: (String value) {},
                        suffixIcon: Container()),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    child: const Text(
                      'Dropoff Location',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CustomTextFieldWithIcon(
                        textInputAction: TextInputAction.next,
                        enabled: true,
                        focusNode: mFocusNodeDropOff,
                        controller: controllerDropOff,
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Dropoff',
                        inputFormatters: const [],
                        obscureText: false,
                        onChanged: (String value) {},
                        suffixIcon: Container()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _anyNoteTextFiledSection(controllerNote),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    // margin: EdgeInsets.only(right: 10),
                    height: 60,
                    width: size.width * 0.4,
                    margin: EdgeInsets.symmetric(horizontal: size.width * 0.045),
                    child: PrimaryButton(
                      label: const Text(
                        'Next',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: null,
                      onPress: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RentCarDateSelectionFragment()));
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // DashboardItemList(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  _anyNoteTextFiledSection(TextEditingController leaveNotesController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: AppDimens.dimens_20,
            left: AppDimens.dimens_14,
            right: AppDimens.dimens_14,
          ),
          child: Text(
            Constants.STR_LEAVE_NOTE.tr,
            style: AppStyle.textViewStyleNormalSubtitle2(context: context, color: AppColors.colorBlack2, fontWeightDelta: 1, fontSizeDelta: 0),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            top: AppDimens.dimens_10,
            left: AppDimens.dimens_14,
            right: AppDimens.dimens_14,
          ),
          decoration: AppViews.getGrayDecoration(mBorderRadius: AppDimens.dimens_5),
          child: TextField(
            onChanged: (String? strvalue) {
              // log("-------------------");
              // log(strvalue);
              // reScheduleController.controllerNote.text=strvalue;
            },
            onSubmitted: (String? value) {
              //onSubmit!(value!);
            },
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            maxLines: 3,
            style: AppStyle.textViewStyleNormalBodyText2(color: AppColors.colorBlack, fontSizeDelta: 0, fontWeightDelta: 0, context: context),
            controller: leaveNotesController, //reScheduleController.controllerNote,
            textAlign: TextAlign.start,
            readOnly: false,
            decoration: InputDecoration(
              prefixIconConstraints: const BoxConstraints(minWidth: AppDimens.dimens_33),
              suffixIconConstraints: const BoxConstraints(minWidth: AppDimens.dimens_33),
              suffixIcon: Container(
                margin: const EdgeInsets.only(right: AppDimens.dimens_12),
                alignment: Alignment.center,
                width: AppDimens.dimens_50,
              ),
              contentPadding: const EdgeInsets.only(top: AppDimens.dimens_7, left: AppDimens.dimens_15),
              focusedBorder: AppViews.textFieldRoundBorder(),
              border: AppViews.textFieldRoundBorder(),
              disabledBorder: AppViews.textFieldRoundBorder(),
              focusedErrorBorder: AppViews.textFieldRoundBorder(),
              hintText: "Write a message...".tr,
              // filled: true,
              fillColor: AppColors.colorGray2,
              hintStyle:
                  AppStyle.textViewStyleNormalBodyText2(color: AppColors.colorTextFieldHint, fontSizeDelta: 0, fontWeightDelta: 0, context: context),
            ),
          ),
        )
      ],
    );
  }
}

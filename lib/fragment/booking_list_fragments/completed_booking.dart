import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/controllers/booking_history_controllers/completed_booking_controller.dart';

import '../../global/app_colors.dart';
import '../../global/app_dimens.dart';
import '../../global/app_views.dart';
import '../../global/enum.dart';
import '../../model/estimates_model.dart';
import '../../widgets/job_history_item.dart';

class CompletedBooking extends StatefulWidget {
  final String status;
  final String screen;
  const CompletedBooking({Key? key, required this.status, required this.screen})
      : super(key: key);

  @override
  CompletedBookingState createState() => CompletedBookingState();
}

class CompletedBookingState extends State<CompletedBooking> {
  var controller = Get.put(CompletedBookingController());
  @override
  void initState() {
    controller.getEstimation(widget.status);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.getMainBgColor(),
        body: GetBuilder<CompletedBookingController>(
          init: CompletedBookingController(),
          builder: ((value) => AppViews.getSetData(
              context,
              value.mShowData,
              ListView.builder(
                  padding: const EdgeInsets.all(AppDimens.dimens_10),
                  itemBuilder: (BuildContext contextM, index) {
                    EstimatesModel mEstimatesModel = value.alEstimates[index];
                    return JobHistoryItem(
                      mEstimatesModel: mEstimatesModel,
                      mEstimationStatus: EstimationStatus.pending,
                      onTapMain: () {
                        value.gotoViewEstimation(
                            mEstimatesModel, widget.screen, context);
                      },
                      onTapRateNow: () {
                        value.gotoRating(mEstimatesModel, context);
                      },
                    );
                  },
                  itemCount: value.alEstimates.length))),
        ));
  }
}

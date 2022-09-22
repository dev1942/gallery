import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/controllers/booking_history_controllers/cancelled_booking_controller.dart';

import '../../global/app_colors.dart';
import '../../global/app_dimens.dart';
import '../../global/app_views.dart';
import '../../global/enum.dart';
import '../../model/estimates_model.dart';
import '../../widgets/job_history_item.dart';

class CancelledBooking extends StatefulWidget {
  final String status;
  final String screen;
  const CancelledBooking({Key? key, required this.status, required this.screen})
      : super(key: key);

  @override
  CancelledBookingState createState() => CancelledBookingState();
}

class CancelledBookingState extends State<CancelledBooking> {
  var controller = Get.put(CancelBookingController());
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
        body: GetBuilder<CancelBookingController>(
          init: CancelBookingController(),
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
                      onTapReBook: () {
                        value.gotoViewEstimation(
                            mEstimatesModel, widget.screen, context);
                      },
                    );
                  },
                  itemCount: value.alEstimates.length))),
        ));
  }
}

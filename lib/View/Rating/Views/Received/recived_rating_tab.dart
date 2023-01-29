import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/Home/Controllers/home_screen_controller.dart';
import 'package:otobucks/View/Rating/Views/Received/received_rating_controller.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/View/Rating/model/rating_component_model.dart';
import 'package:otobucks/services/repository/rating_repo.dart';
import 'package:otobucks/widgets/rating_list_item.dart';

import '../../../../../global/app_colors.dart';
import '../../../../../global/app_views.dart';
import '../../../../../global/enum.dart';
import '../../../../../global/global.dart';

class RecievedRatingTab extends StatefulWidget {
  const RecievedRatingTab({Key? key}) : super(key: key);

  @override
  RecievedRatingTabState createState() => RecievedRatingTabState();
}

class RecievedRatingTabState extends State<RecievedRatingTab> {
  var ratingController = Get.put(ReceivedRatingController());

  @override
  void initState() {
    // log(ratingController.alReviewModel.length.toString());
    if (ratingController.alReviewModel.value.isEmpty) {
      log("geting recieved rating");
      ratingController.getRating(context);
    }

    super.initState();
  }

  Future<void> pullrefresh() async {
    ratingController.getRating(context);
  }

  @override
  Widget build(BuildContext context) {
    Widget widgetM = Container();
    Widget mShowWidget = Obx(() => RefreshIndicator(
          onRefresh: pullrefresh,
          child: ListView.builder(
              padding: const EdgeInsets.all(AppDimens.dimens_10),
              itemBuilder: (BuildContext contextM, index) {
                RatingComponentModel ratingComponentModel = ratingController.alReviewModel.value[index];
                return RatingListItem(ratingComponentModel: ratingComponentModel, mRatingType: RatingType.recieved);
              },
              itemCount: ratingController.alReviewModel.value.length),
        ));

    // widgetM = ;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.getMainBgColor(),
        body: Obx(() {
          return Stack(
            children: [widgetM, AppViews.getSetData(context, ratingController.mShowData.value, mShowWidget)],
          );
        }));
  }
}

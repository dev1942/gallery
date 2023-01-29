import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:otobucks/View/Home/Controllers/home_screen_controller.dart';
import 'package:otobucks/View/Rating/Views/Given/givenRatingController.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/View/Rating/model/rating_component_model.dart';
import 'package:otobucks/services/repository/rating_repo.dart';

import '../../../../../global/app_colors.dart';
import '../../../../../global/app_views.dart';
import '../../../../../global/enum.dart';
import '../../../../../global/global.dart';
import '../../../../widgets/rating_list_item.dart';

class GivenRatingTab extends StatefulWidget {
  const GivenRatingTab({Key? key}) : super(key: key);

  @override
  GivenRatingTabState createState() => GivenRatingTabState();
}

class GivenRatingTabState extends State<GivenRatingTab> {
  var givenratingController = Get.put(GivenRatingController());

  @override
  void initState() {
    if (givenratingController.alReviewModel.isEmpty) {
      givenratingController.getRating(context);
    }

    super.initState();
  }

  Future<void> _pullToRefresh() async {
    givenratingController.getRating(context);
  }

  @override
  Widget build(BuildContext context) {
    Widget widgetM = Container();

    // Widget mShowWidget = );

    // widgetM = AppViews.getSetData(context, givenratingController.mShowData.value, mShowWidget);

    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.getMainBgColor(),
        body: Obx(() => Stack(
              children: [
                widgetM,
                AppViews.getSetData(
                    context,
                    givenratingController.mShowData.value,
                    Obx(() => RefreshIndicator(
                          onRefresh: _pullToRefresh,
                          child: ListView.builder(
                              padding: const EdgeInsets.all(AppDimens.dimens_10),
                              itemBuilder: (BuildContext contextM, index) {
                                RatingComponentModel ratingComponentModel = givenratingController.alReviewModel[index];
                                return RatingListItem(ratingComponentModel: ratingComponentModel, mRatingType: RatingType.given);
                              },
                              itemCount: givenratingController.alReviewModel.length),
                        )))
              ],
            )));
  }
}

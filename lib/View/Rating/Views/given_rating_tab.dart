import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:otobucks/View/Home/Controllers/home_screen_controller.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/View/Rating/model/rating_component_model.dart';
import 'package:otobucks/services/repository/rating_repo.dart';

import '../../../../global/app_colors.dart';
import '../../../../global/app_views.dart';
import '../../../../global/enum.dart';
import '../../../../global/global.dart';
import '../../../widgets/rating_list_item.dart';

class GivenRatingTab extends StatefulWidget {
  const GivenRatingTab({Key? key}) : super(key: key);

  @override
  GivenRatingTabState createState() => GivenRatingTabState();
}

class GivenRatingTabState extends State<GivenRatingTab> {
  ShowData mShowData = ShowData.showData;

  bool connectionStatus = false;
  bool isShowLoader = false;

  List<RatingComponentModel> alReviewModel = [];

  @override
  void initState() {

    getRating();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget widgetM = Container();



    Widget mShowWidget = ListView.builder(
        padding: const EdgeInsets.all(AppDimens.dimens_10),
        itemBuilder: (BuildContext contextM, index) {
          RatingComponentModel ratingComponentModel = alReviewModel[index];
          return RatingListItem(
              ratingComponentModel: ratingComponentModel,
              mRatingType: RatingType.given);
        },
        itemCount: alReviewModel.length);

    widgetM = AppViews.getSetData(context, mShowData, mShowWidget);

    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.getMainBgColor(),
        body: Stack(
          children: [widgetM, AppViews.showLoadingWithStatus(isShowLoader)],
        ));
  }

  getRating() async {
    setState(() {
      mShowData = ShowData.showLoading;
    });

    HashMap<String, Object> requestParams = HashMap();

    var categories = await RatingRepo().getRatingsIndividual(requestParams,
        RatingType.given, Get.find<HomeScreenController>().userId);

    categories.fold((failure) {


      Global.showToastAlert(
          context: context,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);
      setState(() {
        mShowData = ShowData.showNoDataFound;
      });
    }, (mResult) {
      setState(() {

        alReviewModel = mResult.responseData as List<RatingComponentModel>;
        mShowData = ShowData.showData;
      });
    });
  }
}

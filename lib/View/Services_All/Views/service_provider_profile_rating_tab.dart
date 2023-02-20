import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/View/Rating/model/rating_component_model.dart';
import 'package:otobucks/services/repository/rating_repo.dart';
import 'package:otobucks/widgets/rating_list_item.dart';

import '../../../global/app_colors.dart';
import '../../../global/app_views.dart';
import '../../../global/enum.dart';
import '../../../global/global.dart';

class ServiceProviderProfileRatingTab extends StatefulWidget {
  final String servicePrviderID;

  const ServiceProviderProfileRatingTab({Key? key, required this.servicePrviderID}) : super(key: key);

  @override
  ServiceProviderProfileRatingTabState createState() => ServiceProviderProfileRatingTabState();
}

class ServiceProviderProfileRatingTabState extends State<ServiceProviderProfileRatingTab> {
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
          return RatingListItem(ratingComponentModel: ratingComponentModel, mRatingType: RatingType.given);
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

    var categories = await RatingRepo().getAllRatingsProvider(requestParams, widget.servicePrviderID);

    categories.fold((failure) {
      log("message");
      Global.showToastAlert(context: context, strTitle: "", strMsg: "No Reviews Found", toastType: TOAST_TYPE.toastError);
      setState(() {
        mShowData = ShowData.showNoDataFound;
      });
    }, (mResult) {
      setState(() {
        alReviewModel = mResult.responseData as List<RatingComponentModel>;
        if (alReviewModel.isNotEmpty) {
          mShowData = ShowData.showData;
        } else {
          mShowData = ShowData.showNoDataFound;
        }
      });
    });
  }
}

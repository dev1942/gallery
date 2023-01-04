import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:otobucks/View/Services_All/Models/service_provider_model.dart';
import 'package:otobucks/View/Services_All/Views/service_provider_profile_rating_tab.dart';
import 'package:otobucks/widgets/fade_in_image.dart';

import '../../../../global/app_colors.dart';
import '../../../../global/app_dimens.dart';
import '../../../../global/app_style.dart';
import '../../../../global/app_views.dart';
import '../../../../global/constants.dart';
import '../../../../global/enum.dart';

// ignore: must_be_immutable
class ServiceProviderProfileScreen extends StatefulWidget {
  double rating;
  double totalRatings;
  ServiceProviderModel mServiceProviderModel;
  String title = '';
  ServiceProviderProfileScreen(
      {Key? key,
      required this.mServiceProviderModel,
      required this.title,
      required this.rating,
      required this.totalRatings})
      : super(key: key);

  @override
  ServiceProviderProfileScreenState createState() =>
      ServiceProviderProfileScreenState();
}

class ServiceProviderProfileScreenState
    extends State<ServiceProviderProfileScreen>
    with SingleTickerProviderStateMixin {
  ShowData mShowData = ShowData.showData;
  late TabController controller;
  bool connectionStatus = false;
  late ServiceProviderModel mServiceProviderModel;
  int indexM = 0;
  int activeTabIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
    controller.addListener(() {
      setState(() {
        activeTabIndex = controller.index;
      });
    });
    mServiceProviderModel = widget.mServiceProviderModel;
  }

  @override
  Widget build(BuildContext context) {
    Widget widgetM = Container();

    Widget mShowWidget = Column(
      children: [
        // profile pic and name

        Stack(
          children: [
            Container(
              color: AppColors.colorBlueStart,
              height: AppDimens.dimens_110,
            ),
            // Container(height: size.height, child: widgetM),
            Container(
              margin: const EdgeInsets.only(
                  left: AppDimens.dimens_20,
                  top: AppDimens.dimens_20,
                  bottom: AppDimens.dimens_30,
                  right: AppDimens.dimens_20),
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppDimens.dimens_5),
                child: NetworkImageCustom(
                    image: mServiceProviderModel.image,
                    fit: BoxFit.fill,
                    height: AppDimens.dimens_120,
                    width: AppDimens.dimens_120),
              ),
            ),
            // AppViews.showLoadingWithStatus(isShowLoader)
          ],
        ),
        Card(
          elevation: AppDimens.dimens_8,
          margin: const EdgeInsets.only(
              left: AppDimens.dimens_90, right: AppDimens.dimens_90),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.only(top: AppDimens.dimens_15),
                  alignment: Alignment.center,
                  child: Text(
                    mServiceProviderModel.getName(),
                    style: AppStyle.textViewStyleLarge(
                        context: context,
                        color: AppColors.colorBlack,
                        fontSizeDelta: 3,
                        fontWeightDelta: 0),
                  )),
              if (widget.rating != 0)
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                      bottom: AppDimens.dimens_15, top: AppDimens.dimens_2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          margin:
                              const EdgeInsets.only(right: AppDimens.dimens_4),
                          child: RatingBarIndicator(
                            rating: widget.rating,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: AppColors.colorRating,
                            ),
                            itemCount: 5,
                            itemSize: AppDimens.dimens_14,
                            direction: Axis.horizontal,
                          )),
                      Text(
                        "(${widget.totalRatings})",
                        style: AppStyle.textViewStyleSmall(
                            context: context,
                            color: AppColors.colorBlack,
                            fontSizeDelta: -2),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
              top: AppDimens.dimens_20,
              bottom: AppDimens.dimens_20,
              left: AppDimens.dimens_20,
              right: AppDimens.dimens_20),
          alignment: Alignment.center,
          child: Text(
            widget.title,
            style: AppStyle.textViewStyleNormalSubtitle2(
                context: context,
                color: AppColors.grayDashboardText,
                fontSizeDelta: -1,
                fontWeightDelta: -1),
          ),
        ),
        TabBar(
          //
          labelStyle: AppStyle.textViewStyleNormalSubtitle2(
              context: context, color: AppColors.colorBlack2),
          indicatorColor: AppColors.colorBlueEnd,
          labelColor: AppColors.colorWhite,
          unselectedLabelColor: AppColors.colorBlack2,
          indicator: AppViews.getGradientBoxDecoration(mBorderRadius: 5),
          indicatorSize: TabBarIndicatorSize.label,
          tabs: [
            Container(
              decoration: activeTabIndex != 0
                  ? AppViews.getGrayDecoration(mBorderRadius: 5)
                  : null,
              alignment: Alignment.center,
              width: AppDimens.dimens_150,
              height: AppDimens.dimens_48,
              child: const Text(
                "Profile Info",
              ),
            ),
            Container(
              decoration: activeTabIndex != 1
                  ? AppViews.getGrayDecoration(mBorderRadius: 5)
                  : null,
              alignment: Alignment.center,
              width: AppDimens.dimens_150,
              height: AppDimens.dimens_48,
              child: const Text(
                "Reviews",
              ),
            ),
          ],
          controller: controller,
        ),
        Expanded(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(
                  top: AppDimens.dimens_8,
                  left: AppDimens.dimens_14,
                  right: AppDimens.dimens_14,
                ),
                child: Text(
                  mServiceProviderModel.about,
                  style: AppStyle.textViewStyleSmall(
                      context: context,
                      color: AppColors.colorBlack2,
                      fontWeightDelta: -2),
                ),
              ),
              ServiceProviderProfileRatingTab(
                  servicePrviderID: mServiceProviderModel.id)
            ],
          ),
        ),
        // Expanded(child: Container()),
      ],
    );
    widgetM = AppViews.getSetData(context, mShowData, mShowWidget);

    return Scaffold(
      appBar: AppViews.initAppBar(
        mContext: context,
        centerTitle: false,
        strTitle: Constants.TXT_PROFILE,
        isShowNotification: false,
        isShowSOS: false,
      ),
      resizeToAvoidBottomInset: false,
      // backgroundColor: AppColors.getMainBgColor(),
      body: widgetM,
    );
  }
}

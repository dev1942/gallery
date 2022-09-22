import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:otobucks/controllers/services_controllers/service_screen_controller.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_images.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/model/category_model.dart';
import 'package:otobucks/model/service/service_model.dart';
import 'package:otobucks/widgets/custom_textfield_with_icon.dart';
import 'package:otobucks/widgets/google_map_view.dart';
import 'package:otobucks/widgets/service_provider_items.dart';

class ServiceScreen extends StatefulWidget {
  final CategoryModel mSubCategoryModel;
  final CategoryModel mCategoryModel;

  const ServiceScreen(
      {Key? key, required this.mSubCategoryModel, required this.mCategoryModel})
      : super(key: key);

  @override
  ServiceScreenState createState() => ServiceScreenState();
}

class ServiceScreenState extends State<ServiceScreen> {
  var controller = Get.put(ServiceScreenController());

  @override
  void initState() {
    controller.getServiceProvider(
        widget.mCategoryModel.id, widget.mSubCategoryModel.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.getMainBgColor(),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                color: AppColors.colorBlueStart,
                height: 130,
              ),

              Column(
                children: [
                  _searchFiled(),
                  _nearMeText(),
                  _map(),
                  _nearByText(),
                  _providersNearby(),
                  _viewMore(),
                  _providerPopular(),
                  // Expanded(child: Container()),
                ],
              )

              // AppViews.showLoadingWithStatus(isShowLoader)
            ],
          ),
        ],
      ),
    );
  }

  _searchFiled() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(
          left: AppDimens.dimens_20,
          bottom: AppDimens.dimens_6,
          right: AppDimens.dimens_10),
      child: Card(
        child: CustomTextFieldWithIcon(
          textInputAction: TextInputAction.next,
          enabled: true,
          controller: controller.controllerSearch,
          keyboardType: TextInputType.text,
          hintText: Constants.STR_SEARCH.tr,
          inputFormatters: const [],
          obscureText: false,
          height: AppDimens.dimens_36,
          onChanged: (String value) {},
          onSubmit: (String value) {},
          suffixIcon: InkWell(
            child: Image.asset(
              AppImages.ic_search,
              width: AppDimens.dimens_18,
              // color: AppColors.colorIconGray,
            ),
            onTap: () {},
          ),
        ),
      ),
    );
  }

  _nearMeText() => Container(
        alignment: AlignmentDirectional.centerStart,
        margin: const EdgeInsets.only(
            left: AppDimens.dimens_20,
            bottom: AppDimens.dimens_6,
            right: AppDimens.dimens_10),
        child: Text(
          '${widget.mSubCategoryModel.title} ${"near me".tr}',
          maxLines: 2,
          softWrap: true,
          // textAlign: TextAlign.center,
          style: AppStyle.textViewStyleNormalSubtitle2(
              context: context,
              color: AppColors.colorWhite,
              fontWeightDelta: 1),
        ),
      );

  _viewMore() => Container(
        margin: const EdgeInsets.only(
            top: AppDimens.dimens_15,
            left: AppDimens.dimens_15,
            right: AppDimens.dimens_15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Popular " + widget.mSubCategoryModel.title.toLowerCase(),
              style: AppStyle.textViewStyleSmall(
                  context: context,
                  color: AppColors.colorBlack,
                  fontWeightDelta: 2,
                  fontSizeDelta: 0),
            ),
            // InkWell(
            //   child: Text(
            //     Constants.TXT_VIEW_MORE,
            //     style: AppStyle.textViewStyleSmall(
            //         context: context,
            //         color: AppColors.colorBlack,
            //         fontWeightDelta: 2,
            //         fontSizeDelta: 0),
            //   ),
            //   onTap: () {
            //     // todo View More
            //   },
            // )
          ],
        ),
      );
  _nearByText() => Container(
        margin: const EdgeInsets.only(
            top: AppDimens.dimens_15,
            left: AppDimens.dimens_15,
            right: AppDimens.dimens_15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Nearby " + widget.mSubCategoryModel.title.toLowerCase(),
              style: AppStyle.textViewStyleSmall(
                  context: context,
                  color: AppColors.colorBlack,
                  fontWeightDelta: 2,
                  fontSizeDelta: 0),
            ),
          ],
        ),
      );

  _providersNearby() => GetBuilder<ServiceScreenController>(builder: (value) {
        return Container(
            height: AppDimens.dimens_90,
            margin: const EdgeInsets.only(top: AppDimens.dimens_10),
            child: AppViews.getSetData(
                context,
                value.mShowData,
                ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (BuildContext contextM, index) {
                      ServiceModel mServiceModel = value.alServices[index];
                      return ServiceProviderRated(
                        mServiceModel: mServiceModel,
                        isShowRating: true,
                        onTap: () {
                          value.gotoServiceDetail(mServiceModel, context);
                        },
                      );
                    },
                    itemCount: value.alServices.length)));
      });

  _providerPopular() => GetBuilder<ServiceScreenController>(builder: (value) {
        return Container(
            margin: const EdgeInsets.only(
                top: AppDimens.dimens_10,
                left: AppDimens.dimens_5,
                right: AppDimens.dimens_10),
            child: AppViews.getSetData(
                context,
                value.mShowData,
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    // itemExtent: AppDimens.dimens_100,
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (BuildContext contextM, index) {
                      ServiceModel mServiceModel = value.alServices[index];
                      return ServiceProviderRated(
                        mServiceModel: mServiceModel,
                        isShowRating: false,
                        onTap: () {
                          value.gotoServiceDetail(mServiceModel, context);
                        },
                      );
                    },
                    itemCount: value.alServices.length)));
      });

  _appBar() => AppViews.initAppBar(
        mContext: context,
        centerTitle: false,
        strTitle: widget.mCategoryModel.title,
        isShowNotification: false,
        isShowSOS: false,
      );

  _map() => Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(AppDimens.dimens_5),
        height: 200,
        child: GoogleMapView(onTap: (LatLng mLatLng_) {}),
      );
}

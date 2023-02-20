import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/Profile/Controller/profile_screen_controller.dart';
import 'package:otobucks/View/Services_All/Controllers/services_detail_screen_controller.dart';

import 'package:otobucks/global/adaptive_helper.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_images.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/View/Services_All/Models/service_model.dart';
import 'package:otobucks/widgets/custom_button.dart';
import 'package:otobucks/widgets/fade_in_image.dart';
import 'package:otobucks/widgets/gradient_text.dart';
import 'package:otobucks/widgets/video_view.dart';

class ServiceDetailScreen extends StatefulWidget {
  final ServiceModel mServiceModel;

  const ServiceDetailScreen({Key? key, required this.mServiceModel}) : super(key: key);

  @override
  ServiceDetailScreenState createState() => ServiceDetailScreenState();
}

class ServiceDetailScreenState extends State<ServiceDetailScreen> {
  var controller = Get.put(ServicesDetailsScreenController());
  var profileController = Get.put(ProfileScreenController());
  @override
  void initState() {
    super.initState();
    controller.mServiceModel = widget.mServiceModel;
    profileController.getCarList();
  }

  @override
  Widget build(BuildContext context) {
    Widget mShowWidget = ListView(
      children: [
        Stack(
          children: [
            Container(
              color: AppColors.colorBlueStart,
              height: AppDimens.dimens_120,
            ),

            Container(
              margin: const EdgeInsetsDirectional.only(
                  start: AppDimens.dimens_30, top: AppDimens.dimens_20, bottom: AppDimens.dimens_30, end: AppDimens.dimens_20),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsetsDirectional.only(
                      end: AppDimens.dimens_20,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppDimens.dimens_5),
                      child: NetworkImageCustom(
                          image: controller.mServiceModel.getProviderImage(),
                          fit: BoxFit.fill,
                          height: AppDimens.dimens_120,
                          width: AppDimens.dimens_120),
                    ),
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        controller.mServiceModel.mServiceProviderModel.getName() ?? '',
                        softWrap: true,
                        overflow: TextOverflow.clip,
                        maxLines: 2,
                        style: AppStyle.textViewStyleLarge(context: context, color: AppColors.colorWhite, fontSizeDelta: 3, fontWeightDelta: -2),
                      ),
                      Text(
                        // ignore: unnecessary_null_comparison
                        controller.mServiceModel.mServiceProviderModel != null ? controller.mServiceModel.title : "",
                        softWrap: true,
                        overflow: TextOverflow.clip,
                        maxLines: 2,
                        style: AppStyle.textViewStyleLarge(context: context, color: AppColors.colorWhite, fontSizeDelta: -3, fontWeightDelta: -2),
                      ),
                      InkWell(
                        child: Container(
                            margin: const EdgeInsetsDirectional.only(top: AppDimens.dimens_5),
                            child: Text(
                              "View Profile".tr,
                              style: AppStyle.textViewStyleSmall(
                                  context: context,
                                  color: AppColors.colorWhite,
                                  mDecoration: TextDecoration.underline,
                                  fontSizeDelta: -1,
                                  fontWeightDelta: 0),
                            )),
                        onTap: () {
                          controller.gotoProfile(context);
                        },
                      ),
                    ],
                  ))
                ],
              ),
            ),
            // AppViews.showLoadingWithStatus(isShowLoader)
          ],
        ),
        //video and images
        Container(
          padding: const EdgeInsetsDirectional.only(start: AppDimens.dimens_20, end: AppDimens.dimens_20),
          alignment: AlignmentDirectional.centerStart,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              controller.mServiceModel.alVideos.isNotEmpty
                  ? Container(
                      margin: const EdgeInsetsDirectional.only(
                        start: AppDimens.dimens_8,
                        end: AppDimens.dimens_8,
                      ),
                      height: wd(180),
                      child: VideoView(
                        strVideoURL: controller.mServiceModel.alVideos[0],
                        isMainView: true,
                      ),
                    )
                  : Container(),
              Container(
                  height: AppDimens.dimens_70,
                  margin: const EdgeInsetsDirectional.only(
                    top: AppDimens.dimens_15,
                    start: AppDimens.dimens_8,
                    end: AppDimens.dimens_8,
                  ),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsetsDirectional.all(0),
                      itemBuilder: (BuildContext contextM, index) {
                        String image = widget.mServiceModel.alImages[index];
                        return Container(
                          margin: const EdgeInsetsDirectional.only(
                            end: AppDimens.dimens_10,
                          ),
                          child: InkWell(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(AppDimens.dimens_5),
                                child: NetworkImageCustom(
                                  image: image,
                                  height: 70,
                                  width: 70,
                                )),
                            onTap: () {
                              final imageProvider = Image.network(image).image;
                              showImageViewer(context, imageProvider, useSafeArea: true, onViewerDismissed: () {});
                            },
                          ),
                        );
                      },
                      itemCount: widget.mServiceModel.alImages.length)),
              Container(
                margin: const EdgeInsetsDirectional.only(
                  top: AppDimens.dimens_15,
                  start: AppDimens.dimens_8,
                  end: AppDimens.dimens_8,
                ),
                child: GradientText(
                  "Key Features".tr,
                  style: AppStyle.textViewStyleNormalSubtitle2(context: context, color: AppColors.colorBlack, fontWeightDelta: 1, fontSizeDelta: 1),
                ),
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(
                  top: AppDimens.dimens_10,
                  start: AppDimens.dimens_8,
                  end: AppDimens.dimens_8,
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext contextM, index) {
                      String strFeatures = controller.mServiceModel.alFeatures[index];
                      return Container(
                        margin: const EdgeInsetsDirectional.only(bottom: AppDimens.dimens_15),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsetsDirectional.only(
                                end: AppDimens.dimens_10,
                              ),
                              child: Image.asset(AppImages.ic_round_blue_tick, width: AppDimens.dimens_16, height: AppDimens.dimens_16),
                            ),
                            Expanded(
                              child: Text(
                                strFeatures,
                                style: AppStyle.textViewStyleSmall(context: context, color: AppColors.colorBlack2, fontWeightDelta: -2),
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: controller.mServiceModel.alFeatures.length),
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(
                  top: AppDimens.dimens_15,
                  start: AppDimens.dimens_8,
                  end: AppDimens.dimens_8,
                ),
                child: GradientText(
                  "Description".tr,
                  style: AppStyle.textViewStyleNormalSubtitle2(context: context, color: AppColors.colorBlack, fontWeightDelta: 1, fontSizeDelta: 1),
                ),
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(
                  top: AppDimens.dimens_8,
                  start: AppDimens.dimens_8,
                  end: AppDimens.dimens_8,
                ),
                child: Text(
                  Global.getString(controller.mServiceModel.description),
                  style: AppStyle.textViewStyleSmall(context: context, color: AppColors.colorBlack2, fontWeightDelta: -2),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsetsDirectional.only(
                    top: AppDimens.dimens_20, bottom: AppDimens.dimens_20, start: AppDimens.dimens_10, end: AppDimens.dimens_10),
                child: CustomButton(
                    isGradient: true,
                    isRoundBorder: true,
                    fontColor: AppColors.colorWhite,
                    width: Responsive.screenWidth,
                    onPressed: () {
                      controller.gotoCreateEstimation(context);
                    },
                    strTitle: Constants.TXT_BOOK_NOW.tr),
              ),
            ],
          ),
        )

        // Expanded(child: Container()),
      ],
    );

    return Scaffold(
      appBar: AppViews.initAppBar(
        mContext: context,
        centerTitle: false,
        strTitle: widget.mServiceModel.title + " Detail",
        isShowNotification: false,
        isShowSOS: false,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.getMainBgColor(),
      body: Stack(
        children: [
          Container(
            color: AppColors.colorBlueStart,
            //height: AppDimens.dimens_120,
            height: 0,
          ),
          // Container(height: size.height, child: widgetM),
          mShowWidget,
          // AppViews.showLoadingWithStatus(isShowLoader)
        ],
      ),
    );
  }
}

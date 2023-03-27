import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/View/Services_All/Models/service_model.dart';
import 'package:otobucks/widgets/fade_in_image.dart';

// ignore: must_be_immutable
class ServiceProviderRated extends StatelessWidget {
  ServiceModel mServiceModel;
  Function onTap;
  bool isShowRating;

  ServiceProviderRated({Key? key, required this.mServiceModel, required this.onTap, required this.isShowRating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log(mServiceModel.rating.toString());
    if (isShowRating) {
      return Container(
        // height: AppDimens.dimens_100,
        width: AppDimens.dimens_190,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: AppColors.grayDashboardItem,
          borderRadius: BorderRadius.circular(AppDimens.dimens_5),
        ),
        margin: const EdgeInsetsDirectional.only(start: AppDimens.dimens_5, end: AppDimens.dimens_10),
        padding: const EdgeInsetsDirectional.all(AppDimens.dimens_6),
        child: InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsetsDirectional.only(
                      end: AppDimens.dimens_10,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppDimens.dimens_5),
                      child: NetworkImageCustom(
                          image: mServiceModel.alImages.first, fit: BoxFit.fill, height: AppDimens.dimens_40, width: AppDimens.dimens_40),
                    ),
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        mServiceModel.mServiceProviderModel.getName() ?? '',
                        softWrap: true,
                        maxLines: 1,
                        style: AppStyle.textViewStyleNormalBodyText2(
                            context: context, color: AppColors.colorBlack, fontSizeDelta: -1, fontWeightDelta: 2),
                      ),
                      Container(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            mServiceModel.title,
                            maxLines: 1,
                            style: AppStyle.textViewStyleNormalBodyText2(
                                context: context, color: AppColors.colorBlack, fontSizeDelta: -2, fontWeightDelta: 1),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 20,
                          ),
                          addHorizontalSpace(5),
                          Text(
                            "${mServiceModel.rating.toDouble()}",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      )

                      // RatingBarIndicator(
                      //   rating: mServiceModel.rating.toDouble(),
                      //   itemBuilder: (context, index) => Icon(
                      //     Icons.star,
                      //     color: AppColors.colorRating,
                      //   ),
                      //   itemCount: 5,
                      //   itemSize: AppDimens.dimens_12,
                      //   direction: Axis.horizontal,
                      // ),
                    ],
                  ))
                ],
              ),
              const SizedBox(
                height: AppDimens.dimens_8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                        width: AppDimens.dimens_50,
                        margin: const EdgeInsetsDirectional.only(
                          end: AppDimens.dimens_10,
                        ),
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          Global.replaceCurrencySign(mServiceModel.currency) + "" + mServiceModel.price,
                          style: AppStyle.textViewStyleSmall(context: context, color: AppColors.colorTextBlue, fontSizeDelta: 0, fontWeightDelta: 3),
                        )),
                  ),
                  InkWell(
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        height: AppDimens.dimens_20,
                        alignment: Alignment.center,
                        decoration: AppViews.getGradientBoxDecoration(mBorderRadius: AppDimens.dimens_5),
                        child: Text(
                          "View Details".tr,
                          style: AppStyle.textViewStyleSmall(context: context, color: AppColors.colorWhite, fontSizeDelta: -3, fontWeightDelta: 2),
                        )),
                    onTap: () {
                      onTap();
                    },
                  )
                ],
              ),
            ],
          ),
          onTap: () {
            onTap();
          },
        ),
      );
    } else {
      return Container(
          alignment: Alignment.center,
          // color: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: AppDimens.dimens_6, horizontal: AppDimens.dimens_6),
          padding: const EdgeInsetsDirectional.only(
            start: AppDimens.dimens_25,
            end: AppDimens.dimens_25,
            top: AppDimens.dimens_6,
            bottom: AppDimens.dimens_6,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: AppColors.grayDashboardItem,
            borderRadius: BorderRadius.circular(AppDimens.dimens_5),
          ),
          child: InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(
                    end: AppDimens.dimens_10,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppDimens.dimens_5),
                    child: NetworkImageCustom(
                        image: mServiceModel.getProviderImage(), fit: BoxFit.fill, height: AppDimens.dimens_60, width: AppDimens.dimens_60),
                  ),
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          mServiceModel.mServiceProviderModel.getName() ?? '',
                          maxLines: 1,
                          style: AppStyle.textViewStyleNormalBodyText2(
                              context: context, color: AppColors.colorBlack.withOpacity(0.8), fontSizeDelta: -3, fontWeightDelta: -2),
                        )),
                    Container(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          mServiceModel.title,
                          maxLines: 1,
                          style: AppStyle.textViewStyleNormalBodyText2(
                              context: context, color: AppColors.colorBlack, fontSizeDelta: -2, fontWeightDelta: 1),
                        )),
                    RatingBarIndicator(
                      rating: mServiceModel.rating.toDouble(),
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: AppColors.colorRating,
                      ),
                      itemCount: 5,
                      itemSize: AppDimens.dimens_12,
                      direction: Axis.horizontal,
                    ),
                    Container(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          Global.replaceCurrencySign(mServiceModel.currency) + "" + mServiceModel.price,
                          style: AppStyle.textViewStyleSmall(context: context, color: AppColors.colorBlack, fontSizeDelta: -2, fontWeightDelta: 1),
                        )),
                  ],
                )),
                InkWell(
                  child: Container(
                      height: AppDimens.dimens_20,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: AppViews.getGradientBoxDecoration(mBorderRadius: AppDimens.dimens_5),
                      child: Text(
                        "View Details".tr,
                        style: AppStyle.textViewStyleSmall(context: context, color: AppColors.colorWhite, fontSizeDelta: -3, fontWeightDelta: 2),
                      )),
                  onTap: () {
                    onTap();
                  },
                ),
              ],
            ),
            onTap: () {
              onTap();
            },
          ));
    }
  }
}

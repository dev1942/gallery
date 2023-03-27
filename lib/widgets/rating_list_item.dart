import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/container_properties.dart';
import 'package:otobucks/global/extensions.dart';
import 'package:otobucks/global/text_styles.dart';
import 'package:otobucks/View/Rating/model/rating_component_model.dart';
import 'package:otobucks/widgets/fade_in_image.dart';

import '../global/enum.dart';

class RatingListItem extends StatelessWidget {
  final RatingComponentModel ratingComponentModel;
  final RatingType mRatingType;

  const RatingListItem({
    Key? key,
    required this.ratingComponentModel,
    required this.mRatingType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log(ratingComponentModel.rating.toString());
    return Container(
      decoration: ContainerProperties.shadowDecoration(),
      margin: const EdgeInsets.only(bottom: AppDimens.dimens_14, left: 10, right: 10),
      child: Container(
        alignment: Alignment.center,
        // height: AppDimens.dimens_90,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    right: AppDimens.dimens_10,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppDimens.dimens_5),
                    child: NetworkImageCustom(
                        image: ratingComponentModel.image, fit: BoxFit.fill, height: AppDimens.dimens_60, width: AppDimens.dimens_60),
                  ),
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: AppDimens.dimens_5, bottom: AppDimens.dimens_5),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          ratingComponentModel.name.capitalize(),
                          style: AppStyle.textViewStyleNormalBodyText2(
                              context: context, color: AppColors.grayDashboardText, fontSizeDelta: -1, fontWeightDelta: 1),
                        )),
                    // Container(
                    //     margin:
                    //         const EdgeInsets.only(bottom: AppDimens.dimens_5),
                    //     alignment: Alignment.centerLeft,
                    //     child: Text(
                    //       userName,
                    //       style: AppStyle.textViewStyleSmall(
                    //           context: context,
                    //           color: AppColors.grayDashboardText,
                    //           fontSizeDelta: -3,
                    //           fontWeightDelta: 0),
                    //     )),
                    RatingBarIndicator(
                      rating: ratingComponentModel.rating,
                      itemBuilder: (context, index) => Icon(Icons.star, color: AppColors.colorRating2),
                      itemCount: 5,
                      itemSize: AppDimens.dimens_14,
                      direction: Axis.horizontal,
                    ),
                  ],
                )),
              ],
            ),
            const SizedBox(
              height: 14,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Your Review',
                style: regularText600(15),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(bottom: AppDimens.dimens_5, top: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  ratingComponentModel.review,
                  style: AppStyle.textViewStyleSmall(context: context, color: AppColors.colorBlack, fontSizeDelta: -1, fontWeightDelta: -2),
                )),
            // Visibility(
            //   child: Container(
            //     alignment: Alignment.centerRight,
            //     child: InkWell(
            //       child: Container(
            //           height: AppDimens.dimens_30,
            //           width: AppDimens.dimens_100,
            //           alignment: Alignment.center,
            //           decoration: AppViews.getGradientBoxDecoration(
            //               mBorderRadius: AppDimens.dimens_5),
            //           child: Text(
            //             "Give a Review",
            //             style: AppStyle.textViewStyleSmall(
            //                 context: context,
            //                 color: AppColors.colorWhite,
            //                 fontSizeDelta: -3,
            //                 fontWeightDelta: 2),
            //           )),
            //       onTap: () {},
            //     ),
            //   ),
            //   visible: mRatingType == RatingType.RECEIVED,
            // )
          ],
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/Promotion_discount/model/promotion_model.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_images.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/model/promotion_model.dart';
import 'package:otobucks/widgets/custom_button.dart';
import 'package:otobucks/widgets/fade_in_image.dart';
import 'package:otobucks/widgets/gradient_text.dart';

class PromotionBanner extends StatelessWidget {
  final String buttonText;
  final String strImage;
  final PromotionsModel mPromotionsModel;
  final Function onTap;
  bool isVisible;

  PromotionBanner(
      {Key? key,
      required this.mPromotionsModel,
      required this.strImage,
      required this.onTap,
      required this.buttonText,
      this.isVisible = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      double height = MediaQuery.of(context).size.width > 600
          ? size.maxWidth / 1.7
          : size.maxWidth / 1.3;
      log(height.toString());
      log(MediaQuery.of(context).size.width.toString());
      return Container(
          height: height,
          margin: const EdgeInsets.only(left: AppDimens.dimens_2),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppDimens.dimens_5),
            child: Container(
              child: Stack(
                children: [
                  Positioned(
                    child: SizedBox(
                        child: NetworkImageCustom(
                          image:strImage,
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                        ),
                        width: size.maxWidth / 1.5),
                    right: 0,
                    bottom: 0,
                    top: 0,
                  ),
                  SizedBox(
                    height: Get.height,
                    child:
                        Image.asset(AppImages.ic_banner_bg, fit: BoxFit.cover),
                  ),
                  Positioned(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(
                          left: AppDimens.dimens_15,
                          top: AppDimens.dimens_5,
                          bottom: AppDimens.dimens_5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: height / 2,
                            height: height / 2.8,
                            child: GradientText(
                              mPromotionsModel.title,
                              textAlign: TextAlign.left,
                              maxLines: 3,
                              style: AppStyle.textViewStyleXLarge(
                                      context: context,
                                      fontWeightDelta: 3,
                                      color: AppColors.colorBlueEnd)
                                  .copyWith(
                                      fontSize: height * 0.09, height: 1.2),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: height / 2,
                                  margin: const EdgeInsets.only(
                                      top: AppDimens.dimens_6),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    Global.replaceCurrencySign("USD") +
                                        "" +
                                        mPromotionsModel.previousPrice +
                                        "/hr",
                                    style: AppStyle.textViewStyleSmall(
                                            context: context,
                                            fontWeightDelta: 0,
                                            fontSizeDelta: -1,
                                            mDecoration:
                                                TextDecoration.lineThrough,
                                            color: AppColors.colorBlueEnd)
                                        .copyWith(fontSize: height * 0.05),
                                  ),
                                ),
                                Container(
                                  width: height / 2,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      Global.replaceCurrencySign("USD") +
                                          "" +
                                          mPromotionsModel.priceAfterDiscount +
                                          "/hr",
                                      style: AppStyle.textViewStyleSmall(
                                              context: context,
                                              fontWeightDelta: 2,
                                              fontSizeDelta: 3,
                                              color: AppColors.colorBlueEnd)
                                          .copyWith(fontSize: height * 0.06)),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: AppDimens.dimens_6),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Validity Date",
                                      style: AppStyle.textViewStyleSmall(
                                              context: context,
                                              fontWeightDelta: -1,
                                              fontSizeDelta: -2,
                                              color: AppColors.colorBlueEnd)
                                          .copyWith(fontSize: height * 0.05)),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(mPromotionsModel.getEndDate(),
                                      style: AppStyle.textViewStyleSmall(
                                              context: context,
                                              fontWeightDelta: 2,
                                              fontSizeDelta: -1,
                                              color: AppColors.colorBlueEnd)
                                          .copyWith(fontSize: height * 0.06)),
                                ),
                                SizedBox(
                                  height: height * 0.03,
                                ),
                                //-------------------VBView details buttons-----------------------
                                Visibility(
                                  visible: this.isVisible,
                                  child: SizedBox(
                                    width: Get.width / 3.3,
                                    child: ElevatedButton(
                                        child: Text(
                                          "View Details",
                                          style: TextStyle(
                                                     fontSize: height * 0.05,
                                                  color: AppColors.colorBlack)
                                        ),
                                        onPressed: () {onTap();},
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  AppColors.colorYellowShade),
                                        )),
                                  ),
                                  // CustomButton(
                                  //     width: size.maxWidth / 3.3,
                                  //     height: height / 8.5,
                                  //     isRoundBorder: true,
                                  //     isGradient: true,
                                  //     textStyle: TextStyle(
                                  //         fontSize: height * 0.04,
                                  //         color: AppColors.colorWhite),
                                  //     onPressed: () => onTap(),
                                  //     strTitle: buttonText),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    left: 0,
                    bottom: 0,
                    top: 0,
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width > 600
                            ? height / 1.9
                            : height / 2.7,
                      ),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(AppImages.ic_offer_bg),
                        fit: BoxFit.fill,
                      )),
                      child: Text(
                        mPromotionsModel.discount + "%" "\n" + "OFF",
                        style: AppStyle.textViewStyleSmall(
                                context: context,
                                fontWeightDelta: 1,
                                color: AppColors.colorYellowShade)
                            .copyWith(fontSize: height * 0.04),
                      ),
                      height: height * 0.2,
                      width: height * 0.2,
                    ),
                  ),
                ],
              ),
              color: AppColors.colorGray6,
            ),
          ));
    });
  }
}

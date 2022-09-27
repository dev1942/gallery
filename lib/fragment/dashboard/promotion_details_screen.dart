import 'package:flutter/material.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/extensions.dart';
import 'package:otobucks/model/category_model.dart';
import 'package:otobucks/model/promotion_model.dart';
import 'package:otobucks/model/service/service_model.dart';
import 'package:otobucks/page/services/estimation/create_estimation_screen.dart';
import 'package:otobucks/widgets/banner_component.dart';

class PromotionDetailsScreen extends StatefulWidget {
  final PromotionsModel promotionsModel;

  const PromotionDetailsScreen({Key? key, required this.promotionsModel})
      : super(key: key);

  @override
  PromotionDetailsScreenState createState() => PromotionDetailsScreenState();
}

class PromotionDetailsScreenState extends State<PromotionDetailsScreen> {
  late ServiceModel serviceModel;
  @override
  void initState() {
    if (widget.promotionsModel.sourceType == 'service') {
      serviceModel = ServiceModel(
          rating: 0,
          totalRatings: 0,
          alFeatures: [],
          alImages: [],
          alStory: [],
          alVideos: [],
          currency: 'USD',
          description: '',
          id: widget.promotionsModel.source.id,
          mCategoryModel: CategoryModel(
              id: widget.promotionsModel.source.id,
              title: widget.promotionsModel.source.title.toString(),
              description: "",
              image: "",
              type: ""),
          mServiceProviderModel: widget.promotionsModel.provider!,
          mSubCategoryModel: CategoryModel(
              id: widget.promotionsModel.source.id,
              title: widget.promotionsModel.source.title.toString(),
              description: "",
              image: "",
              type: ""),
          price: widget.promotionsModel.priceAfterDiscount,
          title: widget.promotionsModel.source.title);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.getMainBgColor(),
      // backgroundColor: AppColors.getMainBgColor(),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                color: AppColors.colorBlueStart,
                width: double.infinity,
                height: AppDimens.dimens_170,
              ),
              mShowWidget()
            ],
          ),
        ],
      ),
    );
  }

  Widget mShowWidget() => Column(
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(
                bottom: AppDimens.dimens_14,
                top: AppDimens.dimens_14,
                left: AppDimens.dimens_20,
                right: AppDimens.dimens_20),
            // height: AppDimens.dimens_190,
            child: PromotionBanner(
              buttonText: 'Book Now',
              onTap: () {
                // if (widget.promotionsModel.sourceType == 'service') {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => CreateEstimationScreen(
                          mServiceModel: serviceModel,
                          screenType: 'promotion',
                        )));
                // }
              },
              mPromotionsModel: widget.promotionsModel,
              strImage: widget.promotionsModel.getPromoImage(),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.promotionsModel.title,
                  maxLines: 2,
                  style: AppStyle.textViewStyleLargeSubtitle1(
                    context: context,
                    color: AppColors.colorBlack,
                    fontSizeDelta: 3,
                    fontWeightDelta: 2,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                rowText(widget.promotionsModel.sourceType.toString(),
                    widget.promotionsModel.source.title.toString()),
                const SizedBox(
                  height: 12,
                ),
                rowText('Price Before',
                    widget.promotionsModel.previousPrice.toString()),
                const SizedBox(
                  height: 12,
                ),
                rowText('Discount',
                    widget.promotionsModel.discount.toString() + '%'),
                const SizedBox(
                  height: 12,
                ),
                rowText('Price After',
                    widget.promotionsModel.priceAfterDiscount.toString()),
                const SizedBox(
                  height: 12,
                ),
                rowText('Date Start',
                    widget.promotionsModel.getStartDate().toString()),
                const SizedBox(
                  height: 12,
                ),
                rowText(
                    'End Date', widget.promotionsModel.getEndDate().toString()),
                const SizedBox(
                  height: 12,
                ),
                Text('Discription',
                    style: AppStyle.textViewStyleSmall(
                      context: context,
                      color: AppColors.colorBlueStart,
                      fontSizeDelta: 2,
                      fontWeightDelta: 2,
                    )),
                const SizedBox(
                  height: 12,
                ),
                Text(widget.promotionsModel.description.toString().capitalize(),
                    style: AppStyle.textViewStyleSmall(
                      context: context,
                      color: AppColors.colorBlack,
                      fontSizeDelta: 1,
                      fontWeightDelta: 0,
                    )),
              ],
            ),
          ),
        ],
      );

  Widget rowText(String first, String second) {
    return RichText(
      text: TextSpan(
        text: first + ':  ',
        style: AppStyle.textViewStyleSmall(
          context: context,
          color: AppColors.colorBlack,
          fontSizeDelta: 2,
          fontWeightDelta: 1,
        ),
        children: <TextSpan>[
          TextSpan(
              text: second,
              style: AppStyle.textViewStyleSmall(
                context: context,
                color: AppColors.colorBlueStart,
                fontSizeDelta: 2,
                fontWeightDelta: 1,
              )),
        ],
      ),
    );
  }
}

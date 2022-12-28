import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/Promotion_discount/View/promotion_banner.dart';
import 'package:otobucks/View/Promotion_discount/model/promotion_model.dart';
import 'package:otobucks/View/Home/Controllers/home_screen_controller.dart';


class BannerPageView extends StatefulWidget {
  final List<PromotionsModel> alPromotions;
  const BannerPageView({
    Key? key,
    required this.alPromotions,
  }) : super(key: key);
  @override
  BannerPageViewState createState() => BannerPageViewState();
}
class BannerPageViewState extends State<BannerPageView> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.alPromotions.isNotEmpty) {
      return LayoutBuilder(builder: (context, size) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(
            height: MediaQuery.of(context).size.width > 600
                ? size.maxWidth / 1.7
                : size.maxWidth / 1.3,
            child: PageView.builder(
              //this solves the overscroll indicator exception on promotion banner
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              controller: _pageController,
              itemBuilder: (context, index) {
                String strImage = widget.alPromotions[index].getPromoImage();
                PromotionsModel mPromotionsModel = widget.alPromotions[index];
                return PromotionBanner(
                    buttonText: 'View Details',
                    onTap: () {
                      Get.find<HomeScreenController>()
                          .promotionFragment(mPromotionsModel);
                    },
                    mPromotionsModel: mPromotionsModel,
                    strImage: strImage);
              },
              itemCount: widget.alPromotions.length,
            ),
          ),
        );
      });
    } else {
      return const SizedBox(height: 20);
    }
  }

  @override
  void dispose() {
    //timer.cancel();
    super.dispose();
  }
}

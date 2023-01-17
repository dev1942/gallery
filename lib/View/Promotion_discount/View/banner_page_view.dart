import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/Promotion_discount/View/promotion_banner.dart';
import 'package:otobucks/View/Promotion_discount/model/promotion_model.dart';
import 'package:otobucks/View/Home/Controllers/home_screen_controller.dart';

import '../../Dashboard/Controllers/dashboard_controller.dart';
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
  Timer ?_timer;
  int _currentPage = 0;
  final PageController _pageController = PageController(
    initialPage: 0
  );

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 800),
        curve: Curves.easeIn,
      );
    });
  }
  @override
  void dispose(){
    super.dispose();
  _timer?.cancel();

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
            child:

            PageView.builder(
              //this solves the overscroll indicator exception on promotion banner
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              controller: _pageController,
              itemBuilder: (context, index) {
                var promotionList=
                Get.put(DashboardController()).isHomePage==true?
                widget.alPromotions.where((element) => element.location=='homePage').toList():
                widget.alPromotions.where((element) => element.location=='servicePage').toList();
                PromotionsModel mPromotionsModel = promotionList[index];
                return

                  PromotionBanner(
                    buttonText: 'View Details',
                    onTap: () {
                      Get.find<HomeScreenController>()
                          .promotionFragment(mPromotionsModel);
                    },
                    mPromotionsModel: mPromotionsModel,
                    strImage: mPromotionsModel.getPromoImage());
              },
              itemCount:
              Get.put(DashboardController()).isHomePage==true?
              widget.alPromotions.where((element) => element.location=="homePage").length:
              widget.alPromotions.where((element) => element.location=="servicePage").length,
            ),
          ),
        );
      });
    } else {
      return const SizedBox(height: 20);
    }
  }


}

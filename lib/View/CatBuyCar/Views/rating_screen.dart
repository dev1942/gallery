import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/Dashboard/Controllers/dashboard_controller.dart';
import 'package:otobucks/View/Dashboard/Views/dashboard_fragment.dart';
import 'package:otobucks/View/Home/Views/home_page.dart';
import 'package:otobucks/View/SplashScreen/Controllers/splash_screen_controller.dart';
import 'package:otobucks/global/app_images.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/global/text_styles.dart';
import 'package:otobucks/services/repository/rating_repo.dart';
import 'package:otobucks/widgets/small_button.dart';

import '../../../global/app_colors.dart';
import '../../../global/constants.dart';
import '../../Dashboard/Views/dashboard_fragment_page_2.dart';
import '../../Home/Controllers/home_screen_controller.dart';

class RatingScreenCarBuy extends StatefulWidget {
  const RatingScreenCarBuy({
    Key? key,
  }) : super(key: key);

  @override
  RatingScreenCarBuyState createState() => RatingScreenCarBuyState();
}

class RatingScreenCarBuyState extends State<RatingScreenCarBuy> {
  var isLoading = false;
  double rating = 3.0;

  var feedback = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget widgetM = ListView(
      children: [
        const SizedBox(
          height: 50,
        ),
        Image.asset(
          AppImages.ic_thank_you_service,
          height: 170,
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.ic_thank_you,
              width: 190,
            ),
          ],
        ),
        Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 15),
            height: 50,
            child: RatingBar(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              ratingWidget: RatingWidget(
                full: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(color: AppColors.colorBlueStart, borderRadius: BorderRadius.circular(100)),
                  child: const Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                ),
                half: const Icon(Icons.star),
                empty: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(color: AppColors.grayDashboardText, borderRadius: BorderRadius.circular(100)),
                  child: const Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                ),
              ),
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              onRatingUpdate: (r) {
                rating = r;
              },
            )),
        Center(
          child: Text(
            'How was your experience'.tr,
            style: lightText(16),
          ),
        ),
        Center(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            width: 300,
            child: TextField(
              controller: feedback,
              maxLines: 6,
              decoration: InputDecoration(
                  hintText: 'Your FeedBack'.tr,
                  hintStyle: TextStyle(color: AppColors.grayDashboardText),
                  filled: true,
                  fillColor: HexColor('#FAFAFA'),
                  border: InputBorder.none),
            ),
          ),
        ),
        Center(
          child: SizedBox(
            height: 40,
            width: 150,
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : PrimaryButton(
                    label: Text('Submit'.tr),
                    onPress: () {
                      giveRating();
                    },
                    color: null),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.getMainBgColor(),
      body: SafeArea(
        child: Center(
          child: widgetM,
        ),
      ),
    );
  }

  giveRating() async {
    setState(() {
      isLoading = true;
    });

    HashMap<String, Object> requestParams = HashMap();
    requestParams['review'] = feedback.text;
    requestParams['rating'] = rating.toString();

    var categories = await RatingRepo().giveRating(requestParams);

    categories.fold((failure) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: failure.MESSAGE.contains('duplicate') ? 'Review is already submitted' : failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);
    }, (mResult) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: mResult.responseMessage.contains('success') ? 'Review Submitted' : mResult.responseMessage,
          toastType: TOAST_TYPE.toastSuccess);
    });
    setState(() {
      isLoading = false;
    });
    Get.put(HomeScreenController()).callback(PageType.home);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage()), (Route<dynamic> route) => false);
    Get.put(DashboardController()).refreshCategories();
  }
}

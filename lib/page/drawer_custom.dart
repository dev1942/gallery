import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/controllers/home_screen_controller.dart';
import 'package:otobucks/global/adaptive_helper.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/global/app_dimens.dart';
import 'package:otobucks/global/app_images.dart';
import 'package:otobucks/global/app_style.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/container_properties.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/model/drawer_item.dart';
import 'package:otobucks/widgets/language_dropdown.dart';
import 'package:url_launcher/url_launcher.dart';

Widget drawer(BuildContext context) {
  return Container(
    decoration: ContainerProperties.simpleDecoration(),
    // color: Colors.amber,
    width: Responsive.screenWidth / 1.4,
    height: Responsive.screenHeight,
    padding: const EdgeInsets.only(top: AppDimens.dimens_40),
    child: ListView(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.colorWhite,
          ),
          child: Column(
            children: [
              Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(right: AppDimens.dimens_20),
                  height: AppDimens.dimens_30,
                  child: LanguageDropdown(
                    isWhite: false,
                    onCallBack: () => Get.back(),
                  )),
              Container(
                  height: 120,
                  padding: const EdgeInsets.only(
                      left: AppDimens.dimens_5, right: AppDimens.dimens_5),
                  alignment: Alignment.center,
                  child: Image.asset(
                    AppImages.icSplashScreenIcon,
                    fit: BoxFit.fitWidth,
                  )),
            ],
          ),
        ),
        ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext contextM, index) {
              return getDrawerItem(alDrawerItem[index], context);
            },
            // shrinkWrap: true,
            itemCount: alDrawerItem.length),
        Container(
          height: 60,
          // width: 100,
          decoration: AppViews.getGradientBoxDecoration(mBorderRadius: 0),
          padding: const EdgeInsets.all(AppDimens.dimens_10),
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  AppImages.icAppIconWhite,
                  height: AppDimens.dimens_40,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _launchLink('https://www.linkedin.com/in/otobucksa4ba24b');
                },
                child: Container(
                  margin: const EdgeInsets.only(
                      left: AppDimens.dimens_5, right: AppDimens.dimens_5),
                  child: Image.asset(
                    AppImages.ic_linked,
                    height: AppDimens.dimens_20,
                    width: AppDimens.dimens_20,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _launchLink('https://www.facebook.com/otobucks/');
                },
                child: Container(
                  margin: const EdgeInsets.only(
                      left: AppDimens.dimens_5, right: AppDimens.dimens_5),
                  child: Image.asset(
                    AppImages.ic_drawer_facebook,
                    height: AppDimens.dimens_20,
                    width: AppDimens.dimens_20,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _launchLink('https://twitter.com/otobucks');
                },
                child: Container(
                  margin: const EdgeInsets.only(
                      left: AppDimens.dimens_5, right: AppDimens.dimens_5),
                  child: Image.asset(
                    AppImages.ic_twitter,
                    color: Colors.white,
                    height: AppDimens.dimens_22,
                    width: AppDimens.dimens_22,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _launchLink('https://www.instagram.com/otobuckss/');
                },
                child: Container(
                  margin: const EdgeInsets.only(
                      left: AppDimens.dimens_5, right: AppDimens.dimens_5),
                  child: Image.asset(
                    AppImages.ic_drawer_insta,
                    height: AppDimens.dimens_20,
                    width: AppDimens.dimens_20,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Future<void> _launchLink(String url) async {
  await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
}

getDrawerItem(DrawerItem mDrawerItem, BuildContext context) {
  return InkResponse(
    child: SizedBox(
      height: AppDimens.dimens_50,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(
                left: AppDimens.dimens_15, right: AppDimens.dimens_10),
            child: Image.asset(
              mDrawerItem.icon,
              color: AppColors.colorBlueStart,
              height: AppDimens.dimens_20,
              width: AppDimens.dimens_20,
            ),
          ),
          Expanded(
            child: Text(
              mDrawerItem.title.tr,
              style: AppStyle.textViewStyleNormalSubtitle2(
                  context: context,
                  color: AppColors.grayDashboardText,
                  fontWeightDelta: 1,
                  fontSizeDelta: -1),
            ),
          ),
          Constants.TAG_NOTIFICATION == mDrawerItem.title
              ? Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(100)),
                  margin: const EdgeInsets.only(
                      left: AppDimens.dimens_15, right: AppDimens.dimens_10),
                  child: Text(
                    "40",
                    style: AppStyle.textViewStyleNormalSubtitle2(
                        context: context,
                        color: AppColors.colorWhite,
                        fontWeightDelta: 1,
                        fontSizeDelta: -1),
                  )
                  // Image.asset(
                  //   mDrawerItem.icon,
                  //   color: AppColors.colorBlueStart,
                  //   height: AppDimens.dimens_20,
                  //   width: AppDimens.dimens_20,
                  // ),
                  )
              : const SizedBox(),
        ],
      ),
    ),
    onTap: () {
      if (MediaQuery.of(context).size.width < 600) {
        Navigator.pop(context);
      }
      if (mDrawerItem.pageType == PageType.logout) {
        Global.showLogoutDialog(Get.overlayContext!);
      } else {
        Get.find<HomeScreenController>().callback(mDrawerItem.pageType);
      }
    },
  );
}

var alDrawerItem = [
  DrawerItem(
      title: "Home", icon: AppImages.ic_home_white, pageType: PageType.home),
  DrawerItem(
      title: Constants.TAG_MY_PROFILE,
      icon: AppImages.ic_drawer_my_profile,
      pageType: PageType.myProfile),
  DrawerItem(
      title: Constants.TAG_BOOKING_HISTORY,
      icon: AppImages.ic_drawer_booking_history,
      pageType: PageType.bookingHistory),
  DrawerItem(
      title: Constants.TAG_ESTIMATION,
      icon: AppImages.ic_drawer_estimation,
      pageType: PageType.estimations),
  DrawerItem(
      title: Constants.TAG_PURCHASE_PRODUCT_HISTORY,
      icon: AppImages.ic_drawer_purchase_product,
      pageType: PageType.purchaseHistory),
  DrawerItem(
      title: Constants.TAG_NOTIFICATION,
      icon: AppImages.ic_drawer_notification,
      pageType: PageType.notification),
  DrawerItem(
      title: Constants.TAG_INBOX,
      icon: AppImages.ic_message,
      pageType: PageType.inbox),
  DrawerItem(
      title: Constants.TAG_TRANSACTION_HISTORY,
      icon: AppImages.ic_drawer_transection_history,
      pageType: PageType.transactionHistory),
  DrawerItem(
      title: Constants.TAG_ANALYTICS,
      icon: AppImages.ic_drawer_analytics,
      pageType: PageType.analytics),
  DrawerItem(
      title: Constants.TAG_WALLET,
      icon: AppImages.ic_drawer_wallet,
      pageType: PageType.wallet),
  DrawerItem(
      title: Constants.TAG_INVITE_EARN,
      icon: AppImages.ic_drawer_invite,
      pageType: PageType.invite),
  DrawerItem(
      title: Constants.TAG_RATINGS,
      icon: AppImages.ic_drawer_rating,
      pageType: PageType.ratings),
  DrawerItem(
      title: Constants.TAG_TERMS_CONDITIONS,
      icon: AppImages.ic_drawer_terms,
      pageType: PageType.terms),
  // DrawerItem(
  //     title: Constants.TAG_ABOUT_US,
  //     icon: AppImages.ic_drawer_about,
  //     pageType: PageType.aboutUs),
  DrawerItem(
      title: Constants.TAG_CUSTOMER,
      icon: AppImages.ic_whatsapp,
      pageType: PageType.whatsapp),
  DrawerItem(
      title: Constants.TAG_LOG_OUT,
      icon: AppImages.ic_drawer_logout,
      pageType: PageType.logout)
];

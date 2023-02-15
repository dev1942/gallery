// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/Promotion_discount/View/promotion_detail_view.dart';
import 'package:otobucks/View/Promotion_discount/model/promotion_model.dart';
import 'package:otobucks/View/Analytics/Views/analytics_fragment.dart';
import 'package:otobucks/View/Chat/Views/chat_history_framgment.dart';
import 'package:otobucks/View/InviteFriends/Views/invite_friend_fragment.dart';
import 'package:otobucks/View/Profile/View/my_profile_view.dart';
import 'package:otobucks/View/Rating/Views/my_rating_fragment.dart';
import 'package:otobucks/View/Notifications/Views/notification_framgment.dart';
import 'package:otobucks/View/PurchaseHistory/Views/purchase_history_fragment.dart';
import 'package:otobucks/View/TermsAndConditions/Views/terms_condition_fragment.dart';
import 'package:otobucks/View/ThankYou/Views/thankyou_fragment.dart';
import 'package:otobucks/View/Transactions/Views/transaction_history_framgment.dart';
import 'package:otobucks/View/Wallet/Views/wallet_fragment.dart';
import 'package:otobucks/global/app_views.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/View/Cart/Views/cart_screen.dart';
import 'package:otobucks/services/navigation_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Dashboard/Views/dashboard_fragment.dart';
import '../../Dashboard/Views/dashboard_fragment_page_2.dart';
import '../../Estimation/Views/estimation_screen.dart';

class HomeScreenController extends GetxController {
  int indexM = 0;

  Widget currentPage = const DashboardFragment();
  PageType currentPageType = PageType.home;
  bool isChange = false;
  bool isAppUpdate = false, isAppForceFullUpdate = false;
  late PromotionsModel promotionsModel;
  String firstName = "";
  String userId = "";
  String fullName = "";
  String image = "";
  String strTitle = " Hello ";

  final List<String> languages = ['English', 'Arabic'];
  String selectedLanguage = "English";

  void changeLocale(String locale) {
    switch (locale) {
      case 'English':
        Get.updateLocale(const Locale('en', 'UE'));
        selectedLanguage = "English";
        break;
      case 'Arabic':
        Get.updateLocale(const Locale('ar', 'AE'));
        selectedLanguage = 'Arabic';
        break;
      default:
        Get.updateLocale(const Locale('ar', 'AE'));
    }
    update();
  }

  void promotionFragment(PromotionsModel promotionsModel) {
    currentPageType = PageType.promotions;
    currentPage = PromotionDetailsScreen(
      promotionsModel: promotionsModel,
    );
    indexM = 0;
    strTitle = Constants.TAG_PURCHASE_PRODUCT_HISTORY;
    update();
  }

  void chatNowWithRoomId(String roomId) {}

  void callback(PageType nextPage) async {
    late Widget navigationPage = Container();
    currentPageType = nextPage;

    switch (nextPage) {
      case PageType.purchaseHistory:
        navigationPage = const PurchaseHistoryFragment();

        indexM = 0;
        strTitle = Constants.TAG_PURCHASE_PRODUCT_HISTORY;

        break;
      case PageType.aboutUs:
        navigationPage = const DashboardFragment();
        indexM = 0;
        strTitle = ' Hello ';

        break;
      case PageType.home:
        navigationPage = const DashboardFragment();
        indexM = 0;
        strTitle = ' Hello ';
        break;
      case PageType.home2:
        navigationPage = const DashboardFragmentPageTwo();
        indexM = 0;
        strTitle = ' Hello ';
        break;

      case PageType.myProfile:
        navigationPage = const MyProfileFragment();
        indexM = 2;
        strTitle = Constants.TXT_PROFILE;
        break;
      case PageType.estimations:
        navigationPage = EstimationFragment();
        strTitle = Constants.TAG_ESTIMATION;
        indexM = 0;
        break;

      case PageType.notification:
        navigationPage = const NotificationFragment();
        indexM = 1;
        strTitle = Constants.STR_NOTIFICATION;
        break;

      case PageType.inbox:
        navigationPage = const ChatHistoryFragment();
        indexM = 1;
        strTitle = Constants.STR_INBOX;
        break;
      case PageType.transactionHistory:
        navigationPage = const TransactionHistoryFragment();
        indexM = 0;
        strTitle = Constants.TAG_TRANSACTION_HISTORY;
        break;

      case PageType.analytics:
        navigationPage = const AnalyticsFragment();
        strTitle = Constants.TAG_ANALYTICS;
        indexM = 0;
        break;

      case PageType.wallet:
        navigationPage = const WalletFragment();
        strTitle = Constants.TAG_WALLET;
        indexM = 0;
        break;
      case PageType.invite:
        navigationPage = const InviteFriendFragment();
        strTitle = Constants.TXT_INVITE_FRIENDS;
        indexM = 0;
        break;

      case PageType.ratings:
        navigationPage = const MyRatingFragment();
        strTitle = Constants.TAG_RATINGS;
        indexM = 0;
        break;

      case PageType.terms:
        navigationPage = const TermsConditionFragment();
        strTitle = Constants.TAG_TERMS_CONDITIONS;
        indexM = 0;
        break;

      case PageType.thankYou:
        navigationPage = const ThankYouFragment();
        strTitle = Constants.STR_INBOX;
        break;
      case PageType.logout:
        break;
      case PageType.cart:
        // Global.inProgressAlert(Get.overlayContext!);
        navigationPage = const CartScreen();
        strTitle = 'Cart';
        indexM = 1;
        break;
      case PageType.promotions:
        break;
      case PageType.whatsapp:
        currentPageType = PageType.home;
        navigationPage = const DashboardFragment();
        indexM = 0;
        strTitle = ' Hello ';
        await launchUrl(Uri.parse('https://wa.me/+971542457866'), mode: LaunchMode.externalApplication);
        break;
      case PageType.bookingHistory:
        log("Booking history");
        break;
    }

    currentPage = navigationPage;
    update();
  }

  onChangeBottomBar(int index) {
    indexM = index;
    update();
    switch (index) {
      case 0:
        callback(PageType.home);
        break;
      // case 1:
      //   callback(PageType.inbox);
      //   break;
      // case 1:
      //   callback(PageType.cart);
      //callback(PageType.THANK_YOU);
      // gotoDemo();
      // break;
      case 1:
        callback(PageType.notification);
        break;
      case 2:
        callback(PageType.myProfile);
        break;
    }
  }

  Future<bool> onWillPop() async {
    if (currentPageType == PageType.home) {
      return showCustomAlertExitApp() ?? false;
    } else {
      callback(PageType.home);
      return false;
    }
  }

  getAccountName() async {
    Global.setLatLong();
    final prefManager = await SharedPreferences.getInstance();
    String? fName = prefManager.getString(SharedPrefKey.KEY_FIRST_NAME);
    String? uId = prefManager.getString(SharedPrefKey.KEY_USER_ID) ?? '';
    String? lName = prefManager.getString(SharedPrefKey.KEY_LAST_NAME);
    String? img = prefManager.getString(SharedPrefKey.KEY_USER_IMAGE);
    userId = uId;
    if (Global.checkNull(fName)) {
      firstName = ' ' + fName! + ' ';
    }
    if (Global.checkNull(lName)) {
      fullName = fName! + " " + lName!;
    }

    if (Global.checkNull(img) && img != null) {
      image = img;
    }
    update();
  }

  showCustomAlertExitApp() {
    AppViews.showCustomAlert(
        context: Get.overlayContext!,
        strTitle: Constants.TEXT_EXIT,
        strMessage: Constants.TEXT_EXIT_MSG,
        strLeftBtnText: Constants.TEXT_NO,
        onTapLeftBtn: () {
          NavigationService().back();
        },
        strRightBtnText: Constants.TEXT_YES,
        onTapRightBtn: () {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else {
            exit(0);
          }
        });
  }
}

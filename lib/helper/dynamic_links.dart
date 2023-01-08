import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/services/navigation_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../View/auth/View/registation_screen.dart';

class DynamicLinksApi {
  final dynamicLink = FirebaseDynamicLinks.instance;

  handleDynamicLink() async {
    PendingDynamicLinkData? pendingDynamicLinkData =
        await dynamicLink.getInitialLink();
    if (pendingDynamicLinkData != null) {
      handleSuccessLinking(pendingDynamicLinkData);
    }
    dynamicLink.onLink.listen((dynamicLinkData) {
      handleSuccessLinking(dynamicLinkData);
    }).onError((error) {
      log('onLink error');
      log(error.message);
    });
  }

  Future<String> createReferralLink(String referralCode) async {
    final DynamicLinkParameters dynamicLinkParameters = DynamicLinkParameters(
      uriPrefix: 'https://otobucks.page.link',
      link: Uri.parse('https://otobucks.com/refer?code=$referralCode'),
      androidParameters: const AndroidParameters(
          packageName: 'com.otobucks.app', minimumVersion: 0),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: 'Refer A Friend',
        description: 'Refer and earn',
        imageUrl:
            Uri.parse('https:otobucks.com/static/media/logo.539db792e67834bc51f2.png'),

        //  origionanal link >> https://d23jwszswncmo3.cloudfront.net/otobuckslogo.jpg
      ),
    );

    final ShortDynamicLink shortLink =
        await dynamicLink.buildShortLink(dynamicLinkParameters);

    final Uri dynamicUrl = shortLink.shortUrl;
    log("Generated Dynamic link: " + dynamicUrl.toString());
    return dynamicUrl.toString();
  }

  Future<void> handleSuccessLinking(PendingDynamicLinkData data) async {
    final Uri? deepLink = data.link;
    log("Depp Link:  " + deepLink.toString());
    if (deepLink != null) {
      var isRefer = deepLink.pathSegments.contains('refer');
      if (isRefer) {
        var code = deepLink.queryParameters['code'];
        log("Generated Dynamic link: " + code.toString());
        if (code != null) {
          SharedPreferences prefManager = await SharedPreferences.getInstance();
          bool? isLogin =
              prefManager.getBool(SharedPrefKey.KEY_IS_LOGIN) ?? false;
          if (!isLogin) {
            NavigationService().navigateTo(
                to: RegistrationScreen(
              referCode: code,
            ));
          }
        }
      }
    }
  }
}

import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:otobucks/preferences/preferences.dart';

import 'package:otobucks/services/repository/notification_repo.dart';
import 'package:otobucks/widgets/fade_in_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../global/app_colors.dart';
import '../../../../../../global/app_dimens.dart';
import '../../../../../../global/app_style.dart';
import '../../../../../../global/app_views.dart';
import '../../../../../../global/enum.dart';
import '../../../../../../global/global.dart';
import '../../../global/constants.dart';
import '../Models/notification_model.dart';

class NotificationFragment extends StatefulWidget {
  const NotificationFragment({Key? key}) : super(key: key);

  @override
  NotificationFragmentState createState() => NotificationFragmentState();
}

class NotificationFragmentState extends State<NotificationFragment> {
  ShowData mShowData = ShowData.showLoading;

  bool connectionStatus = false;
  bool isShowLoader = false;
  String userImage = "", userName = "";
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  Preferences preferences = Preferences();

  List<NotificationModel> alNotification = [];

  @override
  void initState() {
    super.initState();

    initConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    Widget widgetM = Container();

    Widget mShowWidget = ListView(
      children: [
        // profile pic and name
        Container(
          padding: const EdgeInsets.only(left: AppDimens.dimens_50, top: AppDimens.dimens_25, bottom: AppDimens.dimens_32),
          alignment: Alignment.center,
          color: AppColors.colorBlueStart,
          child: Row(
            children: [
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppDimens.dimens_50),
                  child: NetworkImageCustom(image: userImage, fit: BoxFit.fill, height: AppDimens.dimens_74, width: AppDimens.dimens_74),
                ),
                margin: const EdgeInsets.only(right: AppDimens.dimens_10),
              ),
              Flexible(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: AppStyle.textViewStyleNormalBodyText2(context: context, color: AppColors.colorWhite, fontSizeDelta: 0, fontWeightDelta: 1),
                  ),
                  Text(
                    "Car Owner",
                    style: AppStyle.textViewStyleSmall(
                        context: context, color: AppColors.colorWhite.withOpacity(0.7), fontSizeDelta: -1, fontWeightDelta: 1),
                  ),
                ],
              )),
            ],
          ),
        ),

        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            itemBuilder: (BuildContext contextM, index) {
              NotificationModel mNotificationModel = alNotification[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: AppColors.grayDashboardItem,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.only(top: 10, right: AppDimens.dimens_10, left: 10, bottom: 7),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  // margin: const EdgeInsets.only(bottom: AppDimens.dimens_14),

                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            top: 12,
                            left: 10,
                            right: AppDimens.dimens_10,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(AppDimens.dimens_5),
                            child: NetworkImageCustom(
                                image: Global.checkNull(mNotificationModel.image)
                                    ? mNotificationModel.image
                                    : "https://qph.cf2.quoracdn.net/main-thumb-1278318002-200-ydzfegagslcexelzgsnplcklfkienzfr.jpeg",
                                fit: BoxFit.fill,
                                height: 90,
                                width: 90),
                          ),
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(top: AppDimens.dimens_5, bottom: AppDimens.dimens_5),
                                child: Text(
                                  mNotificationModel.type.contains('estimate') ? 'Estimation Submitted ' : mNotificationModel.title,
                                  maxLines: 2,
                                  style: AppStyle.textViewStyleNormalBodyText2(
                                      context: context, color: AppColors.colorBlack2, fontSizeDelta: 0, fontWeightDelta: 2),
                                )),
                            Container(
                                margin: const EdgeInsets.only(bottom: AppDimens.dimens_5),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  mNotificationModel.getDate(),
                                  style: AppStyle.textViewStyleSmall(
                                      context: context, color: AppColors.grayDashboardText, fontSizeDelta: -2, fontWeightDelta: 0),
                                )),
                          ],
                        )),
                        SizedBox(
                          height: 90,
                          child: Icon(Icons.arrow_forward_ios_rounded, size: AppDimens.dimens_13, color: AppColors.colorBlueStart),
                        )
                      ],
                    ),
                    onTap: () {
                      log(userName);
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (_) => NotificationDetailsScreen(
                      //           notificationModel: mNotificationModel,
                      //           userImage: userImage,
                      //           userName: userName,
                      //         )));
                    },
                  ),
                ),
              );
            },
            itemCount: alNotification.length)
      ],
    );
    widgetM = AppViews.getSetDataNotification(context, mShowData, mShowWidget);
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.getMainBgColor(),
        body: Stack(
          children: [
            Container(
              color: AppColors.colorBlueStart,
              //height: AppDimens.dimens_120,
              height: 0,
            ),
            // Container(height: size.height, child: widgetM),
            widgetM,
            AppViews.showLoadingWithStatus(isShowLoader)
          ],
        ),
      ),
    );
  }

  Future<void> initConnectivity() async {
    final prefManager = await SharedPreferences.getInstance();

    String? userImage_ = prefManager.getString(SharedPrefKey.KEY_USER_IMAGE);
    String? _userFirstName = prefManager.getString(SharedPrefKey.KEY_FIRST_NAME);
    String? _userLastImage = prefManager.getString(SharedPrefKey.KEY_LAST_NAME);

    setState(() {
      if (Global.checkNull(userImage_)) {
        userImage = userImage_!;
      }
      if (Global.checkNull(_userFirstName) && Global.checkNull(_userLastImage)) {
        userName = _userFirstName! + " " + _userLastImage!;
      }
    });

    if (!mounted) {
      return;
    }

    // setState(() {
    //   if (connectionStatus) {
    //mShowData = ShowData.SHOW_DATA;
    getNotifications();
    // } else {
    //   Global.showNoInternetDialog(context);
    // }
    // });
  }

  getNotifications() async {
    setState(() {
      mShowData = ShowData.showLoading;
    });

    HashMap<String, Object> requestParams = HashMap();

    var categories = await NotificationsRepo().getNotifications(requestParams);

    categories.fold((failure) {
      Global.showToastAlert(context: context, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);
      setState(() {
        mShowData = ShowData.showNoDataFound;
      });
    }, (mResult) {
      setState(() {
        alNotification = mResult.responseData as List<NotificationModel>;

        if (alNotification.isNotEmpty) {
          mShowData = ShowData.showData;
          if (preferences.getnotificationId() != alNotification.last.id) {
            preferences.setNotificationId(alNotification.last.id);
            createanddisplaynotification(title: alNotification.last.title, body: alNotification.last.title, payload: alNotification.last.id);
          }
        } else {
          mShowData = ShowData.showNoDataFound;
        }
      });
    });
  }

  static void createanddisplaynotification({required String title, required String body, required String payload}) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "pushnotificationapp",
          "pushnotificationappchannel",
          importance: Importance.max,
          priority: Priority.high,
        ),
      );

      await _notificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails,
        payload: payload,
      );
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}

import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/Notifications/Views/NotificationController.dart';
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
  var controller = Get.put(NotificationsController());
  @override
  void initState() {
    super.initState();
    if (controller.alNotification.isEmpty) {
      controller.initConnectivity(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget widgetM = Container();

    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColors.getMainBgColor(),
          body: Obx(() => Stack(
                children: [
                  Container(
                    color: AppColors.colorBlueStart,
                    //height: AppDimens.dimens_120,
                    height: 0,
                  ),
                  // Container(height: size.height, child: widgetM),
                  widgetM,
                  AppViews.getSetDataNotification(context, controller.mShowData.value, mShowWidget(controller, context)),
                ],
              )),
        ));
  }
}

Widget mShowWidget(NotificationsController controller, BuildContext context) {
  Future<void> pullTorefrsh() async {
    controller.getNotifications(context);
  }

  return RefreshIndicator(
    onRefresh: pullTorefrsh,
    child: ListView(
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
                  child: NetworkImageCustom(image: controller.userImage, fit: BoxFit.fill, height: AppDimens.dimens_74, width: AppDimens.dimens_74),
                ),
                margin: const EdgeInsets.only(right: AppDimens.dimens_10),
              ),
              Flexible(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    controller.userName,
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
              NotificationModel mNotificationModel = controller.alNotification[index];
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
                      log(controller.userName);
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
            itemCount: controller.alNotification.length)
      ],
    ),
  );
}

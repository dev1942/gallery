import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/helper/dynamic_links.dart';
import 'package:otobucks/View/InviteFriends/Models/invite_joiners_model.dart';
import 'package:otobucks/services/repository/user_repo.dart';

class InviteAndEarnController extends GetxController {
  ShowData loadingInvite = ShowData.showData;
  ShowData loadingjoiners = ShowData.showData;

  String inviteLink = '';
  String customLink = '';

  List<InviteJoinersModel> inviteJoiners = [];

  bool connectionStatus = false;
  bool isShowLoader = false;
  TextEditingController controllerName = TextEditingController();

  TextEditingController controllerDate = TextEditingController();

  FocusNode nodeName = FocusNode();
  FocusNode nodeDate = FocusNode();
  final List<String> items = ['All', 'Active', 'Inactive'];
  String selectedValue = "All";

  copyText() {
    Clipboard.setData(ClipboardData(text: customLink)).then((value) {
      //only if ->
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: AppAlert.ALERT_TEXT_COPY, toastType: TOAST_TYPE.toastSuccess);
    });
  }

  Future<void> pullTorefreshData() async {
    getInviteCode();
    getMyInvites();
  }

  Future<void> getInviteCode() async {
    loadingjoiners = ShowData.showLoading;
    update();

    HashMap<String, Object> requestParams = HashMap();

    var categories = await UserRepo().getInviteCode(requestParams);

    categories.fold((failure) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);

      loadingjoiners = ShowData.showNoDataFound;
      update();
    }, (mResult) async {
      String code = mResult.responseData as String;
      if (Global.checkNull(code)) {
        inviteLink = await DynamicLinksApi().createReferralLink(code);
        customLink =
            "Hey! I got you something!\n\nOtobucks – AI powered customer centric car care app I'm using. Book anything from a doorstep eco-friendly car wash to a complete car service in a few simple steps with affordable pricing, free pick & drop and amazing customer care, you'll never worry about any car issues! \n $inviteLink \n Use my referral code $code at registration & get credits worth 10 Points!";
        loadingjoiners = ShowData.showData;
      } else {
        loadingjoiners = ShowData.showNoDataFound;
      }
      update();
    });
  }

  Future<void> getMyInvites() async {
    loadingInvite = ShowData.showLoading;
    update();

    HashMap<String, Object> requestParams = HashMap();

    var categories = await UserRepo().getMyInvites(requestParams);

    categories.fold((failure) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);

      loadingInvite = ShowData.showNoDataFound;
      update();
    }, (mResult) async {
      inviteJoiners = mResult.responseData as List<InviteJoinersModel>;
      if (inviteJoiners.isNotEmpty) {
        loadingInvite = ShowData.showData;
      } else {
        loadingInvite = ShowData.showNoDataFound;
      }
      update();
    });
  }
}

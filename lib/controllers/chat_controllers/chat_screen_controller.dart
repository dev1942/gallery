import 'dart:collection';

import 'package:get/get.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/model/my_rooms_model.dart';
import 'package:otobucks/services/repository/chat_repo.dart';

class ChatHistorController extends GetxController {
  ShowData mShowData = ShowData.showLoading;
  bool isShowLoader = false;

  List<MyRoomModel> rooms = [];

  getRooms() async {
    rooms.clear();
    mShowData = ShowData.showLoading;
    // isShowLoader = true
    update();

    HashMap<String, Object> requestParams = HashMap();

    var alTransactions = await ChatRepo().getMyRooms(requestParams);

    alTransactions.fold((failure) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);

      mShowData = ShowData.showNoDataFound;
      update();
    }, (mResult) {
      rooms = mResult.responseData as List<MyRoomModel>;
      if (rooms.isNotEmpty) {
        mShowData = ShowData.showData;
      } else {
        mShowData = ShowData.showNoDataFound;
      }
      update();
    });
  }
}

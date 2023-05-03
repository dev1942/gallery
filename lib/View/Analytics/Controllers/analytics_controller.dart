import 'dart:collection';

import 'package:get/get.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/View/Wallet/Models/wallet_model.dart';
import 'package:otobucks/services/repository/wallet_repo.dart';

class AnalyticsController extends GetxController {
  ShowData loadingCards = ShowData.showData;
  ShowData loadingWalletBalance = ShowData.showData;

  bool connectionStatus = false;
  bool isShowLoader = false;

  WalletModel mWalletModel = WalletModel(
    totalWithdraw: '0',
    earning: '0',
    balance: "0",
    currency: 'AED',
    id: '',
    stripeWallet: '',
    user: '',
    userType: '',
  );
//----------------------------get statistics data From api------------------

  Future<void> getAllData() async {
    await Future.wait([getWallet()]);
  }

  Future<void> getWallet() async {
    loadingWalletBalance = ShowData.showLoading;
    update();

    // isShowLoader = true;

    HashMap<String, Object> requestParams = HashMap();

    var categories = await WalletRepo().getWalletAndEarning(requestParams);

    categories.fold((failure) {
      Global.showToastAlert(
          context: Get.overlayContext!,
          strTitle: "",
          strMsg: failure.MESSAGE,
          toastType: TOAST_TYPE.toastError);

      loadingWalletBalance = ShowData.showNoDataFound;
      update();
    }, (mResult) {
      mWalletModel = mResult.responseData as WalletModel;

      loadingWalletBalance = ShowData.showData;
      update();
    });
  }
}

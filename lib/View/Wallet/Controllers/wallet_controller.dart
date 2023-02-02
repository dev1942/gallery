import 'dart:collection';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:otobucks/View/Transactions/Models/add_bank_account_model.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/View/CheckOut/Models/card_model.dart';
import 'package:otobucks/View/Wallet/Models/wallet_model.dart';
import 'package:otobucks/services/repository/card_repo.dart';
import 'package:otobucks/services/repository/wallet_repo.dart';
import '../../../widgets/custom_ui/carousel_slider/carousel_controller.dart';

class WalletController extends GetxController {
  ShowData loadingCards = ShowData.showData;
  ShowData loadingWalletBalance = ShowData.showData;
  bool connectionStatus = false;
  bool isShowLoader = false;
  final CarouselController controller = CarouselController();

  List<CardModel> alCardModel = [];
  WalletModel mWalletModel = WalletModel(
    totalWithdraw: '0',
    earning: '0',
    balance: "0",
    currency: 'USD',
    id: '',
    stripeWallet: '',
    user: '',
    userType: '',
  );

  Future<void> getAllData() async {
    await Future.wait([getWallet(), getCardsMine()]);
  }

  Future<void> getWallet() async {
    loadingWalletBalance = ShowData.showLoading;
    update();
    // isShowLoader = true;

    HashMap<String, Object> requestParams = HashMap();

    var categories = await WalletRepo().getWalletAndEarning(requestParams);

    categories.fold((failure) {
      log(failure.toString());
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);

      loadingWalletBalance = ShowData.showNoDataFound;
      update();
    }, (mResult) {
      log(mResult.toString());
      mWalletModel = mResult.responseData as WalletModel;

      loadingWalletBalance = ShowData.showData;
      update();
    });
  }

  Future<void> getCardsMine() async {
    loadingCards = ShowData.showLoading;
    // isShowLoader = true;
    update();

    HashMap<String, Object> requestParams = HashMap();

    var categories = await CardRepo().getCards(requestParams);

    categories.fold((failure) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);
      loadingCards = ShowData.showNoDataFound;
      update();
    }, (mResult) {
      alCardModel = mResult.responseData as List<CardModel>;
      if (alCardModel.isNotEmpty) {
        loadingCards = ShowData.showData;
      } else {
        loadingCards = ShowData.showNoDataFound;
      }
      update();
    });
  }

  addNewCard(String number, int month, int year, String cvc, String name) async {
    loadingCards = ShowData.showLoading;

    update(); // isShowLoader = true;

    HashMap<String, Object> requestParams = HashMap();
    requestParams['number'] = number;
    requestParams['exp_month'] = month;
    requestParams['exp_year'] = year;
    requestParams['name'] = name;
    requestParams['cvc'] = cvc;

    var categories = await CardRepo().addCard(requestParams);

    categories.fold((failure) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);
      loadingCards = ShowData.showNoDataFound;
      update();
    }, (mResult) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: mResult.responseMessage, toastType: TOAST_TYPE.toastSuccess);
      getCardsMine();
    });
  }

  addBankAccount(AddBankAccountModel model) async {
    isShowLoader = true;

    update(); // isShowLoader = true;

    HashMap<String, Object> requestParams = HashMap();
    requestParams['account_holder_name'] = model.accHolderName;
    requestParams['account_holder_type'] = model.accHolderType;
    requestParams['account_number'] = model.accountNumber;
    requestParams['bank_name'] = model.bankName;
    requestParams['branchName'] = model.branchName;
    requestParams['country'] = model.country;
    requestParams['currency'] = model.currency;
    requestParams['IBAN_Number'] = model.ibanNumber;
    requestParams['routing_number'] = model.routingNumber;
    requestParams['swiftCode'] = model.swiftCode;

    var categories = await WalletRepo().addBankAccount(requestParams);

    categories.fold((failure) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);
      isShowLoader = false;
      update();
    }, (mResult) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: mResult.responseMessage, toastType: TOAST_TYPE.toastSuccess);
      isShowLoader = false;
      update();
    });
  }

  addMoney(String id, int amount) async {
    loadingWalletBalance = ShowData.showLoading;

    update(); // isShowLoader = true;

    HashMap<String, Object> requestParams = HashMap();
    requestParams['source'] = id;
    requestParams['amount'] = amount;

    var categories = await WalletRepo().addMoney(requestParams);

    categories.fold((failure) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);
      loadingWalletBalance = ShowData.showNoDataFound;
      update();
    }, (mResult) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: mResult.responseMessage, toastType: TOAST_TYPE.toastSuccess);
      getWallet();
    });
  }

  deletecard(String cardId) async {
    loadingCards = ShowData.showLoading;
    update();
    HashMap<String, Object> requestParams = HashMap();
    requestParams['cardId'] = cardId;

    var categories = await CardRepo().deletecard(requestParams);

    categories.fold((failure) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);
      loadingCards = ShowData.showNoDataFound;
      update();
    }, (mResult) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: mResult.responseMessage, toastType: TOAST_TYPE.toastSuccess);
      getCardsMine();
    });
  }
}

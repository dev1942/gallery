import 'dart:collection';

import 'package:get/get.dart';
import 'package:otobucks/View/CatBuyCar/models/carsListModel.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';

import '../../../services/repository/buy_car_repo.dart';

class BuyCarController extends GetxController {
  Rx<ShowData> mShowData = ShowData.showData.obs;

  bool connectionStatus = false;
  bool isShowLoader = false;
  CarsListModel? carsListModel;

//----------------------------get Car List From api available for purchasing------------------

  Future<void> getCarsList() async {
    mShowData.value = ShowData.showLoading;
    update();

    // isShowLoader = true;

    HashMap<String, Object> requestParams = HashMap();

    var categories = await BuyCarRepo().getCarsList(requestParams);

    categories.fold((failure) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);

      mShowData.value = ShowData.showNoDataFound;
      update();
    }, (mResult) {
      carsListModel = mResult.responseData as CarsListModel;

      mShowData.value = ShowData.showData;
      update();
    });
  }

  // loginUserTask(BuildContext context) async {
  //   if (!isValid(context) || !(await initConnectivity(context))) {
  //     return;
  //   }
  //   isShowLoader = true;
  //   update();

  //   String strEmailID = controllerEmail.text.toString().trim();
  //   String strPassword = controllerPassword.text.toString();
  //   String firebaseToken = await FirebaseMessaging.instance.getToken() ?? '';
  //   Logger().i(firebaseToken);
  //   log(firebaseToken);
  //   await Global.taskStoreToken(firebaseToken);
  //   HashMap<String, Object> requestParams = HashMap();
  //   requestParams[PARAMS.PARAM_EMAIL] = strEmailID;
  //   requestParams[PARAMS.PARAM_PASSWORD] = strPassword;
  //   requestParams[PARAMS.PARAM_FIREBASE_TOKEN] = firebaseToken;
  //   log('Firebase Token->> $firebaseToken');

  //   var signInEmail = await LoginRepo().login(requestParams);

  //   isShowLoader = false;
  //   update();

  //   signInEmail.fold((failure) {
  //     inspect(failure);
  //     Global.showToastAlert(context: context, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);
  //     if ("Please verify your otp first" == failure.MESSAGE) {
  //       var data = failure.DATA as Map;

  //       mobileNumberForVerifcation = data["mobileNumber"];
  //       log("faliure data" + mobileNumberForVerifcation!);

  //       // TODO:
  //       gotoMobileOTPScreen(context);
  //     }
  //   }, (mResult) {
  //     navigateToHomePage(context);
  //   });
  // }
}

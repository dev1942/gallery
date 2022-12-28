import 'dart:collection';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:otobucks/global/connectivity_status.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/View/Cart/Models/cart_model.dart';
import '../../global/Models/failure.dart';
import '../../global/Models/result.dart';
import '../../global/Models/success.dart';
import 'package:otobucks/services/rest_api/request_listener.dart';

class CartRepo {
  Future<Either<Failure, Success>> getMyCarts(
      HashMap<String, Object> requestParams) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(
          DATA: "",
          MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION,
          STATUS: false));
    }
    try {
      String response = await ReqListener.fetchPost(
          strUrl: 'cart/mine',
          requestParams: requestParams,
          mReqType: ReqType.get,
          mParamType: ParamType.simple);
      Result? mResponse;
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(
            Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        List<CartModel> carts = [];
        Map map = mResponse?.responseData as Map;
        List data = map['items'];

        for (var dataItem in data) {
          CartModel card = CartModel.fromMap(dataItem);
          carts.add(card);
        }

        Success mSuccess = Success(
            responseStatus: mResponse!.responseStatus,
            responseData: carts,
            responseMessage: mResponse.responseMessage);

        return Right(mSuccess);
      }

      if (!Global.checkNull(mResponse!.responseMessage)) {
        mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
      }

      return Left(Failure(
          MESSAGE: mResponse.responseMessage,
          STATUS: false,
          DATA: mResponse.responseData != null
              ? mResponse.responseData as Object
              : ""));
    } catch (e) {
      log(e.toString());
      return Left(Failure(
          STATUS: false,
          MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING,
          DATA: ""));
    }
  }

  // Future<Either<Failure, Success>> addCard(
  //     HashMap<String, Object> requestParams) async {
  //   bool connectionStatus = await ConnectivityStatus.isConnected();
  //   if (!connectionStatus) {
  //     return Left(Failure(
  //         DATA: "",
  //         MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION,
  //         STATUS: false));
  //   }
  //   try {
  //     String response = await ReqListener.fetchPost(
  //         strUrl: 'cards',
  //         requestParams: requestParams,
  //         mReqType: ReqType.post,
  //         mParamType: ParamType.json);
  //     Result? mResponse;
  //     if (response.isNotEmpty) {
  //       mResponse = Global.getData(response);
  //     } else {
  //       return Left(
  //           Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
  //     }

  //     if (mResponse?.responseStatus == true) {
  //       Success mSuccess = Success(
  //           responseStatus: mResponse!.responseStatus,
  //           responseData: {},
  //           responseMessage: mResponse.responseMessage);

  //       return Right(mSuccess);
  //     }

  //     if (!Global.checkNull(mResponse!.responseMessage)) {
  //       mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
  //     }

  //     return Left(Failure(
  //         MESSAGE: mResponse.responseMessage,
  //         STATUS: false,
  //         DATA: mResponse.responseData != null
  //             ? mResponse.responseData as Object
  //             : ""));
  //   } catch (e) {
  //     log(e.toString());
  //     return Left(Failure(
  //         STATUS: false,
  //         MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING,
  //         DATA: ""));
  //   }
  // }

  // Future<Either<Failure, Success>> deletecard(
  //     HashMap<String, Object> requestParams) async {
  //   bool connectionStatus = await ConnectivityStatus.isConnected();
  //   if (!connectionStatus) {
  //     return Left(Failure(
  //         DATA: "",
  //         MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION,
  //         STATUS: false));
  //   }
  //   try {
  //     String response = await ReqListener.fetchPost(
  //         strUrl: 'cards',
  //         requestParams: requestParams,
  //         mReqType: ReqType.delete,
  //         mParamType: ParamType.json);
  //     Result? mResponse;
  //     if (response.isNotEmpty) {
  //       mResponse = Global.getData(response);
  //     } else {
  //       return Left(
  //           Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
  //     }

  //     if (mResponse?.responseStatus == true) {
  //       Success mSuccess = Success(
  //           responseStatus: mResponse!.responseStatus,
  //           responseData: {},
  //           responseMessage: mResponse.responseMessage);

  //       return Right(mSuccess);
  //     }

  //     if (!Global.checkNull(mResponse!.responseMessage)) {
  //       mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
  //     }

  //     return Left(Failure(
  //         MESSAGE: mResponse.responseMessage,
  //         STATUS: false,
  //         DATA: mResponse.responseData != null
  //             ? mResponse.responseData as Object
  //             : ""));
  //   } catch (e) {
  //     log(e.toString());
  //     return Left(Failure(
  //         STATUS: false,
  //         MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING,
  //         DATA: ""));
  //   }
  // }
}

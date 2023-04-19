import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:otobucks/global/connectivity_status.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/global/url_collection.dart';
import '../../View/CatBuyCar/models/carsListModel.dart';
import '../../global/Models/failure.dart';
import '../../global/Models/result.dart';
import '../../global/Models/success.dart';
import 'package:otobucks/services/rest_api/request_listener.dart';

class BuyCarRepo {
  Future<Either<Failure, Success>> getCarsList(HashMap<String, Object> requestParams) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(DATA: "", MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION, STATUS: false));
    }
    try {
      String response = await ReqListener.fetchPost(
          strUrl: RequestBuilder.API_CARS_BUY_LIST, requestParams: requestParams, mReqType: ReqType.get, mParamType: ParamType.simple);
      Result? mResponse;
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        CarsListModel carsListModel = carsListModelFromMap(response);

        List data = mResponse?.responseData as List;

        Success mSuccess =
            Success(responseStatus: mResponse!.responseStatus, responseData: carsListModel, responseMessage: mResponse.responseMessage);

        return Right(mSuccess);
      }

      if (Global.checkNull(mResponse!.responseMessage)) {
        mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
      }

      return Left(
          Failure(MESSAGE: mResponse.responseMessage, STATUS: false, DATA: mResponse.responseData != null ? mResponse.responseData as Object : ""));
    } catch (e) {
      log(e.toString());
      return Left(Failure(STATUS: false, MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING, DATA: ""));
    }
  }

  Future<Either<Failure, Success>> sendInquiryForCar(HashMap<String, Object> requestParams) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(DATA: "", MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION, STATUS: false));
    }

    try {
      String response = await ReqListener.fetchPost(
          strUrl: RequestBuilder.API_CARS_INQUIRY, requestParams: requestParams, mReqType: ReqType.post, mParamType: ParamType.json);

      log(response);
      Result? mResponse;
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        Map data = jsonDecode(response);
        log(response);

        var objData = data['data'];
        log(data.toString());

        Success mSuccess = Success(responseStatus: mResponse!.responseStatus, responseData: "", responseMessage: mResponse.responseMessage);

        return Right(mSuccess);
      }

      if (!Global.checkNull(mResponse!.responseMessage)) {
        mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
      }

      return Left(
          Failure(MESSAGE: mResponse.responseMessage, STATUS: false, DATA: mResponse.responseData != null ? mResponse.responseData as Object : ""));
    } catch (e) {
      log(e.toString());
      return Left(Failure(STATUS: false, MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING, DATA: ""));
    }
  }

  Future<Either<Failure, Success>> filterCars(HashMap<String, Object> requestParams) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(DATA: "", MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION, STATUS: false));
    }

    try {
      String response = await ReqListener.fetchPost(
          strUrl: RequestBuilder.API_FILTER_CARS, requestParams: requestParams, mReqType: ReqType.post, mParamType: ParamType.json);

      log(response);
      Result? mResponse;
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        CarsListModel carsListModel = carsListModelFromMap(response);

        Success mSuccess =
            Success(responseStatus: mResponse!.responseStatus, responseData: carsListModel, responseMessage: mResponse.responseMessage);

        return Right(mSuccess);
      }

      if (!Global.checkNull(mResponse!.responseMessage)) {
        mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
      }

      return Left(
          Failure(MESSAGE: mResponse.responseMessage, STATUS: false, DATA: mResponse.responseData != null ? mResponse.responseData as Object : ""));
    } catch (e) {
      log(e.toString());
      return Left(Failure(STATUS: false, MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING, DATA: ""));
    }
  }
}

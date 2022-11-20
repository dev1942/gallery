

import 'dart:collection';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/global/url_collection.dart';
import 'package:otobucks/services/rest_api/request_listener.dart';
import '../../View/Profile/Model/car_list_model.dart';
import '../../global/connectivity_status.dart';
import '../../model/failure.dart';
import '../../model/result.dart';
import '../../model/success.dart';

class MyProfileRepository {

  Future<Either<Failure, Success>> getCarList(
      HashMap<String, Object> requestParams,) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(
          DATA: "",
          MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION,
          STATUS: false));
    }
    try {
      String response = await ReqListener.fetchPost(
          strUrl: RequestBuilder.API_GET_CAR_LIST,
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
        List<GetCarModelResult> carList = [];
        List data = mResponse?.responseData as List;
        for (var dataItem in data) {
        //  GetCarModel mCategoryModel = GetCarModel.fromJson(dataItem);
        //  GetCarModel mCategoryModel = GetCarModel.fromJson(dataItem);
          carList.add(GetCarModelResult.fromJson(dataItem));
        }
       log("ibraim car list-------------");
         log(carList.length.toString());
        // log(carList.first.mileage.toString());
         log(carList.length.toString());
        Success mSuccess = Success(
            responseStatus: mResponse!.responseStatus,
            responseData: carList,
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

  Future<Either<Failure, Success>> addCar(
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
          strUrl: RequestBuilder.API_ADD_CAR_LIST,
          requestParams: requestParams,
          mReqType: ReqType.post,
          mParamType: ParamType.json);
      Result? mResponse;
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(
            Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        Success mSuccess = Success(
            responseStatus: mResponse!.responseStatus,
            responseData: {},
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

  Future<Either<Failure, Success>> deletecar(
      HashMap<String, Object> requestParams,String id) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(
          DATA: "",
          MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION,
          STATUS: false));
    }
    try {
      String response = await ReqListener.fetchPost(
          strUrl:RequestBuilder.API_DELETE_CAR_ + id,
          requestParams: requestParams,
          mReqType: ReqType.delete,
          mParamType: ParamType.json);
      Result? mResponse;
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(
            Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        Success mSuccess = Success(
            responseStatus: mResponse!.responseStatus,
            responseData: {},
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

  Future<Either<Failure, Success>> updatecar(
      HashMap<String, Object> requestParams,String id) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(
          DATA: "",
          MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION,
          STATUS: false));
    }
    try {
      String response = await ReqListener.fetchPost(
          strUrl:RequestBuilder.API_DELETE_CAR_ + id,
          requestParams: requestParams,
          mReqType: ReqType.patch,
          mParamType: ParamType.json);
      Result? mResponse;
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(
            Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        Success mSuccess = Success(
            responseStatus: mResponse!.responseStatus,
            responseData: {},
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
}
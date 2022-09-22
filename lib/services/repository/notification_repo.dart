import 'dart:collection';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:otobucks/global/connectivity_status.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/global/url_collection.dart';
import 'package:otobucks/model/failure.dart';
import 'package:otobucks/model/result.dart';
import 'package:otobucks/model/success.dart';
import 'package:otobucks/services/rest_api/request_listener.dart';

import '../../model/category_model.dart';
import '../../model/notification_model.dart';

class NotificationsRepo {
  Future<Either<Failure, Success>> getNotifications(
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
          strUrl: RequestBuilder.API_GET_NOTIFICATIONS,
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
        List<NotificationModel> alNotification = [];
        List data = mResponse?.responseData as List;
        for (var dataItem in data) {
          NotificationModel mNotificationModel =
              NotificationModel.fromJson(dataItem);
          alNotification.add(mNotificationModel);
        }

        Success mSuccess = Success(
            responseStatus: mResponse!.responseStatus,
            responseData: alNotification,
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

  Future<Either<Failure, Success>> getSubCategories(
      HashMap<String, Object> requestParams, String categoryID) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(
          DATA: "",
          MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION,
          STATUS: false));
    }
    try {
      String response = await ReqListener.fetchPost(
          strUrl: RequestBuilder.API_GET_SUB_CATEGORIES + categoryID,
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
        List<CategoryModel> alCategory = [];
        List data = mResponse?.responseData as List;
        for (var dataItem in data) {
          CategoryModel mCategoryModel = CategoryModel.fromJson(dataItem);
          alCategory.add(mCategoryModel);
        }

        Success mSuccess = Success(
            responseStatus: mResponse!.responseStatus,
            responseData: alCategory,
            responseMessage: mResponse.responseMessage);

        return Right(mSuccess);
      }

      return Left(Failure(
          MESSAGE: mResponse!.responseMessage,
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

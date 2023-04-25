import 'dart:collection';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:otobucks/global/connectivity_status.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/global/url_collection.dart';
import '../../global/Models/failure.dart';
import '../../global/Models/result.dart';
import '../../global/Models/success.dart';
import 'package:otobucks/services/rest_api/request_listener.dart';

import '../../View/Dashboard/Models/category_model.dart';
import '../../View/Services_All/Models/service_model.dart';

class ServicesRepo {
  Future<Either<Failure, Success>> getServices(HashMap<String, Object> requestParams,
      {required String catId, required String subCatId, String? lat, String? long}) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(DATA: "", MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION, STATUS: false));
    }
    try {
      String url = "${RequestBuilder.API_GET_SERVICES_SIMPLE}?category=$catId&subcategory=$subCatId";

      // if (lat != null) {
      //   url = "${RequestBuilder.API_GET_SERVICES_SIMPLE}?category=$catId&subcategory=$subCatId&longitude$long&latitude=$lat";
      // }
      String response = await ReqListener.fetchPost(strUrl: url, requestParams: requestParams, mReqType: ReqType.get, mParamType: ParamType.simple);
      log(url);
      Result? mResponse;
      if (response.isNotEmpty) {
        log(response);
        mResponse = Global.getData(response);
      } else {
        return Left(Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        List<ServiceModel> alServices = [];
        List data = mResponse?.responseData as List;
        for (var dataItem in data) {
          log("this is before parsing services");
          ServiceModel mServiceModel = ServiceModel.fromJson(dataItem);
          alServices.add(mServiceModel);
        }

        Success mSuccess = Success(responseStatus: mResponse!.responseStatus, responseData: alServices, responseMessage: mResponse.responseMessage);

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

  Future<Either<Failure, Success>> getServiceDetails(HashMap<String, Object> requestParams, {required String serviceId}) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(DATA: "", MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION, STATUS: false));
    }
    try {
      String response = await ReqListener.fetchPost(
          strUrl: RequestBuilder.API_GET_SERVICES + serviceId, requestParams: requestParams, mReqType: ReqType.get, mParamType: ParamType.simple);
      Result? mResponse;
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        List<CategoryModel> alCategory = [];
        List data = mResponse?.responseData as List;
        for (var dataItem in data) {
          CategoryModel mCategoryModel = CategoryModel.fromJson(dataItem);
          alCategory.add(mCategoryModel);
        }

        Success mSuccess = Success(responseStatus: mResponse!.responseStatus, responseData: alCategory, responseMessage: mResponse.responseMessage);

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

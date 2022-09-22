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

import '../../model/promotion_model.dart';

class PromotionsRepo {
  Future<Either<Failure, Success>> getPromotions(
      HashMap<String, Object> requestParams, BannerType mBannerType) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(
          DATA: "",
          MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION,
          STATUS: false));
    }
    try {
      String response = await ReqListener.fetchPost(
          strUrl: RequestBuilder.API_GET_PROMOTIONS,
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
        List<PromotionsModel> alPromotions = [];
        List data = mResponse?.responseData as List;
        for (var dataItem in data) {
          PromotionsModel mCategoryModel = PromotionsModel.fromJson(dataItem);
          if (mCategoryModel.location == 'homePage') {
            alPromotions.add(mCategoryModel);
          }
          if (mCategoryModel.location != 'homePage') {
            alPromotions.add(mCategoryModel);
          }
        }

        Success mSuccess = Success(
            responseStatus: mResponse!.responseStatus,
            responseData: alPromotions,
            responseMessage: mResponse.responseMessage);

        return Right(mSuccess);
      }

      if (Global.checkNull(mResponse!.responseMessage)) {
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

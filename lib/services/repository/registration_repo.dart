import 'dart:collection';
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


class RegistrationRepo {
  Future<Either<Failure, Success>> registration(
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
          strUrl: RequestBuilder.API_SIGN_UP,
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
            responseData: "mUserAddressDetail",
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
      return Left(Failure(
          STATUS: false,
          MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING,
          DATA: ""));
    }
  }
}

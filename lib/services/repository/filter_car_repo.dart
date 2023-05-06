import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:otobucks/global/connectivity_status.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/global/url_collection.dart';
import '../../View/CatCarSell/models/FilterListModel.dart';
import '../../global/Models/failure.dart';
import '../../global/Models/success.dart';
import 'package:otobucks/services/rest_api/request_listener.dart';

class FilterRepo {

  Future<Either<Failure, Success>> filterList(HashMap<String, Object> requestParams) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(DATA: "", MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION, STATUS: false));
    }

    try {
      String response = await ReqListener.fetchPost(
          strUrl: RequestBuilder.API_FILTER_LIST, requestParams: requestParams, mReqType: ReqType.get, mParamType: ParamType.json);

      log(response);
      print("Testing List Api A");
      FilterListModel? filterList;
      if (response.isNotEmpty) {
       var mResponse =jsonDecode(response);
       print("Testing List Api B $mResponse");
       filterList=FilterListModel.fromJson(mResponse);
       print("Testing List Api B2");
      } else {
        print("Testing List Api C");
        return Left(Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }
      print("Testing List Api D");

      if (filterList.status=="success") {

        print("Testing List Api E");
        Success mSuccess =
            Success(responseStatus: true, responseData: filterList, responseMessage: "Filter List");

        return Right(mSuccess);
      }
      print("Testing List Api F");

      // if (!Global.checkNull(mResponse!.responseMessage)) {
      //   mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
      // }

      return Left(
          Failure(MESSAGE: filterList.status!, STATUS: false, DATA: filterList.result != null ? filterList.result as Object : ""));
    } catch (e) {
      print("Testing List Api catch $e");
      log(e.toString());
      return Left(Failure(STATUS: false, MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING, DATA: ""));
    }
  }


  filtersList(HashMap<String, Object> requestParams) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(DATA: "", MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION, STATUS: false));
    }

    // try {
      String response = await ReqListener.fetchPost(
          strUrl: RequestBuilder.API_FILTER_LIST, requestParams: requestParams, mReqType: ReqType.get, mParamType: ParamType.json);

      log(response);
      print("Testing List Api A");
      FilterListModel? filterList;
      if (response.isNotEmpty) {
       var mResponse =jsonDecode(response);
       print("Testing List Api B $mResponse");
       filterList=FilterListModel.fromJson(mResponse);


      print("Testing List Api F");

      // if (!Global.checkNull(mResponse!.responseMessage)) {
      //   mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
       }

      return  filterList;
    // } catch (e) {
    //   print("Testing List Api catch $e");
    //   log(e.toString());
    //   return Left(Failure(STATUS: false, MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING, DATA: ""));
    // }
  }
}

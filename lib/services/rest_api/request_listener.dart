// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/url_collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReqListener {
  static Future<String> fetchPost(
      {required String strUrl,
      required HashMap<String, Object> requestParams,
      required ReqType mReqType,
      required ParamType mParamType}) async {
    HashMap<String, String> lHeaders = HashMap();

    final prefs = await SharedPreferences.getInstance();
    String? accesToken = prefs.getString(SharedPrefKey.KEY_ACCESS_TOKEN);
    if (accesToken != null && accesToken.isNotEmpty) {
      String accesTokenType = Constants.strTokenType;
      accesToken = accesTokenType + " " + accesToken;
      lHeaders[PARAMS.PARAM_AUTHORIZATION] = accesToken;
    }

    if (mParamType == ParamType.json) {
      lHeaders["Content-Type"] = "application/json";
      lHeaders["Accept"] = "application/json";
    }
    late http.Response? response;

    switch (mReqType) {
      case ReqType.get:
        response = await http
            .get(Uri.parse(RequestBuilder.API_BASE_URL + strUrl),
                headers: lHeaders)
            .timeout(const Duration(minutes: 3));
        break;
      case ReqType.post:
        response = await http
            .post(Uri.parse(RequestBuilder.API_BASE_URL + strUrl),
                body: mParamType == ParamType.json
                    ? jsonEncode(requestParams)
                    : requestParams,
                headers: lHeaders)
            .timeout(const Duration(minutes: 3));
        break;
      case ReqType.patch:
        response = await http
            .patch(Uri.parse(RequestBuilder.API_BASE_URL + strUrl),
                body: mParamType == ParamType.json
                    ? jsonEncode(requestParams)
                    : requestParams,
                headers: lHeaders)
            .timeout(const Duration(minutes: 3));
        break;
      case ReqType.put:
        response = await http
            .put(Uri.parse(RequestBuilder.API_BASE_URL + strUrl),
                body: mParamType == ParamType.json
                    ? jsonEncode(requestParams)
                    : requestParams,
                headers: lHeaders)
            .timeout(const Duration(minutes: 3));
        break;
      case ReqType.delete:
        response = await http
            .delete(Uri.parse(RequestBuilder.API_BASE_URL + strUrl),
                body: mParamType == ParamType.json
                    ? jsonEncode(requestParams)
                    : requestParams,
                headers: lHeaders)
            .timeout(const Duration(minutes: 3));
        break;
    }

    debugPrint("REQ. lHeaders : " + lHeaders.toString());
    debugPrint("REQ. PARAMS : " + requestParams.toString());
    debugPrint("REQ. URL : " + RequestBuilder.API_BASE_URL + strUrl);
    debugPrint("REQ. BODY : " + response.body.toString());

    return response.body;
  }

  static Future<String> fetchPostFullUrl(
      {required String strUrl,
      required HashMap<String, Object> requestParams,
      required ReqType mReqType,
      required ParamType mParamType}) async {
    HashMap<String, String> lHeaders = HashMap();

    final prefs = await SharedPreferences.getInstance();
    String? accesToken = prefs.getString(SharedPrefKey.KEY_ACCESS_TOKEN);
    if (accesToken != null && accesToken.isNotEmpty) {
      String accesTokenType = Constants.strTokenType;
      accesToken = accesTokenType + " " + accesToken;
      lHeaders[PARAMS.PARAM_AUTHORIZATION] = accesToken;
    }

    if (mParamType == ParamType.json) {
      lHeaders["Content-Type"] = "application/json";
      lHeaders["Accept"] = "application/json";
    }
    late http.Response? response;

    switch (mReqType) {
      case ReqType.get:
        response = await http
            .get(Uri.parse(strUrl), headers: lHeaders)
            .timeout(const Duration(minutes: 3));
        break;
      case ReqType.post:
        response = await http
            .post(Uri.parse(strUrl),
                body: mParamType == ParamType.json
                    ? jsonEncode(requestParams)
                    : requestParams,
                headers: lHeaders)
            .timeout(const Duration(minutes: 3));
        break;
      case ReqType.put:
        response = await http
            .put(Uri.parse(strUrl),
                body: mParamType == ParamType.json
                    ? jsonEncode(requestParams)
                    : requestParams,
                headers: lHeaders)
            .timeout(const Duration(minutes: 3));
        break;
      case ReqType.delete:
        response = await http
            .delete(Uri.parse(strUrl), headers: lHeaders)
            .timeout(const Duration(minutes: 3));
        break;
      case ReqType.patch:
        break;
    }

    if (response == null) return '';

    debugPrint("REQ. lHeaders : " + lHeaders.toString());
    debugPrint("REQ. PARAMS : " + requestParams.toString());
    debugPrint("REQ. URL : " + RequestBuilder.API_BASE_URL + strUrl);
    debugPrint("REQ. BODY : " + response.body.toString());
    return response.body;
  }
}

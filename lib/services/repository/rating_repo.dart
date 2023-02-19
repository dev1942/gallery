import 'dart:collection';
import 'dart:developer';
import 'package:logger/logger.dart';

import '../../global/Models/failure.dart';
import '../../global/Models/result.dart';
import '../../global/Models/success.dart';
import 'package:dartz/dartz.dart';
import 'package:otobucks/global/connectivity_status.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/global/url_collection.dart';
import 'package:otobucks/View/Rating/model/all_rating_provider_model.dart';
import 'package:otobucks/View/Rating/model/rating_component_model.dart';
import 'package:otobucks/services/rest_api/request_listener.dart';

class RatingRepo {
  Future<Either<Failure, Success>> giveRating(HashMap<String, Object> requestParams) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(DATA: "", MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION, STATUS: false));
    }
    try {
      String response = await ReqListener.fetchPost(
          strUrl: 'ratings/booking/byCustomer', requestParams: requestParams, mReqType: ReqType.post, mParamType: ParamType.json);
      Result? mResponse;
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        Success mSuccess = Success(responseStatus: mResponse!.responseStatus, responseData: {}, responseMessage: mResponse.responseMessage);

        return Right(mSuccess);
      }

      if (!Global.checkNull(mResponse!.responseMessage)) {
        mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
      }

      return Left(
          Failure(MESSAGE: mResponse.responseMessage, STATUS: false, DATA: mResponse.responseData != null ? mResponse.responseData as Object : ""));
    } catch (e) {
      return Left(Failure(STATUS: false, MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING, DATA: ""));
    }
  }

  //Give ratinng to promotion booking
  Future<Either<Failure, Success>> giveRatingToPromotionBooking(HashMap<String, Object> requestParams) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(DATA: "", MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION, STATUS: false));
    }
    try {
      String response = await ReqListener.fetchPost(
          strUrl: 'ratings/promotion/byCustomer', requestParams: requestParams, mReqType: ReqType.post, mParamType: ParamType.json);
      Result? mResponse;
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
      } else {
        return Left(Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        Success mSuccess = Success(responseStatus: mResponse!.responseStatus, responseData: {}, responseMessage: mResponse.responseMessage);

        return Right(mSuccess);
      }

      if (!Global.checkNull(mResponse!.responseMessage)) {
        mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
      }

      return Left(
          Failure(MESSAGE: mResponse.responseMessage, STATUS: false, DATA: mResponse.responseData != null ? mResponse.responseData as Object : ""));
    } catch (e) {
      return Left(Failure(STATUS: false, MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING, DATA: ""));
    }
  }

  Future<Either<Failure, Success>> getRatingsIndividual(HashMap<String, Object> requestParams, RatingType ratingType, String userId) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(DATA: "", MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION, STATUS: false));
    }
    try {
      log("-------------get rating individuals -------1-----");
      String response = await ReqListener.fetchPost(
          strUrl: RequestBuilder.RATINGS,
          // RatingType.given == ratingType
          //     ? RequestBuilder.API_GIVEN_BY_CUSTOMER_RATING + userId
          //     : RequestBuilder.API_GIVEN_BY_PROVIDER_RATING + userId,
          requestParams: requestParams,
          mReqType: ReqType.get,
          mParamType: ParamType.simple);
      log("------------------------------------sdfasfds----------------2---------");

      Result? mResponse;
      if (response.isNotEmpty) {
        log("------------------------------------sdfasfds----------------3---------");
//log(response);
        mResponse = Global.getData(response);
        log("--------------mrespone .status code");
        log(mResponse!.responseStatus.toString());
      } else {
        return Left(Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse.responseStatus == true) {
        log("------------------------------------sdfasfds----------------4---------");
        List<RatingComponentModel> reviews = [];

        List data = mResponse.responseData as List;
        int i = 0;
        for (var dataItem in data) {
          i++;
          log("------ibrhim 5");
          log(ratingType.toString());

          // ReviewModel mReviewModel = ReviewModel.fromMap(dataItem);

          // log(mReviewModel.customerToProvider!.review);
          switch (ratingType) {
            case RatingType.given:
              // if (mReviewModel.customerToProvider != null) {
              //   reviews.add(RatingComponentModel(
              //       serviceType: '',
              //       image: mReviewModel.provider!.image,
              //       name: mReviewModel.provider!.firstName.toString() +
              //           ' ' +
              //           mReviewModel.provider!.lastName.toString(),
              //       customerId: mReviewModel.customer!.id,
              //       providerId: mReviewModel.provider!.id,
              //       rating: mReviewModel.customerToProvider!.rating.toDouble(),
              //       review: mReviewModel.customerToProvider!.review.toString(),
              //       reviewId: mReviewModel.id));
              // }
              if (dataItem['customer_to_provider'] != null) {
                log("------------------1----------------$i");

                // log(dataItem['provider']['image']);
                // log(dataItem['customer_to_provider']['review']);
                // log( dataItem['provider']['firstName'].toString());
                // log(dataItem['provider']['lastName'].toString());
                // log(dataItem['provider']['_id']);
                // log(dataItem['customer_to_provider']['stars'].toDouble());
                // log(dataItem['customer_to_provider']['review'].toString());
                // log( dataItem['provider'].runtimeType);
                // log( dataItem['provider']);
                log("------------------4----------------");

                reviews.add(RatingComponentModel(
                    serviceType: '',
                    image: dataItem['provider'] != null
                        ? dataItem['provider']['image']
                        : "https://s3.amazonaws.com/cdn.carbucks.com/49bee8c3-b2a3-4063-bb80-d094550c4cc3.png", //mReviewModel.provider!.image,
                    name: dataItem['provider'] != null ? dataItem['provider']['firstName'].toString() : "kausar",
                    // +
                    // ' ' +
                    // dataItem['provider']['lastName'].toString(),
                    customerId: dataItem['customer'], //mReviewModel.customer!.id,
                    providerId: dataItem['provider'] != null ? dataItem['provider']['_id'] : "62d0072d2e64f55c5cffdd4a", //mReviewModel.provider!.id,
                    rating: dataItem['customer_to_provider']['stars'].toDouble(), //mReviewModel.customerToProvider!.rating.toDouble(),
                    review: dataItem['customer_to_provider']['review'].toString(),
                    reviewId: dataItem['_id']));
              }
              break;
            case RatingType.recieved:
              // if (mReviewModel.providerToCustomer != null) {
              //   reviews.add(RatingComponentModel(
              //       serviceType: '',
              //       image: mReviewModel.provider!.image,
              //       name: mReviewModel.provider!.firstName.toString() +
              //           ' ' +
              //           mReviewModel.provider!.lastName.toString(),
              //       customerId: mReviewModel.customer!.id,
              //       providerId: mReviewModel.provider!.id,
              //       rating: mReviewModel.providerToCustomer!.rating.toDouble(),
              //       review: mReviewModel.providerToCustomer!.review.toString(),
              //       reviewId: mReviewModel.id));
              // }
              if (dataItem['provider_to_customer'] != null) {
                reviews.add(RatingComponentModel(
                    serviceType: '',
                    image: dataItem['provider'] != null
                        ? dataItem['provider']['image']
                        : "https://s3.amazonaws.com/cdn.carbucks.com/49bee8c3-b2a3-4063-bb80-d094550c4cc3.png", //mReviewModel.provider!.image,
                    name: dataItem['provider'] != null ? dataItem['provider']['firstName'].toString() : "kausar",
                    // ' ' +
                    // dataItem['provider']['lastName'].toString(),
                    customerId: dataItem['customer'], //mReviewModel.customer!.id,
                    providerId: dataItem['provider'] != null
                        ? dataItem['provider']['_id']
                        : "62d0072d2e64f55c5cffdd4a", //dataItem['provider']['_id'],//mReviewModel.provider!.id,
                    rating: dataItem['provider_to_customer']['stars'].toDouble(), //mReviewModel.customerToProvider!.rating.toDouble(),
                    review: dataItem['provider_to_customer']['review'].toString(),
                    reviewId: dataItem['_id']));
              }

              break;
          }
        }

        Success mSuccess = Success(responseStatus: mResponse.responseStatus, responseData: reviews, responseMessage: mResponse.responseMessage);

        return Right(mSuccess);
      }

      if (!Global.checkNull(mResponse.responseMessage)) {
        mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
      }

      return Left(
          Failure(MESSAGE: mResponse.responseMessage, STATUS: false, DATA: mResponse.responseData != null ? mResponse.responseData as Object : ""));
    } catch (e) {
      log(e.toString());
      return Left(Failure(STATUS: false, MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING, DATA: ""));
    }
  }

//-------------------------------------Provider Rating---------------------------------------------------------------
  Future<Either<Failure, Success>> getAllRatingsProvider(HashMap<String, Object> requestParams, String providerId) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(DATA: "", MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION, STATUS: false));
    }
    try {
      String response = await ReqListener.fetchPost(
          strUrl: 'ratings/providerAllRattings/$providerId', requestParams: requestParams, mReqType: ReqType.get, mParamType: ParamType.simple);
      Result? mResponse;
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
        inspect(mResponse);
      } else {
        return Left(Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        List<RatingComponentModel> reviews = [];
        List data = mResponse?.responseData as List;
        if (data.isNotEmpty) {
          for (var dataItem in data) {
            AllProviderRatingModel mReviewModel = AllProviderRatingModel.fromMap(dataItem);
            if (mReviewModel.customerToProvider != null && mReviewModel.customer != null) {
              log("response is not empty");
              reviews.add(RatingComponentModel(
                  serviceType: '',
                  image: mReviewModel.customer!.image,
                  name: mReviewModel.customer!.firstName.toString() + ' ' + mReviewModel.customer!.lastName.toString(),
                  customerId: '',
                  providerId: mReviewModel.provider,
                  rating: mReviewModel.customerToProvider?.rating != null ? mReviewModel.customerToProvider!.rating.toDouble() : 0.0,
                  review: mReviewModel.customerToProvider!.review.toString(),
                  reviewId: mReviewModel.id));
            }
          }

          Success mSuccess = Success(responseStatus: mResponse!.responseStatus, responseData: reviews, responseMessage: mResponse.responseMessage);

          return Right(mSuccess);
        } else {
          if (!Global.checkNull(mResponse!.responseMessage)) {
            mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
          }
          return Left(Failure(MESSAGE: mResponse.responseMessage, STATUS: false, DATA: ""));
        }
      }

      if (!Global.checkNull(mResponse!.responseMessage)) {
        mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
      }

      return Left(
          Failure(MESSAGE: mResponse.responseMessage, STATUS: false, DATA: mResponse.responseData != null ? mResponse.responseData as Object : ""));
    } catch (e) {
      log("in exception" + e.toString());
      return Left(Failure(STATUS: false, MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING, DATA: ""));
    }
  }
}

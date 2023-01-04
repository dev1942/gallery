import 'dart:collection';
import 'dart:developer';
import '../../global/Models/failure.dart';
import '../../global/Models/result.dart';
import '../../global/Models/success.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:otobucks/global/connectivity_status.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/global/url_collection.dart';
import 'package:otobucks/View/Rating/model/all_rating_provider_model.dart';
import 'package:otobucks/View/Rating/model/rating_component_model.dart';
import 'package:otobucks/View/Rating/Model/review_model.dart';
import 'package:otobucks/services/rest_api/request_listener.dart';

class RatingRepo {
  Future<Either<Failure, Success>> giveRating(
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
          strUrl: 'ratings/booking/byCustomer',
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
      return Left(Failure(
          STATUS: false,
          MESSAGE: AppAlert.ALERT_SERVER_NOT_RESPONDING,
          DATA: ""));
    }
  }

  Future<Either<Failure, Success>> getRatingsIndividual(
      HashMap<String, Object> requestParams,
      RatingType ratingType,
      String userId) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(
          DATA: "",
          MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION,
          STATUS: false));
    }
    try {
      print("-------------get rating individuals ------------");
      String response = await ReqListener.fetchPost(
          strUrl:RequestBuilder.RATINGS,
          // RatingType.given == ratingType
          //     ? RequestBuilder.API_GIVEN_BY_CUSTOMER_RATING + userId
          //     : RequestBuilder.API_GIVEN_BY_PROVIDER_RATING + userId,
          requestParams: requestParams,
          mReqType: ReqType.get,
          mParamType: ParamType.simple);


      Result? mResponse;
      if (response.isNotEmpty) {
        mResponse = Global.getData(response);
        print("--------------mrespone .status code");
        print(mResponse?.responseStatus );

      } else {
        return Left(
            Failure(DATA: "", MESSAGE: "No data found.", STATUS: false));
      }

      if (mResponse?.responseStatus == true) {
        List<RatingComponentModel> reviews = [];

        List data = mResponse?.responseData as List;

        for (var dataItem in data) {



          ReviewModel mReviewModel = ReviewModel.fromMap(dataItem);

          print(mReviewModel.customerToProvider!.review);
          switch (ratingType) {
            case RatingType.given:
            if (mReviewModel.customerToProvider != null) {
              reviews.add(RatingComponentModel(
                  serviceType: '',
                  image: mReviewModel.provider!.image,
                  name: mReviewModel.provider!.firstName.toString() +
                      ' ' +
                      mReviewModel.provider!.lastName.toString(),
                  customerId: mReviewModel.customer!.id,
                  providerId: mReviewModel.provider!.id,
                  rating: mReviewModel.customerToProvider!.rating.toDouble(),
                  review: mReviewModel.customerToProvider!.review.toString(),
                  reviewId: mReviewModel.id));
            }
              if (dataItem['customer_to_provider']!= null) {
                reviews.add(RatingComponentModel(
                    serviceType: '',
                    image: dataItem['provider']['image'],//mReviewModel.provider!.image,
                    name: dataItem['provider']['firstName'].toString() +
                        ' ' +
                        dataItem['provider']['lastName'].toString(),
                    customerId:  dataItem['customer'],//mReviewModel.customer!.id,
                    providerId:  dataItem['provider']['_id'],//mReviewModel.provider!.id,
                    rating:dataItem['customer_to_provider']['stars'].toDouble(), //mReviewModel.customerToProvider!.rating.toDouble(),
                    review: dataItem['customer_to_provider']['review'].toString(),
                    reviewId: dataItem['_id']));
              }
              break;
            case RatingType.recieved:
            if (mReviewModel.providerToCustomer != null) {
              reviews.add(RatingComponentModel(
                  serviceType: '',
                  image: mReviewModel.provider!.image,
                  name: mReviewModel.provider!.firstName.toString() +
                      ' ' +
                      mReviewModel.provider!.lastName.toString(),
                  customerId: mReviewModel.customer!.id,
                  providerId: mReviewModel.provider!.id,
                  rating: mReviewModel.providerToCustomer!.rating.toDouble(),
                  review: mReviewModel.providerToCustomer!.review.toString(),
                  reviewId: mReviewModel.id));
            }
              if (dataItem['provider_to_customer']!= null) {
                reviews.add(RatingComponentModel(
                    serviceType: '',
                    image: dataItem['provider']['image'],//mReviewModel.provider!.image,
                    name: dataItem['provider']['firstName'].toString() +
                        ' ' +
                        dataItem['provider']['lastName'].toString(),
                    customerId:  dataItem['customer'],//mReviewModel.customer!.id,
                    providerId:  dataItem['provider']['_id'],//mReviewModel.provider!.id,
                    rating:dataItem['provider_to_customer']['stars'].toDouble(), //mReviewModel.customerToProvider!.rating.toDouble(),
                    review: dataItem['provider_to_customer']['review'].toString(),
                    reviewId: dataItem['_id']));
              }

              break;
          }
        }

        Success mSuccess = Success(
            responseStatus: mResponse!.responseStatus,
            responseData: reviews,
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

  Future<Either<Failure, Success>> getAllRatingsProvider(
      HashMap<String, Object> requestParams, String providerId) async {
    bool connectionStatus = await ConnectivityStatus.isConnected();
    if (!connectionStatus) {
      return Left(Failure(
          DATA: "",
          MESSAGE: AppAlert.ALERT_NO_INTERNET_CONNECTION,
          STATUS: false));
    }
    try {
      String response = await ReqListener.fetchPost(
          strUrl: 'ratings/providerAllRattings/$providerId',
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
        List<RatingComponentModel> reviews = [];
        List data = mResponse?.responseData as List;
        if (data.isNotEmpty) {
          for (var dataItem in data) {
            AllProviderRatingModel mReviewModel =
            AllProviderRatingModel.fromMap(dataItem);
            if (mReviewModel.customerToProvider != null &&
                mReviewModel.customer != null) {
              reviews.add(RatingComponentModel(
                  serviceType: '',
                  image: mReviewModel.customer!.image,
                  name: mReviewModel.customer!.firstName.toString() +
                      ' ' +
                      mReviewModel.customer!.lastName.toString(),
                  customerId: '',
                  providerId: mReviewModel.provider,
                  rating: mReviewModel.customerToProvider!.rating.toDouble(),
                  review: mReviewModel.customerToProvider!.review.toString(),
                  reviewId: mReviewModel.id));
            }
          }

          Success mSuccess = Success(
              responseStatus: mResponse!.responseStatus,
              responseData: reviews,
              responseMessage: mResponse.responseMessage);

          return Right(mSuccess);
        } else {
          if (!Global.checkNull(mResponse!.responseMessage)) {
            mResponse.responseMessage = AppAlert.ALERT_SERVER_NOT_RESPONDING;
          }
          return Left(Failure(
              MESSAGE: mResponse.responseMessage, STATUS: false, DATA: ""));
        }
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

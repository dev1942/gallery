import 'dart:developer';
import 'package:otobucks/View/Services_All/Models/service_provider_model.dart';
import 'package:otobucks/View/Services_All/Models/store_model.dart';

import '../../../global/global.dart';
import '../../Dashboard/Models/category_model.dart';

class ServiceModel {
  String id;
  String title;
  String description;
  String price;
  String? beforePrice;
  String? discount;
  String currency;
  int rating;
  int totalRatings;
  List<StoreModel> alStory = [];
  List<String> alImages = [];
  List<String> alVideos = [];
  List<String> alFeatures = [];
  ServiceProviderModel mServiceProviderModel;
  late CategoryModel mCategoryModel;
  late CategoryModel mSubCategoryModel;

  ServiceModel({
    required this.id,
    this.beforePrice,
    this.discount,
    required this.title,
    required this.description,
    required this.price,
    required this.currency,
    required this.rating,
    required this.totalRatings,
    required this.alStory,
    required this.alImages,
    required this.alVideos,
    required this.alFeatures,
    required this.mServiceProviderModel,
    required this.mCategoryModel,
    required this.mSubCategoryModel,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    List<StoreModel> alStory = [];
    List<String> alImages = [];
    List<String> alVideos = [];
    List<String> alFeatures = [];
    int rating = 0;
    int totalRatings = 0;
    ServiceProviderModel? mServiceProviderModel;

    late CategoryModel mCategoryModel;
    late CategoryModel mSubCategoryModel;
    try {
      if (json['avgRating'] != null) {
        if (json['avgRating'][0]['ratingsAverage'] != null) {
          rating = json['avgRating'][0]['ratingsAverage'] ?? 0;
        }
      }
    } catch (e) {
      log(e.toString());
    }
    try {
      if (json['avgRating'] != null) {
        if (json['avgRating'][0]['totalRatings'] != null) {
          totalRatings = json['avgRating'][0]['totalRatings'] ?? 0;
        }
      }
    } catch (e) {
      log(e.toString());
    }
    try {
      var stores = json['stores'];
      for (var storesItem in stores) {
        alStory.add(StoreModel.fromJson(storesItem));
      }
    } catch (e) {
      log(e.toString());
    }

    try {
      var image = json['image'];
      for (var imageItem in image) {
        if (Global.isURL(imageItem.toString())) {
          alImages.add(imageItem.toString());
        }
      }
    } catch (e) {
      log(e.toString());
    }

    try {
      var video = json['video'];
      for (var videoItem in video) {
        if (Global.isURL(videoItem.toString())) {
          alVideos.add(videoItem.toString());
        }
      }
    } catch (e) {
      log(e.toString());
    }
    try {
      var features = json['features'];
      for (var featuresItem in features) {
        if (Global.checkNull(featuresItem.toString())) {
          alFeatures.add(featuresItem.toString());
        }
      }
    } catch (e) {
      log(e.toString());
    }

    try {
      var provider = json['provider'];
      if (provider != null) {
        mServiceProviderModel = ServiceProviderModel.fromJson(provider);
      }else {
        
      }
    } catch (e) {
      log("logging" + e.toString());
    }

    try {
      var category = json['category'];
      mCategoryModel = CategoryModel.fromJson(category);
    } catch (e) {
      log(e.toString());
    }
    try {
      var subcategory = json['subcategory'];
      mSubCategoryModel = CategoryModel.fromJson(subcategory);
    } catch (e) {
      log(e.toString());
    }

    return ServiceModel(
        id: json['_id'].toString(),
        title: json['title'].toString(),
        description: json['description'].toString(),
        price: json['price'].toString(),
        currency: json['currency'].toString(),
        alStory: alStory,
        alImages: alImages,
        rating: rating,
        totalRatings: totalRatings,
        alVideos: alVideos,
        alFeatures: alFeatures,
        mServiceProviderModel: mServiceProviderModel!,
        mCategoryModel: mCategoryModel,
        mSubCategoryModel: mSubCategoryModel);
  }

  getProviderImage() {
    // ignore: unnecessary_null_comparison
    if (mServiceProviderModel != null) {
      return mServiceProviderModel.image;
    } else {
      return "";
    }
  }
}

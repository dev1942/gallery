import 'dart:developer';

import 'package:otobucks/model/service/service_provider_model.dart';
import 'package:otobucks/model/service/store_model.dart';

import '../../global/global.dart';
import 'category_model.dart';

class JobModel {
  String id;
  String title;
  String description;
  String price;
  String currency;
  List<StoreModel> alStory = [];
  List<String> alImages = [];
  List<String> alVideos = [];
  List<String> alFeatures = [];
  ServiceProviderModel mServiceProviderModel;
  late CategoryModel mCategoryModel;
  late CategoryModel mSubCategoryModel;

  JobModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.currency,
    required this.alStory,
    required this.alImages,
    required this.alVideos,
    required this.alFeatures,
    required this.mServiceProviderModel,
    required this.mCategoryModel,
    required this.mSubCategoryModel,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    List<StoreModel> alStory = [];
    List<String> alImages = [];
    List<String> alVideos = [];
    List<String> alFeatures = [];
    ServiceProviderModel? mServiceProviderModel;

    late CategoryModel mCategoryModel;
    late CategoryModel mSubCategoryModel;
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
      mServiceProviderModel = ServiceProviderModel.fromJson(provider);
    } catch (e) {
      log(e.toString());
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

    return JobModel(
        id: json['_id'].toString(),
        title: json['title'].toString(),
        description: json['description'].toString(),
        price: json['price'].toString(),
        currency: json['currency'].toString(),
        alStory: alStory,
        alImages: alImages,
        alVideos: alVideos,
        alFeatures: alFeatures,
        mServiceProviderModel: mServiceProviderModel!,
        mCategoryModel: mCategoryModel,
        mSubCategoryModel: mSubCategoryModel);
  }
}

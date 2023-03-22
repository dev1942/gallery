import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/View/Estimation/Views/create_estimation_screen.dart';
import 'package:otobucks/View/Services_All/Models/service_model.dart';
import 'package:otobucks/View/Services_All/Views/service_provider_profile_screen.dart';

class ServicesDetailsScreenController extends GetxController {
  late ServiceModel mServiceModel;

  gotoProfile(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ServiceProviderProfileScreen(
                rating: mServiceModel.rating.toDouble(),
                totalRatings: mServiceModel.totalRatings.toDouble(),
                mServiceProviderModel: mServiceModel.mServiceProviderModel,
                title: mServiceModel.title)));
  }

  gotoCreateEstimation(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => CreateEstimationScreen(
                  mServiceModel: mServiceModel,
                  screenType: 'serviceDetails',
                )));
  }
}

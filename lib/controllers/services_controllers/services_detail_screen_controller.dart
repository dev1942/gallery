import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/page/services/profile/service_provider_profile_screen.dart';

import '../../model/service/service_model.dart';
import '../../page/services/estimation/create_estimation_screen.dart';

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
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreateEstimationScreen(
                  mServiceModel: mServiceModel,
                  screenType: 'serviceDetails',
                )));
  }
}

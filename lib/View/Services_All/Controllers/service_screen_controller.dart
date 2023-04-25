import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:otobucks/View/Services_All/Views/service_detail_screen.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/View/Services_All/Models/service_model.dart';
import 'package:otobucks/services/repository/services_repo.dart';
import 'package:geocoding/geocoding.dart' as i;

class ServiceScreenController extends GetxController {
  ShowData mShowData = ShowData.showLoading;
  bool connectionStatus = false;
  int intCurrentPage = 0;
  List<ServiceModel> alServices = [];
  List<ServiceModel> alServicesfiltered = [];
  TextEditingController controllerSearch = TextEditingController();
  int indexM = 0;
  getServiceProvider(String catId, String subCatId, BuildContext context) async {
    log("==================Getting service providers===============+");
    mShowData = ShowData.showLoading;
    // isShowLoader = true;
    update();

    HashMap<String, Object> requestParams = HashMap();
    var latlong = await getLocationAdress();
    log("Location found");

    inspect(latlong);
    var categories;
    if (latlong != null) {
      categories = await ServicesRepo()
          .getServices(requestParams, catId: catId, subCatId: subCatId, lat: latlong.latitude.toString(), long: latlong.longitude.toString());
    } else {
      categories = await ServicesRepo().getServices(requestParams, catId: catId, subCatId: subCatId, lat: null, long: null);
    }

    categories.fold((failure) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);

      mShowData = ShowData.showNoDataFound;
      update();
    }, (mResult) {
      alServices = mResult.responseData as List<ServiceModel>;
      alServicesfiltered = alServices;
      log("++++++++++++++++");
      inspect(mResult.responseData as List<ServiceModel>);
      // inspect(alServices);
      if (alServices.isNotEmpty) {
        log("++++++++Alservice found++++++++");
        inspect(alServices);
        mShowData = ShowData.showData;
      } else {
        mShowData = ShowData.showNoDataFound;
      }
    });
    update();
  }

  Future<LatLng?> getLocationAdress() async {
    Location location = Location();
    log('method callled');

    update();
    await location.requestService();
    await location.requestPermission();
    PermissionStatus _permissionGranted = await location.hasPermission();

    if (_permissionGranted == PermissionStatus.granted || _permissionGranted == PermissionStatus.grantedLimited) {
      var currentLocation = await location.getLocation();
      log(currentLocation.latitude.toString());
      LatLng _mLatLng = LatLng(currentLocation.latitude!, currentLocation.longitude!);

      return _mLatLng;
      // mLatLng = _mLatLng;
    } else {
      update();
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: 'Enable Location From setting!', toastType: TOAST_TYPE.toastError);
      return null;
    }
    update();
  }

  runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      log("key is emty");
      // if the search field is empty or only contains white-space, we'll display all users
      alServicesfiltered = alServices;
      mShowData = ShowData.showData;
      update();
    } else {
      log("key is not emty");
      log(alServices.length.toString());
      alServicesfiltered =
          alServices.where((user) => user.mServiceProviderModel.firstName.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
      if (alServicesfiltered.isEmpty) {
        mShowData = ShowData.showNoDataFound;
      } else {
        mShowData = ShowData.showData;
      }
      // we use the toLowerCase() method to make it case-insensitive
    }
    // Refresh the UI
    update();
  }

  gotoServiceDetail(ServiceModel mServiceModel, BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceDetailScreen(mServiceModel: mServiceModel)));
  }
}

import 'dart:collection';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as i;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:light_compressor/light_compressor.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:otobucks/View/ThankYou/Views/thankyou_fragment.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/View/Services_All/Models/service_model.dart';
import 'package:otobucks/View/Services_All/Views/service_provider_profile_screen.dart';
import 'package:otobucks/services/repository/estimates_repo.dart';

import '../../../global/Models/time_model.dart';

class CreateEstimationController extends GetxController {
  bool connectionStatus = false;
  bool isShowLoader = false;

  late ServiceModel mServiceModel;
  TextEditingController controllerNote = TextEditingController();
  TextEditingController addressNote = TextEditingController(text: "");
  // ignore: avoid_init_to_null
  late TimeModel? mTimeModel = null;
  String selectedDate = "";
  String pickedImage = "";
  String pickedVideo = "";
  String voiceNoteFile = "";
  LatLng? mLatLng;
  Location location = Location();
  LightCompressor lightCompressor = LightCompressor();
  bool isVideoCompressed = false;

  getLocationAdress() async {
    Location location = Location();
    log('method callled');
    selectedDate = "";
    pickedImage = "";
    pickedVideo = "";
    addressNote.text = "";
    voiceNoteFile = "";
    mTimeModel = null;
    PermissionStatus _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.granted || _permissionGranted == PermissionStatus.grantedLimited) {
      var currentLocation = await location.getLocation();
      log(currentLocation.latitude.toString());
      LatLng _mLatLng = LatLng(currentLocation.latitude!, currentLocation.longitude!);
      List<i.Placemark> placemarks = await i.placemarkFromCoordinates(_mLatLng.latitude, _mLatLng.longitude);
      addressNote.text = '${placemarks[0].street} ${placemarks[0].subLocality} ${placemarks[0].locality} ${placemarks[0].country}';

      log("addresssssis${addressNote.text}");
      mLatLng = _mLatLng;
    } else {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: 'Enable Location From setting!', toastType: TOAST_TYPE.toastError);
      mLatLng = Global.mLatLng;
    }
    update();
  }

  Future getImage(ImageSource imageSource) async {
    // ignore: invalid_use_of_visible_for_testing_member
    var image = await ImagePicker.platform.pickImage(source: imageSource, imageQuality: 70);

    pickedImage = image!.path;
    update();
  }

  Future pickVideo(ImageSource imageSource) async {
    // ignore: invalid_use_of_visible_for_testing_member
    var image = await ImagePicker.platform.pickVideo(source: imageSource, maxDuration: const Duration(seconds: 30));

    if (image != null) {
      isVideoCompressed = true;
      update();
      String _desFile = await Global.destinationFile("mp4");
      final dynamic response = await lightCompressor.compressVideo(
        // destinationPath: _desFile,
        ios: IOSConfig(saveInGallery: false),
          path: image.path,  video: Video(videoName: _desFile), videoQuality: VideoQuality.very_low, isMinBitrateCheckEnabled: false,  android: AndroidConfig(isSharedStorage: true,
          saveAt: SaveAt.Movies),);

      if (response is OnSuccess) {
        pickedVideo = response.destinationPath;
        log(pickedVideo);
      } else if (response is OnFailure) {
      } else if (response is OnCancelled) {
        log(response.isCancelled.toString());
      }
    }
    isVideoCompressed = false;

    update();
  }

  onSelectDate(String _selectedDate) {
    selectedDate = _selectedDate;
    update();
  }

  onSelectTime(TimeModel mtimeModel_) {
    mTimeModel = mtimeModel_;
    update();
  }

  onDeleteImage() {
    pickedImage = "";
    update();
  }

  onDeleteVideo() {
    pickedVideo = "";
    update();
  }

  onDeleteVoice() {
    voiceNoteFile = "";
    update();
  }

  onSelectVoiceNote(filePath) {
    voiceNoteFile = filePath;
    log(voiceNoteFile);
    update();
  }

  isValid() {
    if (!Global.checkNull(addressNote.text)) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: 'Please Enter Address', toastType: TOAST_TYPE.toastError);
      return false;
    }
    if (!Global.checkNull(selectedDate)) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: AppAlert.ALERT_SELECT_DATE, toastType: TOAST_TYPE.toastError);
      return false;
    } else if (mTimeModel == null) {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: AppAlert.ALERT_SELECT_TIME, toastType: TOAST_TYPE.toastError);
      return false;
    }

    return true;
  }

  //
  // promotionPayment(BuildContext context) {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => const CheckoutScreen(
  //                 estimateId: '',
  //                 sourceId: '',
  //                 paymentStatus: 'completePayment',
  //               )));
  // }
//----------------------------Create Estimation--------------------
  createEstimation(BuildContext context, String? carId) async {
    log("create estimation--------------------------------ibrahim--------");

    log(pickedImage.toString());
    if (Global.checkNull(pickedVideo)) {
      double fileSize = await Global.getFileSize(pickedVideo);
      if (fileSize > 10) {
        Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: AppAlert.ALERT_FILE_SIZE, toastType: TOAST_TYPE.toastError);
        return "";
      }
    }
    isShowLoader = true;
    update();
    String strNote = controllerNote.text.toString();
    HashMap<String, String> requestParams = HashMap();
    HashMap<String, String> requestParamsImage = HashMap();
    // requestParamsImage["sourceID"]="62d461692e64f55c5c0802f3";
    requestParams["sourceID"] = mServiceModel.id;
    requestParams[PARAMS.PARAM_DATE] = selectedDate;
    // final gasGiants = {PARAMS.PARAM_SOURCE:  mServiceModel.id, PARAMS.PARAM_ADDRESS: addressNote.text};

    requestParams[PARAMS.PARAM_TIME] = mTimeModel != null ? mTimeModel!.time_24hr.toString() : "";
    requestParams[PARAMS.PARAM_CUTOMERNOTE] = strNote;
    requestParams[PARAMS.PARAM_ADDRESS] = addressNote.text;
    requestParams["car"] = carId ?? "63a2915f0fe25834cf690bbf";
    if (mLatLng != null) {
      requestParams[PARAMS.PARAM_LATITUDE] = mLatLng!.latitude.toStringAsFixed(4);
      requestParams[PARAMS.PARAM_LONGITUDE] = mLatLng!.longitude.toStringAsFixed(4);
    } else {
      requestParams[PARAMS.PARAM_LATITUDE] = Global.mLatLng.latitude.toStringAsFixed(4);
      requestParams[PARAMS.PARAM_LONGITUDE] = Global.mLatLng.longitude.toStringAsFixed(4);
    }

    if (Global.checkNull(pickedImage)) {
      requestParamsImage[PARAMS.PARAM_IMAGE] = pickedImage;
    }

    if (Global.checkNull(pickedVideo)) {
      requestParamsImage[PARAMS.PARAM_VIDEO] = pickedVideo;
    }
    if (Global.checkNull(voiceNoteFile)) {
      requestParamsImage[PARAMS.PARAM_VOICE_NOTE] = voiceNoteFile;
    }
    // requestParamsImage.addEntries(gasGiants.entries);
    //........Rrepo of create estimation...................

    Logger().i(requestParamsImage);
    var categories = await EstimatesRepo().createEstimates(requestParams, requestParamsImage, ReqType.post);

    categories.fold((failure) {
      //.............Failure case............................
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);

      isShowLoader = false;
      update();
    }, (mResult) {
      isShowLoader = false;
      //................ goto Thank you......................
      Get.offAll(() => const ThankYouFragment());
    });
  }

//.............goto profile
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

  updateLatLang(LatLng mLatLng_) async {
    mLatLng = mLatLng_;
    getLocationAdress();
  }
}

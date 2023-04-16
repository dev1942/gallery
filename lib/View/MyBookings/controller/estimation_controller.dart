import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as i;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:light_compressor/light_compressor.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:http/http.dart' as http;
import 'package:otobucks/View/Services_All/Models/service_model.dart';
import 'package:otobucks/View/Services_All/Views/service_provider_profile_screen.dart';
import 'package:otobucks/global/url_collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../global/Models/time_model.dart';
import '../../../global/app_style.dart';
import '../../../global/app_views.dart';
import '../../Services_All/Controllers/service_screen_controller.dart';

class CreateEstimationController extends GetxController {
  bool connectionStatus = false;
  bool isShowLoader = false;

  late ServiceModel mServiceModel;
  TextEditingController controllerNote = TextEditingController();
  TextEditingController addressNote = TextEditingController(text: "");

  updateServiceModel(ServiceModel newserivemodel) {
    mServiceModel = newserivemodel;
    update();
  }

  // ignore: avoid_init_to_null
  late TimeModel? mTimeModel = null;
  bool isMultiProvider = false;
  String selectedDate = "";
  String pickedImage = "";
  String pickedVideo = "";
  String voiceNoteFile = "";
  LatLng? mLatLng;
  Location location = Location();
  LightCompressor lightCompressor = LightCompressor();
  bool isVideoCompressed = false;

  Future<void> showLoader() async {
    isShowLoader = true;
    update();
  }

  getLocationAdress() async {
    Location location = Location();
    log('method callled');
    isShowLoader = true;
    update();
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
      isShowLoader = false;
      update();
      mLatLng = _mLatLng;
    } else {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: 'Enable Location From setting!', toastType: TOAST_TYPE.toastError);
      mLatLng = Global.mLatLng;
    }
    update();
  }

  final ImagePicker _picker = ImagePicker();

  Future getImage(ImageSource imageSource) async {
    isShowLoader = true;
    update();

    // ignore: invalid_use_of_visible_for_testing_member
    var image = await _picker.pickImage(source: imageSource, imageQuality: 70);
    isShowLoader = false;
    update();
    pickedImage = image!.path;

    update();
  }

  Future pickVideo(ImageSource imageSource) async {
    // ignore: invalid_use_of_visible_for_testing_member
    var image = await _picker.pickVideo(source: imageSource, maxDuration: const Duration(seconds: 30));

    if (image != null) {
      isVideoCompressed = true;
      update();
      String _desFile = await Global.destinationFile("mp4");
      final dynamic response = await lightCompressor.compressVideo(
        destinationPath: _desFile,
        // ios: IOSConfig(saveInGallery: false),
        path: image.path,
        videoQuality: VideoQuality.very_low,
        isMinBitrateCheckEnabled: false,
      );

      if (response is OnSuccess) {
        pickedVideo = response.destinationPath;
        log(pickedVideo);
      } else if (response is OnFailure) {
      } else if (response is OnCancelled) {
        log(response.isCancelled.toString());
      }
    }
    isVideoCompressed = false;
    isShowLoader = false;

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
  Future<bool> createEstimationSingle(BuildContext context, String? carId) async {
    log("create estimation--------------------------------ibrahim--------");
    log(pickedImage.toString());
    if (Global.checkNull(pickedVideo)) {
      double fileSize = await Global.getFileSize(pickedVideo);
      if (fileSize > 10) {
        Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: AppAlert.ALERT_FILE_SIZE, toastType: TOAST_TYPE.toastError);
        return false;
      }
    }
    isShowLoader = true;
    update();
    String strNote = controllerNote.text.toString();
    HashMap<String, String> requestParams = HashMap();
    HashMap<String, String> requestParamsImage = HashMap();
    // requestParamsImage["sourceID"]="62d461692e64f55c5c0802f3";
    requestParams["sourceID"] = [mServiceModel.id].toString();
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
    // Get.find();
    List<String> singleProviderSourceList = [mServiceModel.id];
    List<String> multiProviderSourceList = [mServiceModel.id];
    // requestParamsImage.addEntries(gasGiants.entries);
    //........Rrepo of create estimation...................
    var res = await mCreateEstimation(singleProviderSourceList, addressNote.text, mTimeModel != null ? mTimeModel!.time_24hr.toString() : "",
        selectedDate, carId, strNote, pickedVideo, pickedImage, voiceNoteFile);

    return res;
  }

  Future<bool> createEstimationMulti(BuildContext context, String? carId) async {
    log("create estimation multi--------------------------------ibrahim--------");
    log(pickedImage.toString());
    if (Global.checkNull(pickedVideo)) {
      double fileSize = await Global.getFileSize(pickedVideo);
      if (fileSize > 10) {
        Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: AppAlert.ALERT_FILE_SIZE, toastType: TOAST_TYPE.toastError);
        return false;
      }
    }
    isShowLoader = true;
    update();
    String strNote = controllerNote.text.toString();
    HashMap<String, String> requestParams = HashMap();
    HashMap<String, String> requestParamsImage = HashMap();
    requestParams[PARAMS.PARAM_DATE] = selectedDate;
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

    List<String> multiProviderSourceList = List.filled(5, "");
    if (Get.put(ServiceScreenController()).alServicesfiltered.isNotEmpty) {
      multiProviderSourceList = [];

      multiProviderSourceList.add(
        Get.put(ServiceScreenController())
            .alServicesfiltered
            .firstWhere((element) => element.mSubCategoryModel.title == mServiceModel.mSubCategoryModel.title)
            .id,
      );
      if (multiProviderSourceList.length > 1) {
        multiProviderSourceList.removeWhere((element) => element == mServiceModel.id);
      }
    }
    log("ids" + multiProviderSourceList.toString());

    // requestParamsImage.addEntries(gasGiants.entries);
    //........Rrepo of create estimation...................
    var res = await mCreateEstimation(multiProviderSourceList, addressNote.text, mTimeModel != null ? mTimeModel!.time_24hr.toString() : "",
        selectedDate, carId, strNote, pickedVideo, pickedImage, voiceNoteFile);

    return res;
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

  jsonToFormData(http.MultipartRequest request, Map<String, dynamic> data) {
    for (var key in data.keys) {
      request.fields[key] = data[key].toString();
    }
    return request;
  }

  //................add shop and update shop of seller....................................
  Future<bool> mCreateEstimation(
    List<String> sourceIDs,
    String? address,
    String? time,
    String? date,
    String? car,
    String? customerNote,
    String? pickedVideo,
    String? pickedPhoto,
    String? pickedVoiceNote,
  ) async {
    final prefManager = await SharedPreferences.getInstance();
    String? userToken = prefManager.getString(SharedPrefKey.KEY_ACCESS_TOKEN);
    log(sourceIDs.toString());

    try {
      final body = {
        "address": address,
        "time": time,
        "date": date,
        "car": car,
        "customerNote": customerNote,
      };
      for (var i = 0; i < sourceIDs.length; i++) {
        body['sourceIDs[$i]'] = sourceIDs[i];
      }
      log(body.toString());
      var uri = Uri.parse("${RequestBuilder.API_BASE_URL}${RequestBuilder.API_CREATE_ESTIMATES}");
      var request = http.MultipartRequest('POST', uri);
      // log(sourceIDs.toString());
      // log(car!);
      // log(userToken!);
      request = jsonToFormData(request, body);
      request.headers['Content-Type'] = "'application/json'";
      request.headers['Authorization'] = "Bearer $userToken";
      if (Global.checkNull(pickedPhoto)) {
        request.files.add(await http.MultipartFile.fromPath(PARAMS.PARAM_IMAGE, pickedPhoto!));
      }

      if (Global.checkNull(pickedVideo)) {
        request.files.add(await http.MultipartFile.fromPath(PARAMS.PARAM_VIDEO, pickedVideo!));
      }
      if (Global.checkNull(pickedVoiceNote)) {
        request.files.add(await http.MultipartFile.fromPath(PARAMS.PARAM_VOICE_NOTE, pickedVoiceNote!));
      }

      //-----Uri for update shop--------//
      var uriUpdateShop = Uri.parse("${RequestBuilder.API_BASE_URL}${RequestBuilder.API_CREATE_ESTIMATES}");
      var res = await request.send();

      http.Response response = await http.Response.fromStream(res);
      inspect(response.body);

      final message = json.decode(response.body.toString());
      //..............Response Ok Part...................................................
      if (response.statusCode == 200) {
        isShowLoader = false;
        return true;
        // //dialog for multiple
        // Get.defaultDialog(
        //     barrierDismissible: false,
        //     title: "Estimation Requested".tr,
        //     titleStyle: AppStyle.textViewStyleNormalButton(
        //         context: Get.context!, color: Colors.black, fontSizeDelta: 3),
        //     content: Column(
        //       children: [
        //         const CircleAvatar(
        //           backgroundColor: Colors.green,
        //           radius: 32,
        //           child: Icon(
        //             Icons.done,
        //             color: Colors.white,
        //             size: 34,
        //           ),
        //         ),
        //         addVerticleSpace(5),
        //         Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Text(
        //             "We found 5 more service providers near you that match your requirements, would you like to request for an estimation from them?",
        //             style: AppStyle.textViewStyleNormalButton(
        //               context: Get.context!,
        //               color: Colors.black,
        //               fontSizeDelta: -2,
        //             ),
        //             textAlign: TextAlign.center,
        //           ),
        //         ),
        //       ],
        //     ),
        //     textConfirm: "Yes",
        //     textCancel: "No",
        //     confirmTextColor: Colors.white,
        //     onConfirm: () {
        //       // implemente the multi logic
        //     },
        //     onCancel: () {
        //       //   //................ goto Thank you......................
        //       Get.offAll(() => const ThankYouFragment());
        //     });
        // //end dialog
      }
      //.........................not ok ...................................................
      else {
        //   //.............Failure case............................
        Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: message, toastType: TOAST_TYPE.toastError);

        isShowLoader = false;
        update();
        return false;
      }
    } catch (e) {
      Global.showToastAlert(
          context: Get.overlayContext!, strTitle: "", strMsg: "Something went wrong, please try after some time", toastType: TOAST_TYPE.toastError);
      log(e.toString());

      Logger().e("Exception is=======>>${e.toString()}");
      return false;
    }
  }
}

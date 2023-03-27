import 'dart:collection';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as i;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:light_compressor/light_compressor.dart';
import 'package:location/location.dart';
import 'package:otobucks/View/MyBookings/Models/view_booking_model.dart';
import 'package:otobucks/View/ThankYou/Views/thankyou_fragment.dart';
import 'package:otobucks/global/Models/time_model.dart';
import 'package:otobucks/global/constants.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/global/global.dart';
import 'package:otobucks/services/repository/estimates_repo.dart';

// import '../Models/AllBookingsModel.dart';
class RescheduleBookingController extends GetxController {
  bool connectionStatus = false;
  bool isShowLoader = false;
  // late EstimatesModel? estimatesModel;
  Result? estimatesModel;
  TextEditingController controllerNote = TextEditingController();
  TextEditingController addressNote = TextEditingController(text: '');
  late TimeModel? mTimeModel;
  String selectedDate = "";
  String pickedImage = "";
  String pickedVideo = "";
  String voiceNoteFile = "";
  String selectedTime = "";
  String bookingid = "";
  late LatLng? mLatLng;

  Location location = Location();

  LightCompressor lightCompressor = LightCompressor();

  bool isVideoCompressed = false;

  onInitScreen(Result model) {
    if (estimatesModel != null) {
      estimatesModel = model;
      if (Global.checkNull(estimatesModel!.bookingDetails!.customerNote)) {
        controllerNote.text = estimatesModel!.bookingDetails!.customerNote.toString();
      }
      // selectedDate= estimatesModel!.bookingDetails!.date.toString();// mEstimatesModel.getDateInFormate();
      bookingid = estimatesModel!.id.toString();
      pickedImage = estimatesModel!.bookingDetails!.image!.first;
      log("estimatesModel!.bookingDetails!.video!.first");
      // if (estimatesModel!.bookingDetails!.video!.isNotEmpty) {
      //   log(model.bookingDetails!.video!.first);
      //   pickedVideo = model.bookingDetails!.video!.first;
      // }

      log("pickedVideo------33---------");
      log(pickedVideo);
      //----------------------------------------
      mTimeModel = getTimeModel(estimatesModel!.bookingDetails!.time);
      update();
      getLocationAdress();
    }
  }

  TimeModel getTimeModel(String? time) {
    DateTime parseDate = DateFormat("hh:00").parse(time!.split(":")[0] + ":00");
    String time12HR = DateFormat('hh:00 aa').format(parseDate);
    String time24HR = DateFormat('HH:00').format(parseDate);

    TimeModel mTimeModel = TimeModel(isSelected: true, isEnable: true, t24hr: parseDate.hour, time_24hr: time24HR, time_12hr: time12HR);
    return mTimeModel;
  }

  getLocationAdress() async {
    Location location = Location();
    PermissionStatus _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.granted || _permissionGranted == PermissionStatus.grantedLimited) {
      var currentLocation = await location.getLocation();
      log(currentLocation.latitude.toString());
      LatLng _mLatLng = LatLng(currentLocation.latitude!, currentLocation.longitude!);
      List<i.Placemark> placemarks = await i.placemarkFromCoordinates(_mLatLng.latitude, _mLatLng.longitude);
      addressNote.text = '${placemarks[0].street} ${placemarks[0].subLocality} ${placemarks[0].locality} ${placemarks[0].country}';

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
        destinationPath: _desFile,
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

    update();
  }

  onSelectDate(String _selectedDate) {
    log("date selected=========");
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

  onSelectVoiceNote(filePath) {
    voiceNoteFile = filePath;
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
/*
  checkDateTime(BuildContext context) {
    if (estimatesModel!.date.split('T')[0] == selectedDate &&
        (mTimeModel!.time_24hr.toString() ==
            estimatesModel!.getTimeModel().time_24hr.toString())) {
      AppViews.showCustomAlert(
          context: Get.overlayContext!,
          strTitle: 'Alert!',
          strMessage: 'Are you sure to use previous date and time?',
          strLeftBtnText: Constants.TEXT_CANCEL,
          onTapLeftBtn: () {
            Navigator.pop(Get.overlayContext!);
            return;
          },
          strRightBtnText: Constants.STRING_OK,
          onTapRightBtn: () {
            Navigator.pop(Get.overlayContext!);
            rescheduleEstimation(context);
          });
    } else {
      rescheduleEstimation(context);
    }
  }*/

  updateLatLang(LatLng mLatLng_) async {
    mLatLng = mLatLng_;
    getLocationAdress();
  }

/*
  rebook(BuildContext context, EstimatesModel estimatesModel) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreateEstimationScreen(
              screenType: 'viewEstimation',
              mServiceModel: ServiceModel(
                  rating: 0,
                  totalRatings: 0,
                  alFeatures: [],
                  alImages: [],
                  alStory: [],
                  alVideos: [],
                  currency: 'USD',
                  description: '',
                  id: estimatesModel.source!.id,
                  mCategoryModel: CategoryModel(
                      id: estimatesModel.source!.id,
                      title: estimatesModel.source!.title.toString(),
                      description: "",
                      image: "",
                      type: ""),
                  mServiceProviderModel:
                  estimatesModel.mServiceProviderModel!,
                  mSubCategoryModel: CategoryModel(
                      id: estimatesModel.source!.id,
                      title: estimatesModel.source!.title.toString(),
                      description: "",
                      image: "",
                      type: ""),
                  price: estimatesModel.source!.price,
                  title: estimatesModel.source!.title),
            )));
  }
  */
//.............goto profile
  // gotoProfile(BuildContext context) {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => ServiceProviderProfileScreen(
  //               rating: mServiceModel.rating.toDouble(),
  //               totalRatings: mServiceModel.totalRatings.toDouble(),
  //               mServiceProviderModel: mServiceModel.mServiceProviderModel,
  //               title: mServiceModel.title)));
  // }
//----------------------------------Reschedule Booking----------------------------
  reScheduleBooking(BuildContext context, String id, {String? imagePath}) async {
    log(id);
    log(selectedDate);
    log(selectedTime);
    log("picked image");
    log(pickedVideo);
    log(controllerNote.text);
    // if (Global.checkNull(pickedVideo)) {
    //   double fileSize = await Global.getFileSize(pickedVideo);
    //   if (fileSize > 10) {
    //     Global.showToastAlert(
    //         context: Get.overlayContext!,
    //         strTitle: "",
    //         strMsg: AppAlert.ALERT_FILE_SIZE,
    //         toastType: TOAST_TYPE.toastError);
    //     return "";
    //   }
    // }

    isShowLoader = true;
    update();
    String? strNote = controllerNote.text.toString();
    HashMap<String, String> requestParams = HashMap();
    HashMap<String, String> requestParamsImage = HashMap();
    // requestParamsImage["sourceID"]="62d461692e64f55c5c0802f3";
    requestParams["bookingID"] = id;
    requestParams[PARAMS.PARAM_DATE] = selectedDate;
    // final gasGiants = {PARAMS.PARAM_SOURCE:  mServiceModel.id, PARAMS.PARAM_ADDRESS: addressNote.text};
    requestParams[PARAMS.PARAM_TIME] = selectedTime;
    if (imagePath != null) {
      requestParamsImage[PARAMS.PARAM_IMAGE] = imagePath;
    }
    if (strNote.isNotEmpty) {
      requestParams[PARAMS.PARAM_CUTOMERNOTE] = strNote;
    }

    // requestParams[PARAMS.PARAM_ADDRESS] = addressNote.text;
    // if (mLatLng != null) {
    //   requestParams[PARAMS.PARAM_LATITUDE] =
    //       mLatLng!.latitude.toStringAsFixed(4);
    //   requestParams[PARAMS.PARAM_LONGITUDE] =
    //       mLatLng!.longitude.toStringAsFixed(4);
    // } else {
    //   requestParams[PARAMS.PARAM_LATITUDE] =
    //       Global.mLatLng.latitude.toStringAsFixed(4);
    //   requestParams[PARAMS.PARAM_LONGITUDE] =
    //       Global.mLatLng.longitude.toStringAsFixed(4);
    // }

    if (Global.checkNull(pickedImage)) {
      requestParamsImage[PARAMS.PARAM_IMAGE] = pickedImage;
    }
    //
    /*
    if (Global.checkNull(pickedVideo)) {
      requestParamsImage[PARAMS.PARAM_VIDEO] = pickedVideo;
    }
    if (Global.checkNull(voiceNoteFile)) {
      requestParamsImage[PARAMS.PARAM_VOICE_NOTE] = voiceNoteFile;
    }
    */
    // requestParamsImage.addEntries(gasGiants.entries);
    //........Rrepo of create estimation...................

    //Logger().i(requestParamsImage);

    var categories = await EstimatesRepo().rescheduleEstimates(requestParams, requestParamsImage, ReqType.patch);

    categories.fold((failure) {
      //.............Failure case............................
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);

      isShowLoader = false;
      update();
    }, (mResult) {
      isShowLoader = false;
      update();
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: "Rescheduled Successfully", toastType: TOAST_TYPE.toastSuccess);
      //................ goto Thank you......................
      Get.offAll(() => ThankYouFragment());
    });
  }

//--------------------------Rating Controller
}

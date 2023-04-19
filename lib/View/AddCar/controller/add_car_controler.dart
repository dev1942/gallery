import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:light_compressor/light_compressor.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../global/constants.dart';
import '../../../global/enum.dart';
import '../../../global/global.dart';
import '../../../global/url_collection.dart';
import '../addCar_toSell.dart';

class AddCarController extends GetxController {
  TextEditingController controllerCarBrand = TextEditingController();
  TextEditingController controllerCarTitle = TextEditingController();
  TextEditingController controllerCarDescription = TextEditingController();
  TextEditingController controllerCarModel = TextEditingController();
  TextEditingController controllerCarPrice = TextEditingController();
  TextEditingController controllerCarSeats = TextEditingController();
  TextEditingController controllerCarModelYear = TextEditingController();
  TextEditingController controllerMileage = TextEditingController();
  TextEditingController controllerColour = TextEditingController();
  TextEditingController controllerCode = TextEditingController();
  TextEditingController controllerCity = TextEditingController();
  TextEditingController controllerCarEngine = TextEditingController();
  TextEditingController controllerCarFuelType = TextEditingController();
  TextEditingController controllerCarKeyfeautre = TextEditingController();
  TextEditingController controllerCarBadges = TextEditingController();
  TextEditingController controllerCarWarranty = TextEditingController();
  TransmitionType transType = TransmitionType.manaual;

  List<String> keyfeatureList = [];
  List<String> badgesList = [];

  String pickedImage = "";
  String pickedVideo = "";
  bool isNew = false;
  bool hasAirBags = false;

  LightCompressor lightCompressor = LightCompressor();
  bool isVideoCompressed = false;
  bool isShowLoader = false;
  Future<void> showLoader() async {
    isShowLoader = true;
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

  onDeleteImage() {
    pickedImage = "";
    update();
  }

  onDeleteVideo() {
    pickedVideo = "";
    update();
  }

  void isValid() {
    if (controllerCarBrand.text.isNotEmpty &&
        controllerColour.text.isNotEmpty &&
        controllerCarModelYear.text.isNotEmpty &&
        controllerMileage.text.isNotEmpty) {
      mAddCarFoSell(
          brand: controllerCarBrand.text,
          title: controllerCarTitle.text,
          description: controllerCarDescription.text,
          carModelYear: controllerCarModelYear.text,
          km: controllerMileage.text,
          color: controllerColour.text,
          model: controllerCarModel.text,
          carPrice: controllerCarPrice.text,
          engineCC: controllerCarEngine.text,
          fuelType: controllerCarFuelType.text,
          numberOfSeats: controllerCarSeats.text,
          warranty: controllerCarWarranty.text,
          newOrUsed: isNew ? "New" : "Used",
          transMissionType: transType.name,
          keyFeature: keyfeatureList,
          badges: badgesList,
          hasAirBags: hasAirBags);
    } else {
      Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: "Please Fill All Fields", toastType: TOAST_TYPE.toastError);
    }
  }

  Future<bool> mAddCarFoSell({
    required String? brand,
    required String? title,
    required String? description,
    required String? carModelYear,
    required String? km,
    required String? color,
    required String? model,
    required String? carPrice,
    required String? engineCC,
    required String? fuelType,
    required String? numberOfSeats,
    required String? warranty,
    required String? newOrUsed,
    required String? transMissionType,
    required List<String>? keyFeature,
    required List<String>? badges,
    required bool? hasAirBags,
  }) async {
    final prefManager = await SharedPreferences.getInstance();
    String? userToken = prefManager.getString(SharedPrefKey.KEY_ACCESS_TOKEN);
    log(userToken!);
    String? userId = prefManager.getString(SharedPrefKey.KEY_USER_ID);

    try {
      final body = {
        "category": "64061f61d21bf5fcc33945e8",
        "subcategory": "6427bfe0222295655ce10dde",
        "brand": brand,
        "title": title,
        "description": description,
        "features": jsonEncode(keyfeatureList),
        "details": jsonEncode({
          "newOrUsed": newOrUsed,
          "model": model,
          "modelYear": carModelYear,
          "price": carPrice,
          "bodyType": "",
          "transmissionType": transMissionType,
          "fuelRange": "",
          "mileage": controllerMileage.text,
          "numberOfseats": numberOfSeats,
          "airBags": false,
          "engine": engineCC,
          "fuelType": fuelType,
          "color": color,
          "usage": "",
          "badges": badgesList,
          "topSpeed": ""
        }),
        "warranty": warranty,
        "provider": userId,
      };

      log(body.toString());
      var uri = Uri.parse("${RequestBuilder.API_BASE_URL}${RequestBuilder.API_CARS_ADD}");
      var request = http.MultipartRequest('POST', uri);
      // log(sourceIDs.toString());
      // log(car!);
      // log(userToken!);
      request = jsonToFormData(request, body);
      // request.headers['Content-Type'] = "'application/json'";
      request.headers['X-Requested-With'] = "XMLHttpRequest";
      request.headers['Authorization'] = "Bearer $userToken";
      if (Global.checkNull(pickedImage)) {
        request.files.add(await http.MultipartFile.fromPath(PARAMS.PARAM_IMAGE, pickedImage));
      }

      if (Global.checkNull(pickedVideo)) {
        request.files.add(await http.MultipartFile.fromPath(PARAMS.PARAM_VIDEO, pickedVideo));
      }

      //-----Uri for update shop--------//

      var res = await request.send();

      http.Response response = await http.Response.fromStream(res);
      inspect(response.body);
      log(response.body);

      final message = json.decode(response.body.toString());
      //..............Response Ok Part...................................................
      if (response.statusCode == 200) {
        isShowLoader = false;
        return true;
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

jsonToFormData(http.MultipartRequest request, Map<String, dynamic> data) {
  for (var key in data.keys) {
    request.fields[key] = data[key].toString();
  }
  return request;
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:otobucks/global/app_colors.dart';
import 'package:otobucks/widgets/Image_Select/image_source_sheet.dart';

enum ImageType {
  camera,
  gallery,
}

class ImagePickerUtility {
  String? _image;
  String? get image => _image;
  final _imagePicker = ImagePicker();
  dynamic _pickedFile;
  Future<ImageType> _getImageType(BuildContext context) async {
    final Completer<ImageType> completer = Completer();

    showModalBottomSheet(
      context: context,
      builder: (context) => imageSouceSheet(
        onCameraPressed: () {
          completer.complete(ImageType.camera);
          Navigator.of(context).pop();
        },
        onGalleryPressed: () {
          completer.complete(ImageType.gallery);
          Navigator.of(context).pop();
        },
        context: context,
      ),
    );
    return completer.future;
  }

  Future<void> pickImage(BuildContext context) async {
    final _imageType = await _getImageType(context);
    dynamic _file;
    //PickedFile? _file;
    if (_imageType == ImageType.camera) {
      _file = await _imagePicker.getImage(source: ImageSource.camera);
    } else {
      _file = await _imagePicker.getImage(source: ImageSource.gallery);
    }
    if (_file != null) {
      //File _image = File(_file.path);
      _image = _file.path;
      var tempImg = _image;
      if (tempImg != null) {
        var imagePath = await _cropImage(tempImg);
      }
    }
  }

  Future<String?> pickImageWithGallery() async {
    dynamic _file;
    //PickedFile? _file;
    _file = await _imagePicker.getImage(source: ImageSource.gallery);
    if (_file != null) {
      //File _image = File(_file.path);
      _image = _file.path;
      var tempImg = _image;
      if (tempImg != null) {
        _image = await _cropImage(tempImg);
      }
      return _image;
    }
  }

  Future<String?> pickImageWithReturn(BuildContext context) async {
    final _imageType = await _getImageType(context);
    dynamic _file;
    //PickedFile? _file;

    if (_imageType == ImageType.camera) {
      _file = await _imagePicker.getImage(source: ImageSource.camera);
    } else {
      _file = await _imagePicker.getImage(source: ImageSource.gallery);
    }

    if (_file != null) {
      _image = _file.path;
      //File _image = File(_file.path);
      var tempImg = _image;
      if (tempImg != null) {
        print("gallery");
        _image = await _cropImage(tempImg);
      }
      return _image;
    }
  }

  Future<String?> _cropImage(String imagePath) async {
    print("------8------");
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
    /*  androidUiSettings: AndroidUiSettings(
        toolbarTitle: "Crop Image",
        toolbarColor: AppColors.colorBlueEnd,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      iosUiSettings: IOSUiSettings(minimumAspectRatio: 1.0),*/
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: "Crop Image",
          toolbarColor: AppColors.colorBlueEnd,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(minimumAspectRatio: 1.0),
      ],

    );

    print("------9------");
    if (croppedFile != null) {
      print(croppedFile);
      print(croppedFile.path);
      return croppedFile.path;
    } else {
      throw Exception('No Cropped File Present');
    }
  }
}

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/global/Models/FilterListModel.dart';
import 'package:otobucks/global/enum.dart';
import 'package:otobucks/services/repository/filter_car_repo.dart';


class FilterScreenController extends GetxController {
  Rx<ShowData> mShowData = ShowData.showData.obs;
  bool newCar = true;
@override
  void onInit() {
    // TODO: implement onInit
    getFilterList();
    super.onInit();
  }
  String selectedCompany = '';
  Color selectedColor = Colors.transparent;
  String selectedModel = '';
  String selectedYear = '';
  String selectedBodyType = '';
  String selectedTransmission = '';
  String selectedFuelType = '';
  double priceMin = 0;
  double priceMax = 100;
  int milageMin = 0;
  int milageMax = 100;
  FilterListModel? filter;
  List<String> carCompanies = [
    'BMW',
    'Corolla',
    'Audi',
  ];
  List<String> fuelType = [
    'Petrol',
    'Charge',
    'Diesel',
  ];
  List<String> transmissionTypes = [
    'Manual',
    'Automatic',
  ];
  List<String> bodyType = ['Sedan', 'Micro', 'Antique', 'Sehan'];
  List<String> carYear = [
    '2015',
    '2016',
    '2017',
    '2018',
    '2019',
    '2020',
  ];
  List<Color> carColors = [
    Colors.purple,
    Colors.pink,
    Colors.green,
    Colors.amber,
  ];
  List<String> carModel = [
    'X6 (1st)',
    'X7 (oshan)',
    '1st Gen',
    'Reborn Edition'
  ];

  changeCarType(CarType carType) {
    switch (carType) {
      case CarType.newCar:
        newCar = true;
        break;
      case CarType.oldCar:
        newCar = false;
        break;
    }
    update();
  }

  changeCompany(String carCompani) {
    selectedCompany = carCompani;
    update();
  }

  changeModel(String carModel) {
    selectedModel = carModel;
    update();
  }

  changeYear(String carYear) {
    selectedYear = carYear;
    update();
  }

  changeColor(Color carColor) {
    selectedColor = carColor;
    update();
  }

  changeBodyType(String bodyType) {
    selectedBodyType = bodyType;
    update();
  }

  changeFuelType(String fuelType) {
    selectedFuelType = fuelType;
    update();
  }

  changeTransmission(String transmissionType) {
    selectedTransmission = transmissionType;
    update();
  }


  Future<void> getFilterList() async {
    mShowData.value = ShowData.showLoading;
    update();

    // isShowLoader = true;

    HashMap<String, Object> requestParams = HashMap();

    // var categories = await FilterRepo().filterList(requestParams);
    var category = await FilterRepo().filtersList(requestParams);

    print("Testing List print $category");

    // categories.fold((failure) {
    //   Global.showToastAlert(context: Get.overlayContext!, strTitle: "", strMsg: failure.MESSAGE, toastType: TOAST_TYPE.toastError);
    //
        mShowData.value = ShowData.showNoDataFound;
    //   update();
    // }, (mResult) {
      var carBrandsModel = category as FilterListModel;
      // var carBrandsModel = mResult.responseData as FilterListModel;

      filter = carBrandsModel;
    carCompanies=filter!.result!.carCompanyList!;
    update();
    carModel=filter!.result!.carModalList!;
    update();
    carYear=filter!.result!.carModelYearList!;
    bodyType=filter!.result!.bodyTypeList!;
    update();
    priceMin=double.tryParse(filter!.result!.priceRange!.min!)??0;
    print("priceMin");
    print(priceMin);
    priceMax=double.tryParse(filter!.result!.priceRange!.max!)??100;
    print("priceMax");
    print(priceMax);
    update();

    milageMin=filter!.result!.milageRange!.min??0;
    milageMax=filter!.result!.milageRange!.max??50;
    print("Testing List print ${filter!.result!.carCompanyList}");

      mShowData.value = ShowData.showData;
      update();

    // });
  }

}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otobucks/global/enum.dart';

class FilterScreenController extends GetxController {
  bool newCar = true;

  String selectedCompany = '';
  Color selectedColor = Colors.transparent;
  String selectedModel = '';
  String selectedYear = '';
  String selectedBodyType = '';
  String selectedTransmission = '';
  String selectedFuelType = '';

  List<String> carCompanies = [
    'BMW',
    'Collora',
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
  }

  changeTransmission(String transmissionType) {
    selectedTransmission = transmissionType;
  }
}

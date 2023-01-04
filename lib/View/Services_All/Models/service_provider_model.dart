import 'dart:developer';

import '../../../global/global.dart';

class ServiceProviderModel {
  String id;
  String firstName;
  String lastName;
  String email;
  String image;
  String phone;
  String coverImage;
  String role;
  String experienceLevel;
  String about;
  String banned;
  String isEmailVerified;
  String isPhoneVerified;
  String status;

  List<String> country;
  List<String> states;
  List<String> cities;

  ServiceProviderModel(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.image,
      required this.phone,
      required this.coverImage,
      required this.country,
      required this.states,
      required this.cities,
      required this.role,
      required this.experienceLevel,
      required this.about,
      required this.banned,
      required this.isEmailVerified,
      required this.isPhoneVerified,
      required this.status});

  factory ServiceProviderModel.fromJson(Map<String, dynamic> json) {
    List<String> country = [];
    List<String> states = [];
    List<String> cities = [];

    try {
      var mCountry = json['country'];
      for (var countryItem in mCountry) {
        country.add(countryItem.toString());
      }
    } catch (e) {
      log(e.toString());
    }

    try {
      var mStates = json['states'];
      for (var statesItem in mStates) {
        states.add(statesItem.toString());
      }
    } catch (e) {
      log(e.toString());
    }
    try {
      var mCities = json['cities'];
      for (var citiesItem in mCities) {
        cities.add(citiesItem.toString());
      }
    } catch (e) {
      log(e.toString());
    }

    return ServiceProviderModel(
        id: json['_id'].toString(),
        firstName: json['firstName'].toString(),
        lastName: json['lastName'].toString(),
        email: json['email'].toString(),
        phone: json['phone'].toString(),
        role: json['role'].toString(),
        experienceLevel: json['experienceLevel'].toString(),
        about: json['about'].toString(),
        country: country,
        states: states,
        cities: cities,
        image: json['image'].toString(),
        coverImage: json['coverImage'].toString(),
        banned: json['banned'].toString(),
        isEmailVerified: json['isEmailVerified'].toString(),
        isPhoneVerified: json['isPhoneVerified'].toString(),
        status: json['status'].toString());
  }

  getName() {
    StringBuffer buffer = StringBuffer();
    if (Global.checkNull(firstName)) {
      buffer.write(firstName);
    }
    if (Global.checkNull(lastName)) {
      buffer.write(" " + lastName);
    }
    return buffer.toString();
  }
}

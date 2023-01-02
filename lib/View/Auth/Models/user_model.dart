import 'dart:developer';

class UserModel {
  String id;
  List<String> country;
  List<String> states;
  List<String> cities;
  String banned;
  String address;
  bool isEmailVerified;
  bool isPhoneVerified;
  String role;
  String experienceLevel;
  String about;
  String status;
  Emergency emergency;
  Car car;
  String firstName;
  String lastName;
  String email;
  String phone;
  String countryCode;
  String image;
  Customer customer;

  UserModel(
      {required this.id,
      required this.country,
      required this.states,
      required this.cities,
      required this.banned,
      required this.address,
      required this.isEmailVerified,
      required this.isPhoneVerified,
      required this.role,
      required this.experienceLevel,
      required this.about,
      required this.status,
      required this.emergency,
      required this.car,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phone,
      required this.countryCode,
      required this.image,
      required this.customer});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    List<String> country = [];
    List<String> states = [];
    List<String> cities = [];
    Emergency mEmergency = Emergency(
      emergencyName: "",
      emergencyPhone: "",
    );
    Car mCar = Car(
      color: "",
      brand: "",
      mileage: "",
      modelYear: "",
    );
    Customer mCustomer = Customer(
        drivingLicence: "",
        emiratesIDBack: "",
        emiratesIDFront: "",
        mulkiya: "");

    try {
      var mImage = json['country'];
      for (var imageItem in mImage) {
        country.add(imageItem.toString());
      }
    } catch (e) {
      log(e.toString());
    }
    try {
      var mImage = json['states'];
      for (var imageItem in mImage) {
        states.add(imageItem.toString());
      }
    } catch (e) {
      log(e.toString());
    }
    try {
      var mImage = json['cities'];
      for (var imageItem in mImage) {
        cities.add(imageItem.toString());
      }
    } catch (e) {
      log(e.toString());
    }
    try {
      var emergency = json['emergency'];
      for (var imageItem in emergency) {
        mEmergency = Emergency.fromJson(imageItem);
      }
    } catch (e) {
      log(e.toString());
    }
    try {
      var car = json['car'];
      for (var imageItem in car) {
        mCar = Car.fromJson(imageItem);
      }
    } catch (e) {
      log(e.toString());
    }
    try {
      var customer = json['customer'];
      mCustomer = Customer.fromJson(customer);
    } catch (e) {
      log(e.toString());
    }

    return UserModel(
        id: json['_id'].toString(),
        country: country,
        cities: cities,
        states: states,
        banned: json['banned'].toString(),
        address: json['address'].toString(),
        isEmailVerified: json['isEmailVerified'] ?? false,
        isPhoneVerified: json['isPhoneVerified'] ?? false,
        role: json['role'].toString(),
        experienceLevel: json['experienceLevel'].toString(),
        about: json['about'].toString(),
        status: json['status'].toString(),
        emergency: mEmergency,
        car: mCar,
        firstName: json['firstName'].toString(),
        lastName: json['lastName'].toString(),
        email: json['email'].toString(),
        phone: json['phone'].toString(),
        countryCode: json['countryCode'].toString(),
        image: json['image'].toString(),
        customer: mCustomer);
  }
}

class Emergency {
  String emergencyName;
  String emergencyPhone;

  Emergency({required this.emergencyName, required this.emergencyPhone});

  factory Emergency.fromJson(Map<String, dynamic> json) {
    return Emergency(
      emergencyName: json['emergencyName'].toString(),
      emergencyPhone: json['emergencyPhone'].toString(),
    );
  }
}

class Car {
  String brand;
  String color;
  String modelYear;
  String mileage;

  Car(
      {required this.brand,
      required this.color,
      required this.modelYear,
      required this.mileage});

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      brand: json['brand'].toString(),
      color: json['color'].toString(),
      modelYear: json['modelYear'].toString(),
      mileage: json['mileage'].toString(),
    );
  }
}

class Customer {
  String drivingLicence;
  String emiratesIDFront;
  String emiratesIDBack;
  String mulkiya;

  Customer(
      {required this.drivingLicence,
      required this.emiratesIDFront,
      required this.emiratesIDBack,
      required this.mulkiya});

  factory Customer.fromJson(Map<String, dynamic> json) {
    String drivingLicence_ = "",
        emiratesIDFront_ = "",
        emiratesIDBack_ = "",
        mulkiya_ = "";

    try {
      var _drivingLicence = json['drivingLicence'];
      drivingLicence_ = _drivingLicence['image'].toString();
    } catch (e) {
      log(e.toString());
    }

    try {
      var emiratesID = json['emiratesID'];
      emiratesIDFront_ = emiratesID['frontImage'].toString();
      emiratesIDBack_ = emiratesID['backImage'].toString();
    } catch (e) {
      log(e.toString());
    }

    try {
      var mulkiya = json['mulkiya'];
      mulkiya_ = mulkiya['image'].toString();
    } catch (e) {
      log(e.toString());
    }

    return Customer(
        drivingLicence: drivingLicence_,
        emiratesIDFront: emiratesIDFront_,
        emiratesIDBack: emiratesIDBack_,
        mulkiya: mulkiya_);
  }
}

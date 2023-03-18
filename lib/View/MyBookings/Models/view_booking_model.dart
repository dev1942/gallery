class BookingModel {
  final String? status;
  final String? message;
  final List<Result>? result;

  BookingModel({
    this.status,
    this.message,
    this.result,
  });

  BookingModel.fromJson(Map<dynamic, dynamic> json)
      : status = json['status'] as String?,
        message = json['message'] as String?,
        result = (json['result'] as List?)?.map((dynamic e) => Result.fromJson(e as Map<String,dynamic>)).toList();

  Map<dynamic, dynamic> toJson() => {
    'status' : status,
    'message' : message,
    'result' : result?.map((e) => e.toJson()).toList()
  };
}

class Result {
  final BookingDetails? bookingDetails;
  final Dispute? dispute;
  final StatusInfo? statusInfo;
   dynamic  totalprice;
   dynamic paymentCompleted;
  final bool? disputeStatus;
  final String? status;
  final String? id;
  final bool? rated;
  final bool? deleted;
  final Provider? provider;
  final Customer? customer;
  final String? type;
  final String? address;
  final Source? source;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final Estimation? estimation;

  Result({
    this.bookingDetails,
    this.dispute,
    this.statusInfo,
    this.totalprice,
    this.paymentCompleted,
    this.disputeStatus,
    this.status,
    this.id,
    this.rated,
    this.deleted,
    this.provider,
    this.customer,
    this.type,
    this.address,
    this.source,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.estimation,
  });

  Result.fromJson(Map<String, dynamic> json)
      : bookingDetails = (json['bookingDetails'] as Map<String,dynamic>?) != null ? BookingDetails.fromJson(json['bookingDetails'] as Map<String,dynamic>) : null,
       dispute = (json['dispute'] as Map<String,dynamic>?) != null ? Dispute.fromJson(json['dispute'] as Map<String,dynamic>) : null,
        statusInfo = (json['statusInfo'] as Map<String,dynamic>?) != null ? StatusInfo.fromJson(json['statusInfo'] as Map<String,dynamic>) : null,
        totalprice = json['totalprice'] as dynamic,
        paymentCompleted = json['paymentCompleted']as dynamic,
        disputeStatus = json['disputeStatus'] as bool?,
        status = json['status'] as String?,
        id = json['_id'] as String?,
        rated = json['rated'] as bool?,
        deleted = json['deleted'] as bool?,
        provider = (json['provider'] as Map<String,dynamic>?) != null ? Provider.fromJson(json['provider'] as Map<String,dynamic>) : null,
        customer = (json['customer'] as Map<String,dynamic>?) != null ? Customer.fromJson(json['customer'] as Map<String,dynamic>) : null,
        type = json['type'] as String?,
        address = json['address'] as String?,
        source = (json['source'] as Map<String,dynamic>?) != null ? Source.fromJson(json['source'] as Map<String,dynamic>) : null,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?,
        v = json['__v'] as int?,
        estimation = (json['estimation'] as Map<String,dynamic>?) != null ? Estimation.fromJson(json['estimation'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'bookingDetails' : bookingDetails?.toJson(),
    'statusInfo' : statusInfo?.toJson(),
    'totalprice' : totalprice,
    'paymentCompleted' : paymentCompleted,
    'disputeStatus' : disputeStatus,
    'status' : status,
    '_id' : id,
    'rated' : rated,
    'provider' : provider?.toJson(),
    'customer' : customer?.toJson(),
    'type' : type,
    'address' : address,
    'source' : source?.toJson(),
    'createdAt' : createdAt,
    'updatedAt' : updatedAt,
    '__v' : v,
    'estimation' : estimation?.toJson()
  };
}

class BookingDetails {
  final String? time;
  final List<dynamic>? file;
  final List<dynamic>? image;
  final List<dynamic>? voiceNote;
  final List<dynamic>? video;
  final String? date;
  final String? customerNote;
  final Car? car;

  BookingDetails({
    this.time,
    this.file,
    this.image,
    this.voiceNote,
    this.video,
    this.date,
    this.customerNote,
    this.car,
  });

  BookingDetails.fromJson(Map<String, dynamic> json)
      : time = json['time'] as String?,
        file = json['file'] as List?,
        image = json['image'] as List?,
        voiceNote = json['voiceNote'] as List?,
        video = json['video'] as List?,
        date = json['date'] as String?,
        customerNote = json['customerNote'] as String?,
        car = (json['car'] as Map<String,dynamic>?) != null ? Car.fromJson(json['car'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'time' : time,
    'file' : file,
    'image' : image,
    'voiceNote' : voiceNote,
    'video' : video,
    'date' : date,
    'customerNote' : customerNote,
    'car' : car?.toJson()
  };
}

class Car {
  final String? id;
  final String? brand;
  final String? carCode;
  final String? mileage;
  final String? carNumber;
  final String? color;
  final String? modelYear;
  final String? carCity;

  Car({
    this.id,
    this.brand,
    this.carCode,
    this.mileage,
    this.carNumber,
    this.color,
    this.modelYear,
    this.carCity,
  });

  Car.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        brand = json['brand'] as String?,
        carCode = json['carCode'] as String?,
        mileage = json['mileage'] as String?,
        carNumber = json['carNumber'] as String?,
        color = json['color'] as String?,
        modelYear = json['modelYear'] as String?,
        carCity = json['carCity'] as String?;

  Map<String, dynamic> toJson() => {
    '_id' : id,
    'brand' : brand,
    'carCode' : carCode,
    'mileage' : mileage,
    'carNumber' : carNumber,
    'color' : color,
    'modelYear' : modelYear,
    'carCity' : carCity
  };
}

class StatusInfo {
  final String? by;
  final String? reason;

  StatusInfo({
    this.by,
    this.reason,
  });

  StatusInfo.fromJson(Map<String, dynamic> json)
      : by = json['by'] as String?,
        reason = json['reason'] as String?;

  Map<String, dynamic> toJson() => {
    'by' : by,
    'reason' : reason
  };
}

class Provider {
  final List<String>? country;
  final List<String>? states;
  final List<String>? cities;
  final bool? banned;
  final bool? isEmailVerified;
  final bool? isPhoneVerified;
  final String? role;
  final String? experienceLevel;
  final String? about;
  final String? status;
  final String? approvedBy;
  final String? firebaseToken;
  final List<dynamic>? emergency;
  final String? id;
  final List<dynamic>? car;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? refrence;
  final String? image;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final String? stripeId;
  final String? coverImage;
  final List<dynamic>? location;
  final List<dynamic>? cars;
  final String? id1;

  Provider({
    this.country,
    this.states,
    this.cities,
    this.banned,
    this.isEmailVerified,
    this.isPhoneVerified,
    this.role,
    this.experienceLevel,
    this.about,
    this.status,
    this.approvedBy,
    this.firebaseToken,
    this.emergency,
    this.id,
    this.car,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.refrence,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.stripeId,
    this.coverImage,
    this.location,
    this.cars,
    this.id1,
  });

  Provider.fromJson(Map<String, dynamic> json)
      : country = (json['country'] as List?)?.map((dynamic e) => e as String).toList(),
        states = (json['states'] as List?)?.map((dynamic e) => e as String).toList(),
        cities = (json['cities'] as List?)?.map((dynamic e) => e as String).toList(),
        banned = json['banned'] as bool?,
        isEmailVerified = json['isEmailVerified'] as bool?,
        isPhoneVerified = json['isPhoneVerified'] as bool?,
        role = json['role'] as String?,
        experienceLevel = json['experienceLevel'] as String?,
        about = json['about'] as String?,
        status = json['status'] as String?,
        approvedBy = json['approvedBy'] as String?,
        firebaseToken = json['firebaseToken'] as String?,
        emergency = json['emergency'] as List?,
        id = json['_id'] as String?,
        car = json['car'] as List?,
        firstName = json['firstName'] as String?,
        lastName = json['lastName'] as String?,
        email = json['email'] as String?,
        phone = json['phone'] as String?,
        refrence = json['refrence'] as String?,
        image = json['image'] as String?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?,
        v = json['__v'] as int?,
        stripeId = json['stripeId'] as String?,
        coverImage = json['coverImage'] as String?,
        location = json['location'] as List?,
        cars = json['cars'] as List?,
        id1 = json['id'] as String?;

  Map<String, dynamic> toJson() => {
    'country' : country,
    'states' : states,
    'cities' : cities,
    'banned' : banned,
    'isEmailVerified' : isEmailVerified,
    'isPhoneVerified' : isPhoneVerified,
    'role' : role,
    'experienceLevel' : experienceLevel,
    'about' : about,
    'status' : status,
    'approvedBy' : approvedBy,
    'firebaseToken' : firebaseToken,
    'emergency' : emergency,
    '_id' : id,
    'car' : car,
    'firstName' : firstName,
    'lastName' : lastName,
    'email' : email,
    'phone' : phone,
    'refrence' : refrence,
    'image' : image,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt,
    '__v' : v,
    'stripeId' : stripeId,
    'coverImage' : coverImage,
    'location' : location,
    'cars' : cars,
    'id' : id1
  };
}

class Customer {
  final List<String>? country;
  final List<dynamic>? states;
  final List<dynamic>? cities;
  final bool? banned;
  final bool? isEmailVerified;
  final bool? isPhoneVerified;
  final String? role;
  final String? experienceLevel;
  final String? about;
  final String? status;
  final dynamic approvedBy;
  final String? firebaseToken;
  final List<Emergency>? emergency;
  final String? id;
  final String? firstName;
  final String? phone;
  final String? countryCode;
  final String? email;
  final String? lastName;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final String? image;
  final String? address;
  final String? stripeId;
  final List<Cars>? cars;
  final List<dynamic>? location;
  final String? id1;

  Customer({
    this.country,
    this.states,
    this.cities,
    this.banned,
    this.isEmailVerified,
    this.isPhoneVerified,
    this.role,
    this.experienceLevel,
    this.about,
    this.status,
    this.approvedBy,
    this.firebaseToken,
    this.emergency,
    this.id,
    this.firstName,
    this.phone,
    this.countryCode,
    this.email,
    this.lastName,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.image,
    this.address,
    this.stripeId,
    this.cars,
    this.location,
    this.id1,
  });

  Customer.fromJson(Map<String, dynamic> json)
      : country = (json['country'] as List?)?.map((dynamic e) => e as String).toList(),
        states = json['states'] as List?,
        cities = json['cities'] as List?,
        banned = json['banned'] as bool?,
        isEmailVerified = json['isEmailVerified'] as bool?,
        isPhoneVerified = json['isPhoneVerified'] as bool?,
        role = json['role'] as String?,
        experienceLevel = json['experienceLevel'] as String?,
        about = json['about'] as String?,
        status = json['status'] as String?,
        approvedBy = json['approvedBy'],
        firebaseToken = json['firebaseToken'] as String?,
        emergency = (json['emergency'] as List?)?.map((dynamic e) => Emergency.fromJson(e as Map<String,dynamic>)).toList(),
        id = json['_id'] as String?,
        firstName = json['firstName'] as String?,
        phone = json['phone'] as String?,
        countryCode = json['countryCode'] as String?,
        email = json['email'] as String?,
        lastName = json['lastName'] as String?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?,
        v = json['__v'] as int?,
        image = json['image'] as String?,
        address = json['address'] as String?,
        stripeId = json['stripeId'] as String?,
        cars = (json['cars'] as List?)?.map((dynamic e) => Cars.fromJson(e as Map<String,dynamic>)).toList(),
        location = json['location'] as List?,
        id1 = json['id'] as String?;

  Map<String, dynamic> toJson() => {
    'country' : country,
    'states' : states,
    'cities' : cities,
    'banned' : banned,
    'isEmailVerified' : isEmailVerified,
    'isPhoneVerified' : isPhoneVerified,
    'role' : role,
    'experienceLevel' : experienceLevel,
    'about' : about,
    'status' : status,
    'approvedBy' : approvedBy,
    'firebaseToken' : firebaseToken,
    'emergency' : emergency?.map((e) => e.toJson()).toList(),
    '_id' : id,
    'firstName' : firstName,
    'phone' : phone,
    'countryCode' : countryCode,
    'email' : email,
    'lastName' : lastName,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt,
    '__v' : v,
    'image' : image,
    'address' : address,
    'stripeId' : stripeId,
    'cars' : cars?.map((e) => e.toJson()).toList(),
    'location' : location,
    'id' : id1
  };
}

class Emergency {
  final String? emergencyName;
  final String? emergencyPhone;

  Emergency({
    this.emergencyName,
    this.emergencyPhone,
  });

  Emergency.fromJson(Map<String, dynamic> json)
      : emergencyName = json['emergencyName'] as String?,
        emergencyPhone = json['emergencyPhone'] as String?;

  Map<String, dynamic> toJson() => {
    'emergencyName' : emergencyName,
    'emergencyPhone' : emergencyPhone
  };
}

class Cars {
  final String? id;
  final String? brand;
  final String? carCode;
  final String? mileage;
  final String? carNumber;
  final String? color;
  final String? modelYear;
  final String? carCity;

  Cars({
    this.id,
    this.brand,
    this.carCode,
    this.mileage,
    this.carNumber,
    this.color,
    this.modelYear,
    this.carCity,
  });

  Cars.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        brand = json['brand'] as String?,
        carCode = json['carCode'] as String?,
        mileage = json['mileage'] as String?,
        carNumber = json['carNumber'] as String?,
        color = json['color'] as String?,
        modelYear = json['modelYear'] as String?,
        carCity = json['carCity'] as String?;

  Map<String, dynamic> toJson() => {
    '_id' : id,
    'brand' : brand,
    'carCode' : carCode,
    'mileage' : mileage,
    'carNumber' : carNumber,
    'color' : color,
    'modelYear' : modelYear,
    'carCity' : carCity
  };
}

class Source {
  final List<String>? stores;
  final List<String>? image;
  final List<String>? video;
  final List<String>? features;
  final bool? deleted;
  final bool? active;
  final String? id;
  final String? category;
  final String? subcategory;
  final String? title;
  final String? description;
  final dynamic price;
  final String? provider;
  final String? currency;
  final String? activeByAdmin;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final String? id1;

  Source({
    this.stores,
    this.image,
    this.video,
    this.features,
    this.deleted,
    this.active,
    this.id,
    this.category,
    this.subcategory,
    this.title,
    this.description,
    this.price,
    this.provider,
    this.currency,
    this.activeByAdmin,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.id1,
  });

  Source.fromJson(Map<String, dynamic> json)
      : stores = (json['stores'] as List?)?.map((dynamic e) => e as String).toList(),
        image = (json['image'] as List?)?.map((dynamic e) => e as String).toList(),
        video = (json['video'] as List?)?.map((dynamic e) => e as String).toList(),
        features = (json['features'] as List?)?.map((dynamic e) => e as String).toList(),
        deleted = json['deleted'] as bool?,
        active = json['active'] as bool?,
        id = json['_id'] as String?,
        category = json['category'] as String?,
        subcategory = json['subcategory'] as String?,
        title = json['title'] as String?,
        description = json['description'] as String?,
        price = json['price'] as dynamic,
        provider = json['provider'] as String?,
        currency = json['currency'] as String?,
        activeByAdmin = json['activeByAdmin'] as String?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?,
        v = json['__v'] as int?,
        id1 = json['id'] as String?;

  Map<String, dynamic> toJson() => {
    'stores' : stores,
    'image' : image,
    'video' : video,
    'features' : features,
    'deleted' : deleted,
    'active' : active,
    '_id' : id,
    'category' : category,
    'subcategory' : subcategory,
    'title' : title,
    'description' : description,
    'price' : price,
    'provider' : provider,
    'currency' : currency,
    'activeByAdmin' : activeByAdmin,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt,
    '__v' : v,
    'id' : id1
  };
}

class Estimation {
  final List<String>? estimationImage;
  final bool? isOfferCreated;
  final String? offerStatus;
  final List<Items>? items;
  final dynamic serviceTax;
  final String? invoiceNumber;
  final dynamic subTotal;
  final dynamic grandTotal;
  final String? updatedAt;
  final String? createdAt;
  final dynamic offerAmount;
  final String? offerNote;

  Estimation({
    this.estimationImage,
    this.isOfferCreated,
    this.offerStatus,
    this.items,
    this.serviceTax,
    this.invoiceNumber,
    this.subTotal,
    this.grandTotal,
    this.updatedAt,
    this.createdAt,
    this.offerAmount,
    this.offerNote,
  });

  Estimation.fromJson(Map<String, dynamic> json)
      : estimationImage = (json['estimationImage'] as List?)?.map((dynamic e) => e as String).toList(),
        isOfferCreated = json['isOfferCreated'] as bool?,
        offerStatus = json['offerStatus'] as String?,
        items = (json['items'] as List?)?.map((dynamic e) => Items.fromJson(e as Map<String,dynamic>)).toList(),
        serviceTax = json['serviceTax'] as dynamic,
        invoiceNumber = json['invoiceNumber'] as String?,
        subTotal = json['subTotal'] as dynamic,
        grandTotal = json['grandTotal'] as dynamic,
        updatedAt = json['updatedAt'] as String?,
        createdAt = json['createdAt'] as String?,
        offerAmount = json['offerAmount'] as dynamic,
        offerNote = json['offerNote'] as String?;

  Map<String, dynamic> toJson() => {
    'estimationImage' : estimationImage,
    'isOfferCreated' : isOfferCreated,
    'offerStatus' : offerStatus,
    'items' : items?.map((e) => e.toJson()).toList(),
    'serviceTax' : serviceTax,
    'invoiceNumber' : invoiceNumber,
    'subTotal' : subTotal,
    'grandTotal' : grandTotal,
    'updatedAt' : updatedAt,
    'createdAt' : createdAt,
    'offerAmount' : offerAmount,
    'offerNote' : offerNote
  };
}

class Items {
  final String? title;
  final String? description;
  final String? quantity;
  final String? price;
  final dynamic tax;
  final String? amount;

  Items({
    this.title,
    this.description,
    this.quantity,
    this.price,
    this.tax,
    this.amount,
  });

  Items.fromJson(Map<String, dynamic> json)
      : title = json['title'] as String?,
        description = json['description'] as String?,
        quantity = json['quantity'] as String?,
        price = json['price'] as String?,
        tax = json['tax'] as dynamic,
        amount = json['amount'] as String?;

  Map<String, dynamic> toJson() => {
    'title' : title,
    'description' : description,
    'quantity' : quantity,
    'price' : price,
    'tax' : tax,
    'amount' : amount
  };
}
class Dispute {
  String? ssn;
  String? disputeStatus;
  List<String>? country;
  String? adminStatus;
  bool? deleted;
  String? sId;
  String? booking;
  String? description;
  String? title;
  String? disputeimage;
  String? customer;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  int? iV;
String ?adminRemarks;
  Dispute(
      {this.ssn,
        this.disputeStatus,
        this.country,
        this.adminStatus,
        this.deleted,
        this.sId,
        this.booking,
        this.description,
        this.title,
        this.disputeimage,
        this.customer,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
        this.iV,
      this.adminRemarks});

  Dispute.fromJson(Map<String, dynamic> json) {
    ssn = json['ssn'];
    disputeStatus = json['disputeStatus'];
    country = json['country'].cast<String>();
    adminStatus = json['adminStatus'];
    deleted = json['deleted'];
    sId = json['_id'];
    booking = json['booking'];
    description = json['description'];
    title = json['title'];
    disputeimage = json['disputeimage'];
    customer = json['customer'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    adminRemarks = json['adminRemarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ssn'] = this.ssn;
    data['disputeStatus'] = this.disputeStatus;
    data['country'] = this.country;
    data['adminStatus'] = this.adminStatus;
    data['deleted'] = this.deleted;
    data['_id'] = this.sId;
    data['booking'] = this.booking;
    data['description'] = this.description;
    data['title'] = this.title;
    data['disputeimage'] = this.disputeimage;
    data['customer'] = this.customer;
    data['createdBy'] = this.createdBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['adminRemarks'] = this.adminRemarks;
    return data;
  }
}

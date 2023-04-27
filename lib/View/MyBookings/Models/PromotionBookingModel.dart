// ignore_for_file: file_names

class PromotionBookingHistory {
  String? status;
  String? message;
  int? countOnPage;
  int? totalCount;
  List<ProotionResult>? result;

  PromotionBookingHistory({this.status, this.message, this.countOnPage, this.totalCount, this.result});

  PromotionBookingHistory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    countOnPage = json['countOnPage'];
    totalCount = json['totalCount'];
    if (json['result'] != null) {
      result = <ProotionResult>[];
      json['result'].forEach((v) {
        result!.add(ProotionResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['countOnPage'] = countOnPage;
    data['totalCount'] = totalCount;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProotionResult {
  String? ssn;
  num? totalprice;
  String? status;
  String? sId;
  Provider? provider;
  Provider? customer;
  String? paymentMethod;
  String? transactionId;
  Promotion? promotion;
  String? paymentStatus;
  String? address;
  BookingDetails? bookingDetails;
  String? createdAt;
  String? updatedAt;
  String? acceptNote;
  String? rescheduleNote;

  ProotionResult({
    this.ssn,
    this.totalprice,
    this.status,
    this.sId,
    this.provider,
    this.customer,
    this.paymentMethod,
    this.transactionId,
    this.promotion,
    this.paymentStatus,
    this.address,
    this.bookingDetails,
    this.createdAt,
    this.updatedAt,
    this.acceptNote,
    this.rescheduleNote,
  });

  ProotionResult.fromJson(Map<String, dynamic> json) {
    ssn = json['ssn'];
    totalprice = json['totalprice'];
    status = json['status'];
    sId = json['_id'];
    provider = json['provider'] != null ? Provider.fromJson(json['provider']) : null;
    customer = json['customer'] != null ? Provider.fromJson(json['customer']) : null;
    paymentMethod = json['paymentMethod'];
    transactionId = json['transactionId'];
    promotion = json['promotion'] != null ? Promotion.fromJson(json['promotion']) : null;
    paymentStatus = json['paymentStatus'];
    address = json['address'];
    acceptNote = json['acceptNote'] ?? "";
    rescheduleNote = json['rescheduleNote'] ?? "";
    bookingDetails = json['bookingDetails'] != null ? BookingDetails.fromJson(json['bookingDetails']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ssn'] = ssn;
    data['totalprice'] = totalprice;
    data['status'] = status;
    data['_id'] = sId;
    if (provider != null) {
      data['provider'] = provider!.toJson();
    }
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    data['paymentMethod'] = paymentMethod;
    data['transactionId'] = transactionId;
    if (promotion != null) {
      data['promotion'] = promotion!.toJson();
    }
    data['paymentStatus'] = paymentStatus;
    data['address'] = address;
    if (bookingDetails != null) {
      data['bookingDetails'] = bookingDetails!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Provider {
  List<String>? country;
  String? role;
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? id;

  Provider({this.country, this.role, this.sId, this.firstName, this.lastName, this.email, this.phone, this.id});

  Provider.fromJson(Map<String, dynamic> json) {
    country = json['country'].cast<String>();
    role = json['role'];
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = country;
    data['role'] = role;
    data['_id'] = sId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['id'] = id;
    return data;
  }
}

class Promotion {
  String? ssn;
  List<String>? promoImg;
  bool? deleted;
  bool? active;
  String? paymentStatus;
  String? sId;
  Source? source;
  String? title;
  String? description;
  int? previousPrice;
  int? discount;
  num? priceAfterDiscount;
  String? startDate;
  String? endDate;
  String? country;
  String? location;
  String? days;
  String? sourceType;
  int? promotionCharges;
  Provider? provider;
  String? activeByAdmin;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? id;

  Promotion(
      {this.ssn,
      this.promoImg,
      this.deleted,
      this.active,
      this.paymentStatus,
      this.sId,
      this.source,
      this.title,
      this.description,
      this.previousPrice,
      this.discount,
      this.priceAfterDiscount,
      this.startDate,
      this.endDate,
      this.country,
      this.location,
      this.days,
      this.sourceType,
      this.promotionCharges,
      this.provider,
      this.activeByAdmin,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.id});

  Promotion.fromJson(Map<String, dynamic> json) {
    ssn = json['ssn'];
    promoImg = json['promoImg'].cast<String>();
    deleted = json['deleted'];
    active = json['active'];
    paymentStatus = json['paymentStatus'];
    sId = json['_id'];
    source = json['source'] != null ? Source.fromJson(json['source']) : null;
    title = json['title'];
    description = json['description'];
    previousPrice = json['previousPrice'];
    discount = json['discount'];
    priceAfterDiscount = json['priceAfterDiscount'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    country = json['country'];
    location = json['location'];
    days = json['days'];
    sourceType = json['sourceType'];
    promotionCharges = json['promotionCharges'];
    provider = json['provider'] != null ? Provider.fromJson(json['provider']) : null;
    activeByAdmin = json['activeByAdmin'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ssn'] = ssn;
    data['promoImg'] = promoImg;
    data['deleted'] = deleted;
    data['active'] = active;
    data['paymentStatus'] = paymentStatus;
    data['_id'] = sId;
    if (source != null) {
      data['source'] = source!.toJson();
    }
    data['title'] = title;
    data['description'] = description;
    data['previousPrice'] = previousPrice;
    data['discount'] = discount;
    data['priceAfterDiscount'] = priceAfterDiscount;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['country'] = country;
    data['location'] = location;
    data['days'] = days;
    data['sourceType'] = sourceType;
    data['promotionCharges'] = promotionCharges;
    if (provider != null) {
      data['provider'] = provider!.toJson();
    }
    data['activeByAdmin'] = activeByAdmin;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['id'] = id;
    return data;
  }
}

class Source {
  String? sId;
  String? title;
  String? id;

  Source({this.sId, this.title, this.id});

  Source.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['id'] = id;
    return data;
  }
}

class PromotionProvider {
  List<String>? country;
  List<String>? states;
  List<String>? cities;
  bool? banned;
  bool? isEmailVerified;
  bool? isPhoneVerified;
  String? role;
  String? secondNumber;
  String? experienceLevel;
  String? about;
  String? status;
  String? approvedBy;
  String? firebaseToken;
  List? emergency;
  String? sId;
  List? car;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? refrence;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? stripeId;
  String? coverImage;
  String? passwordChangedAt;
  String? whatsApp;
  String? ssn;
  List? location;
  List? cars;
  String? id;

  PromotionProvider(
      {this.country,
      this.states,
      this.cities,
      this.banned,
      this.isEmailVerified,
      this.isPhoneVerified,
      this.role,
      this.secondNumber,
      this.experienceLevel,
      this.about,
      this.status,
      this.approvedBy,
      this.firebaseToken,
      this.emergency,
      this.sId,
      this.car,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.refrence,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.stripeId,
      this.coverImage,
      this.passwordChangedAt,
      this.whatsApp,
      this.ssn,
      this.location,
      this.cars,
      this.id});

  PromotionProvider.fromJson(Map<String, dynamic> json) {
    country = json['country'].cast<String>();
    states = json['states'].cast<String>();
    cities = json['cities'].cast<String>();
    banned = json['banned'];
    isEmailVerified = json['isEmailVerified'];
    isPhoneVerified = json['isPhoneVerified'];
    role = json['role'];
    secondNumber = json['secondNumber'];
    experienceLevel = json['experienceLevel'];
    about = json['about'];
    status = json['status'];
    approvedBy = json['approvedBy'];
    firebaseToken = json['firebaseToken'];

    sId = json['_id'];

    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    refrence = json['refrence'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    stripeId = json['stripeId'];
    coverImage = json['coverImage'];
    passwordChangedAt = json['passwordChangedAt'];
    whatsApp = json['whatsApp'];
    ssn = json['ssn'];

    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = country;
    data['states'] = states;
    data['cities'] = cities;
    data['banned'] = banned;
    data['isEmailVerified'] = isEmailVerified;
    data['isPhoneVerified'] = isPhoneVerified;
    data['role'] = role;
    data['secondNumber'] = secondNumber;
    data['experienceLevel'] = experienceLevel;
    data['about'] = about;
    data['status'] = status;
    data['approvedBy'] = approvedBy;
    data['firebaseToken'] = firebaseToken;
    if (emergency != null) {
      data['emergency'] = emergency!.map((v) => v.toJson()).toList();
    }
    data['_id'] = sId;
    if (car != null) {
      data['car'] = car!.map((v) => v.toJson()).toList();
    }
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['refrence'] = refrence;
    data['image'] = image;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['stripeId'] = stripeId;
    data['coverImage'] = coverImage;
    data['passwordChangedAt'] = passwordChangedAt;
    data['whatsApp'] = whatsApp;
    data['ssn'] = ssn;
    if (location != null) {
      data['location'] = location!.map((v) => v.toJson()).toList();
    }
    if (cars != null) {
      data['cars'] = cars!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    return data;
  }
}

class BookingDetails {
  String? time;
  String? date;
  String? note;
  String? address;

  BookingDetails({this.time, this.date, this.note, this.address});

  BookingDetails.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    date = json['date'];
    note = json['note'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['date'] = date;
    data['note'] = note;
    data['address'] = address;
    return data;
  }
}

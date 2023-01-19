class PromotionBookingHistory {
  String? status;
  String? message;
  int? countOnPage;
  int? totalCount;
  List<ProotionResult>? result;

  PromotionBookingHistory(
      {this.status,
        this.message,
        this.countOnPage,
        this.totalCount,
        this.result});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['countOnPage'] = this.countOnPage;
    data['totalCount'] = this.totalCount;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
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

  ProotionResult(
      {this.ssn,
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
        this.updatedAt});

  ProotionResult.fromJson(Map<String, dynamic> json) {
    ssn = json['ssn'];
    totalprice = json['totalprice'];
    status = json['status'];
    sId = json['_id'];
    provider = json['provider'] != null
        ? new Provider.fromJson(json['provider'])
        : null;
    customer = json['customer'] != null
        ? new Provider.fromJson(json['customer'])
        : null;
    paymentMethod = json['paymentMethod'];
    transactionId = json['transactionId'];
    promotion = json['promotion'] != null
        ? new Promotion.fromJson(json['promotion'])
        : null;
    paymentStatus = json['paymentStatus'];
    address = json['address'];
    bookingDetails = json['bookingDetails'] != null
        ? new BookingDetails.fromJson(json['bookingDetails'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ssn'] = this.ssn;
    data['totalprice'] = this.totalprice;
    data['status'] = this.status;
    data['_id'] = this.sId;
    if (this.provider != null) {
      data['provider'] = this.provider!.toJson();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['paymentMethod'] = this.paymentMethod;
    data['transactionId'] = this.transactionId;
    if (this.promotion != null) {
      data['promotion'] = this.promotion!.toJson();
    }
    data['paymentStatus'] = this.paymentStatus;
    data['address'] = this.address;
    if (this.bookingDetails != null) {
      data['bookingDetails'] = this.bookingDetails!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
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

  Provider(
      {this.country,
        this.role,
        this.sId,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.id});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['role'] = this.role;
    data['_id'] = this.sId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['id'] = this.id;
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
    source =
    json['source'] != null ? new Source.fromJson(json['source']) : null;
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
    provider = json['provider'] != null
        ? new Provider.fromJson(json['provider'])
        : null;
    activeByAdmin = json['activeByAdmin'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ssn'] = this.ssn;
    data['promoImg'] = this.promoImg;
    data['deleted'] = this.deleted;
    data['active'] = this.active;
    data['paymentStatus'] = this.paymentStatus;
    data['_id'] = this.sId;
    if (this.source != null) {
      data['source'] = this.source!.toJson();
    }
    data['title'] = this.title;
    data['description'] = this.description;
    data['previousPrice'] = this.previousPrice;
    data['discount'] = this.discount;
    data['priceAfterDiscount'] = this.priceAfterDiscount;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['country'] = this.country;
    data['location'] = this.location;
    data['days'] = this.days;
    data['sourceType'] = this.sourceType;
    data['promotionCharges'] = this.promotionCharges;
    if (this.provider != null) {
      data['provider'] = this.provider!.toJson();
    }
    data['activeByAdmin'] = this.activeByAdmin;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['id'] = this.id;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['id'] = this.id;
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
  List ?cars;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['states'] = this.states;
    data['cities'] = this.cities;
    data['banned'] = this.banned;
    data['isEmailVerified'] = this.isEmailVerified;
    data['isPhoneVerified'] = this.isPhoneVerified;
    data['role'] = this.role;
    data['secondNumber'] = this.secondNumber;
    data['experienceLevel'] = this.experienceLevel;
    data['about'] = this.about;
    data['status'] = this.status;
    data['approvedBy'] = this.approvedBy;
    data['firebaseToken'] = this.firebaseToken;
    if (this.emergency != null) {
      data['emergency'] = this.emergency!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    if (this.car != null) {
      data['car'] = this.car!.map((v) => v.toJson()).toList();
    }
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['refrence'] = this.refrence;
    data['image'] = this.image;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['stripeId'] = this.stripeId;
    data['coverImage'] = this.coverImage;
    data['passwordChangedAt'] = this.passwordChangedAt;
    data['whatsApp'] = this.whatsApp;
    data['ssn'] = this.ssn;
    if (this.location != null) {
      data['location'] = this.location!.map((v) => v.toJson()).toList();
    }
    if (this.cars != null) {
      data['cars'] = this.cars!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['date'] = this.date;
    data['note'] = this.note;
    data['address'] = this.address;
    return data;
  }
}

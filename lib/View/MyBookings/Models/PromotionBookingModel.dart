class PromotionBookingHistory {
  String? status;
  String? message;
  int? countOnPage;
  int? totalCount;
  List<PromotionResult>? result;

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
      result = <PromotionResult>[];
      json['result'].forEach((v) {
        result!.add(new PromotionResult.fromJson(v));
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

class PromotionResult {
  String? ssn;
  num? totalprice;
  String? status;
  String? sId;
  PromotionProvider? provider;
  PromotionProvider? customer;
  String? paymentMethod;
  String? transactionId;
  String? promotion;
  String? paymentStatus;
  String? address;
  PromotionsBookingDetails? bookingDetails;
  String? createdAt;
  String? updatedAt;

  PromotionResult(
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

  PromotionResult.fromJson(Map<String, dynamic> json) {
    ssn = json['ssn'];
    totalprice = json['totalprice'];
    status = json['status'];
    sId = json['_id'];
    provider = json['provider'] != null
        ? new PromotionProvider.fromJson(json['provider'])
        : null;
    customer = json['customer'] != null
        ? new PromotionProvider.fromJson(json['customer'])
        : null;
    paymentMethod = json['paymentMethod'];
    transactionId = json['transactionId'];
    promotion = json['promotion'];
    paymentStatus = json['paymentStatus'];
    address = json['address'];
    bookingDetails = json['bookingDetails'] != null
        ? new PromotionsBookingDetails.fromJson(json['bookingDetails'])
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
    data['promotion'] = this.promotion;
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

class PromotionProvider {
  List<String>? country;
  String? role;
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? id;

  PromotionProvider(
      {this.country,
        this.role,
        this.sId,
        this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.id});

  PromotionProvider.fromJson(Map<String, dynamic> json) {
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

class PromotionsBookingDetails {
  String? time;
  String? date;
  String? note;
  String? address;

  PromotionsBookingDetails({this.time, this.date, this.note, this.address});

  PromotionsBookingDetails.fromJson(Map<String, dynamic> json) {
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

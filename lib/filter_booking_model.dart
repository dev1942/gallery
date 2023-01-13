// To parse this JSON data, do
//
//     final bookingModel = bookingModelFromJson(jsonString);


class BookingModel {
    BookingModel({
        this.bookingDetails,
        this.ssn,
        this.totalprice,
        this.paymentCompleted,
        this.disputeStatus,
        this.status,
        this.rated,
        this.deleted,
        this.id,
        this.provider,
        this.customer,
        this.type,
        this.address,
        this.source,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.estimation,
        this.paymentMethod,
        this.paymentStatus,
        this.transactionId,
    });

    BookingDetails? bookingDetails;
    String? ssn;
    int? totalprice;
    int? paymentCompleted;
    bool? disputeStatus;
    String? status;
    bool? rated;
    bool? deleted;
    String? id;
    Customer? provider;
    Customer? customer;
    String? type;
    String? address;
    Source? source;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    Estimation? estimation;
    String? paymentMethod;
    String? paymentStatus;
    String? transactionId;

    factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        bookingDetails: BookingDetails.fromJson(json["bookingDetails"]),
        ssn: json["ssn"],
        totalprice: json["totalprice"],
        paymentCompleted: json["paymentCompleted"],
        disputeStatus: json["disputeStatus"],
        status: json["status"],
        rated: json["rated"],
        deleted: json["deleted"],
        id: json["_id"],
        provider: Customer.fromJson(json["provider"]),
        customer: Customer.fromJson(json["customer"]),
        type: json["type"],
        address: json["address"],
        source: Source.fromJson(json["source"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        estimation: Estimation.fromJson(json["estimation"]),
        paymentMethod: json["paymentMethod"],
        paymentStatus: json["paymentStatus"],
        transactionId: json["transactionId"],
    );

    Map<String, dynamic> toJson() => {
        "bookingDetails": bookingDetails!.toJson(),
        "ssn": ssn,
        "totalprice": totalprice,
        "paymentCompleted": paymentCompleted,
        "disputeStatus": disputeStatus,
        "status": status,
        "rated": rated,
        "deleted": deleted,
        "_id": id,
        "provider": provider!.toJson(),
        "customer": customer!.toJson(),
        "type": type,
        "address": address,
        "source": source!.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "estimation": estimation!.toJson(),
        "paymentMethod": paymentMethod,
        "paymentStatus": paymentStatus,
        "transactionId": transactionId,
    };
}

class BookingDetails {
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

    String? time;
    List<dynamic>? file;
    List<String?>? image;
    List<String?>? voiceNote;
    List<dynamic>? video;
    DateTime? date;
    String? customerNote;
    Car? car;

    factory BookingDetails.fromJson(Map<String, dynamic> json) => BookingDetails(
        time: json["time"],
        file: json["file"] == null ? [] : List<dynamic>.from(json["file"]!.map((x) => x)),
        image: json["image"] == null ? [] : List<String?>.from(json["image"]!.map((x) => x)),
        voiceNote: json["voiceNote"] == null ? [] : List<String?>.from(json["voiceNote"]!.map((x) => x)),
        video: json["video"] == null ? [] : List<dynamic>.from(json["video"]!.map((x) => x)),
        date: DateTime.parse(json["date"]),
        customerNote: json["customerNote"],
        car: Car.fromJson(json["car"]),
    );

    Map<String, dynamic> toJson() => {
        "time": time,
        "file": file == null ? [] : List<dynamic>.from(file!.map((x) => x)),
        "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
        "voiceNote": voiceNote == null ? [] : List<dynamic>.from(voiceNote!.map((x) => x)),
        "video": video == null ? [] : List<dynamic>.from(video!.map((x) => x)),
        "date": date?.toIso8601String(),
        "customerNote": customerNote,
        "car": car!.toJson(),
    };
}

class Car {
    Car({
        this.id,
        this.brand,
        this.color,
        this.modelYear,
        this.mileage,
        this.carCity,
        this.carCode,
        this.carNumber,
        this.ssn,
    });

    String? id;
    String? brand;
    String? color;
    String? modelYear;
    String? mileage;
    String? carCity;
    String? carCode;
    String? carNumber;
    String? ssn;

    factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: json["_id"],
        brand: json["brand"],
        color: json["color"],
        modelYear: json["modelYear"],
        mileage: json["mileage"],
        carCity: json["carCity"],
        carCode: json["carCode"],
        carNumber: json["carNumber"],
        ssn: json["ssn"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "brand": brand,
        "color": color,
        "modelYear": modelYear,
        "mileage": mileage,
        "carCity": carCity,
        "carCode": carCode,
        "carNumber": carNumber,
        "ssn": ssn,
    };
}

class Customer {
    Customer({
        this.country,
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
        this.car,
        this.ssn,
        this.customerId,
        this.refrence,
        this.coverImage,
        this.passwordChangedAt,
        this.whatsApp,
    });

    List<String?>? country;
    List<String?>? states;
    List<String?>? cities;
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
    List<Emergency?>? emergency;
    String? id;
    String? firstName;
    String? phone;
    String? countryCode;
    String? email;
    String? lastName;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    String? image;
    String? address;
    String? stripeId;
    List<Car?>? cars;
    List<dynamic>? location;
    List<dynamic>? car;
    String? ssn;
    String? customerId;
    String? refrence;
    String? coverImage;
    DateTime? passwordChangedAt;
    String? whatsApp;

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        country: json["country"] == null ? [] : List<String?>.from(json["country"]!.map((x) => x)),
        states: json["states"] == null ? [] : List<String?>.from(json["states"]!.map((x) => x)),
        cities: json["cities"] == null ? [] : List<String?>.from(json["cities"]!.map((x) => x)),
        banned: json["banned"],
        isEmailVerified: json["isEmailVerified"],
        isPhoneVerified: json["isPhoneVerified"],
        role: json["role"],
        secondNumber: json["secondNumber"],
        experienceLevel: json["experienceLevel"],
        about: json["about"],
        status: json["status"],
        approvedBy: json["approvedBy"],
        firebaseToken: json["firebaseToken"],
        emergency: json["emergency"] == null ? [] : List<Emergency?>.from(json["emergency"]!.map((x) => Emergency.fromJson(x))),
        id: json["_id"],
        firstName: json["firstName"],
        phone: json["phone"],
        countryCode: json["countryCode"],
        email: json["email"],
        lastName: json["lastName"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        image: json["image"],
        address: json["address"],
        stripeId: json["stripeId"],
        cars: json["cars"] == null ? [] : List<Car?>.from(json["cars"]!.map((x) => Car.fromJson(x))),
        location: json["location"] == null ? [] : List<dynamic>.from(json["location"]!.map((x) => x)),
        car: json["car"] == null ? [] : List<dynamic>.from(json["car"]!.map((x) => x)),
        ssn: json["ssn"],
        customerId: json["id"],
        refrence: json["refrence"],
        coverImage: json["coverImage"],
        passwordChangedAt: json["passwordChangedAt"],
        whatsApp: json["whatsApp"],
    );

    Map<String, dynamic> toJson() => {
        "country": country == null ? [] : List<dynamic>.from(country!.map((x) => x)),
        "states": states == null ? [] : List<dynamic>.from(states!.map((x) => x)),
        "cities": cities == null ? [] : List<dynamic>.from(cities!.map((x) => x)),
        "banned": banned,
        "isEmailVerified": isEmailVerified,
        "isPhoneVerified": isPhoneVerified,
        "role": role,
        "secondNumber": secondNumber,
        "experienceLevel": experienceLevel,
        "about": about,
        "status": status,
        "approvedBy": approvedBy,
        "firebaseToken": firebaseToken,
        "emergency": emergency == null ? [] : List<dynamic>.from(emergency!.map((x) => x!.toJson())),
        "_id": id,
        "firstName": firstName,
        "phone": phone,
        "countryCode": countryCode,
        "email": email,
        "lastName": lastName,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "image": image,
        "address": address,
        "stripeId": stripeId,
        "cars": cars == null ? [] : List<dynamic>.from(cars!.map((x) => x!.toJson())),
        "location": location == null ? [] : List<dynamic>.from(location!.map((x) => x)),
        "car": car == null ? [] : List<dynamic>.from(car!.map((x) => x)),
        "ssn": ssn,
        "id": customerId,
        "refrence": refrence,
        "coverImage": coverImage,
        "passwordChangedAt": passwordChangedAt,
        "whatsApp": whatsApp,
    };
}

class Emergency {
    Emergency({
        this.emergencyName,
        this.emergencyPhone,
    });

    String? emergencyName;
    String? emergencyPhone;

    factory Emergency.fromJson(Map<String, dynamic> json) => Emergency(
        emergencyName: json["emergencyName"],
        emergencyPhone: json["emergencyPhone"],
    );

    Map<String, dynamic> toJson() => {
        "emergencyName": emergencyName,
        "emergencyPhone": emergencyPhone,
    };
}

class Estimation {
    Estimation({
        this.ssn,
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

    String? ssn;
    List<String?>? estimationImage;
    bool? isOfferCreated;
    String? offerStatus;
    List<Item?>? items;
    int? serviceTax;
    String? invoiceNumber;
    int? subTotal;
    int? grandTotal;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? offerAmount;
    String? offerNote;

    factory Estimation.fromJson(Map<String, dynamic> json) => Estimation(
        ssn: json["ssn"],
        estimationImage: json["estimationImage"] == null ? [] : List<String?>.from(json["estimationImage"]!.map((x) => x)),
        isOfferCreated: json["isOfferCreated"],
        offerStatus: json["offerStatus"],
        items: json["items"] == null ? [] : List<Item?>.from(json["items"]!.map((x) => Item.fromJson(x))),
        serviceTax: json["serviceTax"],
        invoiceNumber: json["invoiceNumber"],
        subTotal: json["subTotal"],
        grandTotal: json["grandTotal"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
        offerAmount: json["offerAmount"],
        offerNote: json["offerNote"],
    );

    Map<String, dynamic> toJson() => {
        "ssn": ssn,
        "estimationImage": estimationImage == null ? [] : List<dynamic>.from(estimationImage!.map((x) => x)),
        "isOfferCreated": isOfferCreated,
        "offerStatus": offerStatus,
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x!.toJson())),
        "serviceTax": serviceTax,
        "invoiceNumber": invoiceNumber,
        "subTotal": subTotal,
        "grandTotal": grandTotal,
        "updatedAt": updatedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "offerAmount": offerAmount,
        "offerNote": offerNote,
    };
}

class Item {
    Item({
        this.title,
        this.description,
        this.quantity,
        this.price,
        this.tax,
        this.amount,
    });

    String? title;
    String? description;
    String? quantity;
    String? price;
    int? tax;
    String? amount;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        title: json["title"],
        description: json["description"],
        quantity: json["quantity"],
        price: json["price"],
        tax: json["tax"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "quantity": quantity,
        "price": price,
        "tax": tax,
        "amount": amount,
    };
}

class Source {
    Source({
        this.ssn,
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
        this.sourceId,
    });

    String? ssn;
    List<String?>? stores;
    List<String?>? image;
    List<String?>? video;
    List<String?>? features;
    bool? deleted;
    bool? active;
    String? id;
    String? category;
    String? subcategory;
    String? title;
    String? description;
    int? price;
    String? provider;
    String? currency;
    String? activeByAdmin;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    String? sourceId;

    factory Source.fromJson(Map<String, dynamic> json) => Source(
        ssn: json["ssn"],
        stores: json["stores"] == null ? [] : List<String?>.from(json["stores"]!.map((x) => x)),
        image: json["image"] == null ? [] : List<String?>.from(json["image"]!.map((x) => x)),
        video: json["video"] == null ? [] : List<String?>.from(json["video"]!.map((x) => x)),
        features: json["features"] == null ? [] : List<String?>.from(json["features"]!.map((x) => x)),
        deleted: json["deleted"],
        active: json["active"],
        id: json["_id"],
        category: json["category"],
        subcategory: json["subcategory"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        provider: json["provider"],
        currency: json["currency"],
        activeByAdmin: json["activeByAdmin"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        sourceId: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "ssn": ssn,
        "stores": stores == null ? [] : List<dynamic>.from(stores!.map((x) => x)),
        "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
        "video": video == null ? [] : List<dynamic>.from(video!.map((x) => x)),
        "features": features == null ? [] : List<dynamic>.from(features!.map((x) => x)),
        "deleted": deleted,
        "active": active,
        "_id": id,
        "category": category,
        "subcategory": subcategory,
        "title": title,
        "description": description,
        "price": price,
        "provider": provider,
        "currency": currency,
        "activeByAdmin": activeByAdmin,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "id": sourceId,
    };
}

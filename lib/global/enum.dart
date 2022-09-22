enum PageType {
  home,
  home2,
  myProfile,
  bookingHistory,
  purchaseHistory,
  notification,
  inbox,
  transactionHistory,
  analytics,
  wallet,
  invite,
  ratings,
  terms,
  cart,
  aboutUs,
  whatsapp,
  estimations,
  logout,
  promotions,
  thankYou,
}

// Req Type
enum ReqType { get, post, put, patch, delete }

// chat Type
enum MsgType { left, right }

// Id Type
enum IdType { mulkia, drivingLicence, emIdFront, emIdBack }

enum RatingType { given, recieved }

enum DateType { past, today, none }

enum ParamType { simple, json }

enum BannerType { homePage, service }

// Show DataOr Loading
enum ShowData { showData, showNoDataFound, showLoading, showError }

// Toad Alert Types
// ignore: camel_case_types
enum TOAST_TYPE { toastInfo, toastSuccess, toastWarning, toastError }

//
enum EstimationStatus {
  pending,
  inProgress,
  complete,
  cancelled,
  submitted,
  all
}

enum CarType { newCar, oldCar }

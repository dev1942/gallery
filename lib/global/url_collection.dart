// ignore_for_file: prefer_const_declarations, non_constant_identifier_names

class RequestBuilder {
  static final String LIVE_URL = "https://developmentapi-app.otobucks.com/v1/";
  //https://developmentapi-app.otobucks.com/v1
  static final String LOCAL_URL = "http://192.168.18.36:4001/v1/auth/";
  //https://api.otobucks.com/v1/auth/customers/login
  static String API_BASE_URL = LIVE_URL;
  static final String API_LOGIN = "auth/customers/login";
  static final String API_CURRENT_USER = "auth/users/currentUser";
  static final String API_UPDATE_USER = "auth/customers/updateMe";
  static final String API_FORGOT_PASSWORD = "auth/customers/forgotPassword";
  static final String API_RESET_PASSWORD = "auth/customers/resetPassword/";
  static final String API_SIGN_UP = "auth/customers/register";
  static final String API_DELETE_Booking = "bookings/bookService";
  static final String API_SEND_EMAIL_VERIFICATION_TOKEN =
      "auth/users/send-email-verification-token";
  static final String API_SEND_PHONE_VERIFICATION_TOKEN =
      "auth/users/send-phone-verification-token";
  static final String API_VERIFY_EMAIL = "auth/users/verify-email/";
  static final String API_VERIFY_PHONE = "auth/users/verify-phone/";
  // Category and Sub Category
  static final String API_GET_CATEGORIES = "categories/getCategories";
  static final String API_GET_SUB_CATEGORIES = "categories/getSubCategories/";
  static final String API_GET_STORES = "stores";
//---------------------My Profile--------------
  static final String API_GET_CAR_LIST= "auth/customers/cars";
  static final String API_ADD_CAR_LIST= "auth/customers/cars";
  static final String API_DELETE_CAR_= "auth/customers/cars/";
  //Promotions
  static final String API_GET_PROMOTIONS = "promotions";
  //notifications
  static final String API_GET_NOTIFICATIONS = "notifications";
  //wallet
  static final String API_GET_WALLET = "auth/customers/dashboard/totalEarnings";
  static final String API_GET_STATISTICS = "/auth/customers/dashboard/statistics";
  //
  static final String API_GET_SERVICES = "services/";
  static final String API_GET_SERVICES_SIMPLE = "services";
  static final String API_CREATE_ESTIMATES = "bookings/bookService/";
  static final String API_GET_ESTIMATES = "bookings/bookService";
  //given rating
  static final String API_GIVEN_BY_CUSTOMER_RATING = "ratings/givenByCustomer/";
  static final String API_GIVEN_BY_PROVIDER_RATING = "ratings/givenByProvider/";
  static final String RATINGS = "ratings/";
  // cancel booking
  static final String API_CANCEL_BOOKING_REQUESTS = "bookings/cancelRequests";
  static final String API_GET_ALL_BOOKINGS = "https://developmentapi-app.otobucks.com/v1/bookings/bookService/";
}

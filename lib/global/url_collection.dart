// ignore_for_file: prefer_const_declarations, non_constant_identifier_names

class RequestBuilder {
  static final String LIVE_URL = "https://api-app.otobucks.com/v1/";
  static final String LOCAL_URL = "https://192.168.111.97:8000/v1/auth/";
  //https://api.otobucks.com/v1/auth/customers/login

  static String API_BASE_URL = LIVE_URL;

  static final String API_LOGIN = "auth/customers/login";
  static final String API_CURRENT_USER = "auth/users/currentUser";
  static final String API_UPDATE_USER = "auth/customers/updateMe";
  static final String API_FORGOT_PASSWORD = "auth/customers/forgotPassword";
  static final String API_RESET_PASSWORD = "auth/customers/resetPassword/";
  static final String API_SIGN_UP = "auth/customers/register";
  static final String API_SEND_EMAIL_VERIFICATION_TOKEN =
      "auth/users/send-email-verification-token";
  static final String API_VERIFY_EMAIL = "auth/users/verify-email/";
  // Category and Sub Category
  static final String API_GET_CATEGORIES = "categories/getCategories";
  static final String API_GET_SUB_CATEGORIES = "categories/getSubCategories/";
  static final String API_GET_STORES = "stores";

  //Promotions
  static final String API_GET_PROMOTIONS = "promotions";

  //notifications
  static final String API_GET_NOTIFICATIONS = "notifications";

  //wallet
  static final String API_GET_WALLET = "auth/customers/dashboard/totalEarnings";

  //
  static final String API_GET_SERVICES = "services/";
  static final String API_GET_SERVICES_SIMPLE = "services";
  static final String API_CREATE_ESTIMATES = "estimates/customer/";
  static final String API_GET_ESTIMATES = "estimates";

  //given rating
  static final String API_GIVEN_BY_CUSTOMER_RATING = "ratings/givenByCustomer/";
  static final String API_GIVEN_BY_PROVIDER_RATING = "ratings/givenByProvider/";

  // cancel booking
  static final String API_CANCEL_BOOKING_REQUESTS = "bookings/cancelRequests";
}

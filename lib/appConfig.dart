import 'package:intl/intl.dart';

class AppConfig {
  // static const Gradient color = [Colors.red,Colors.white] as Gradient;
  static const String DOMAIN = "https://apps.uktextileandrecycling.co.uk";
  static const String PUBLIC = "public";
  static const String BASE_URL = "$DOMAIN/api";
  static const String PUBLIC_BASE_URL = DOMAIN;

  static const String LOGIN = "$BASE_URL/auth/login";
  static const String PROFILE_INFO = "$BASE_URL/profile/"; //get id in this eand point
  static const String ALL_USER = "$BASE_URL/users"; //get id in this eand point
  static const String ALL_USER_LIST = "$BASE_URL/user-list"; //get id in this eand point
  static const String ALL_CAGE = "$BASE_URL/cases"; //get id in this eand point
  static const String FORGET_PASSWORD = "$BASE_URL/reset-pwd";
  static const String CHANGE_PASSWORD = "$BASE_URL/auth/change-password";
  static const String UPDATE_PROFILE = "$BASE_URL/update-info";
  //get id in
  // this eand point
  static const String ALL_SUPPLIER = "$BASE_URL/supplier"; //get id in this eand point
  static const String ALL_MEASURMENTS = "$BASE_URL/measurements"; //get id in this eand point
  static const String ALL_COUSTOMER = "$BASE_URL/customer"; //get id in this eand point
  static const String ALL_TABLE = "$BASE_URL/tables"; //get id in this eand point

  //===== delivery
  static const String DELIVERY_ID = "$BASE_URL/din";
  static const String GET_PRODUCT_CATEGORY = "$BASE_URL/product-category"; //get api
  static const String GET_DELIVERY_TYPE = "$BASE_URL/delivery-type"; //get api
  static const String GRADE = "$BASE_URL/grade"; //get api
  static const String PRODUCTION_LIST = "$BASE_URL/production"; //get api
  static const String PRODUCTION_CREATE = "$BASE_URL/prduction-create"; //get api
  static const String TRANSACTION_BY_PRODUCTION_ID = "$BASE_URL/transaction-by-production/"; //get api
  static const String DELIVERY_IN_TRANSCATION = "$BASE_URL/delivery-in-transaction"; //get api
  static const String TRANSCATION_BY_DELIVERYID = "$BASE_URL/transaction-by-deliveryin/"; //get api
  static const String TRANSCATION_BY_DELIVERYOUT = "$BASE_URL/transaction-by-deliveryout/"; //get api
  static const String SINGLE_TRANSCATION = "$BASE_URL/transaction/"; //get api

  static const String DELIVERY_OUT_CREATE = "$BASE_URL/dout"; //get api
  static const String DELIVERY_OUT_TR = "$BASE_URL/delivery-out-transaction"; //get api

  static const String CLOCK_IN = "$BASE_URL/checkin"; //POST api
  static const String CLOCK_OUT = "$BASE_URL/checkout"; //POST api
  static const String ATTENDANCE_LIST = "$BASE_URL/attendance"; //POST api

  ////data format
  static String dateFormat(inputDate) {
    var inputFormat = DateFormat("dd-MM-yyyy");
    String date = inputFormat.format(inputDate).toString();
    print("data $date");
    return date;
  }
}

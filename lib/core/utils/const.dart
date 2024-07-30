// ignore_for_file: constant_identifier_names

// import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const kCarBox = 'car_box';
// final ZoomDrawerController zoomDrawerController = ZoomDrawerController();
const String baseUrl = "https://soitmed.onclick-eg.com/api/";
const LatLng initialLatLong = LatLng(30.57499500, 31.50368170);
const googleMapsApiKey = "AIzaSyCX3JeW9bpasQrhBXDubyI68AmV-uEhS0o";

const String uploadPath = "https://soitmed.onclick-eg.com/images/";
const String GET_CATEGORY_WITH_SERVICE = "getCategory/with/services";
const String GET_CATEGORIES = "getCategory";
const String GET_SERVICES = "getService";
const String GET_SETTINGS = "getSetting";
const String GET_TERMS = "getTerms";
const String GET_SLIDER = "getSlider";
const String GET_USER_DATA = "user-profile";
const String REGISTER = "register";
const String LOGIN = "login";
const String GET_SERVICE = "fields";
const String LOG_OUT = "logout";
const String CHANGE_PASSWORD = "change/password";
const String DELETE_ACCOUNT = "delete/account";

abstract class Constants {
  static const spaceSmall = 5.0;
  static const spaceMedium = 10.0;
  static const spaceLarge = 15.0;
  static const spaceLarge2 = 20.0;
  static const spaceExtraLarge = 25.0;
}

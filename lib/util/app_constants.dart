/*


import 'package:tkd_app/model/language_model.dart';*/

class AppConstants {

  static String BASE_URL = "http://13.233.64.33:8080/carcheks"; //Production

  static String LOGIN = BASE_URL + "/UserTable/authLogin/";
  static String REGISTRATION = BASE_URL + "/UserTable/UserTable/save";
  static String UPDATE_USER_PROFILE = BASE_URL + "/UserTable/UserTable/update";
  static String DELETE_USER = BASE_URL + "/UserTable/UserTable/";
  static String GET_ALL_USER = BASE_URL + "/UserTable/UserTable/getAll";
  static String SAVE_GARAGE = BASE_URL + "/api/garage/save";
  static String ADD_VEHICLE = BASE_URL + "/Vehicle/Vehicle/save";

  static const String money = '\$';

/*
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';


  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: '', languageName: 'English', countryCode: 'US', languageCode: 'en',isSelected: true),
    LanguageModel(imageUrl: '', languageName: 'हिंदी', countryCode: 'IN', languageCode: 'hi',isSelected: false),
    LanguageModel(imageUrl: '', languageName: 'मराठी', countryCode: 'IN', languageCode: 'mr',isSelected: false),
    LanguageModel(imageUrl: '', languageName: 'ಕನ್ನಡ', countryCode: 'IN', languageCode: 'kn',isSelected: false),
    LanguageModel(imageUrl: '', languageName: 'മലയാളം', countryCode: 'IN', languageCode: 'ml',isSelected: false),
    LanguageModel(imageUrl: '', languageName: 'తెలుగు', countryCode: 'IN', languageCode: 'te',isSelected: false),
    LanguageModel(imageUrl: '', languageName: 'தமிழ்', countryCode: 'IN', languageCode: 'ta',isSelected: false),
  ];
*/
}
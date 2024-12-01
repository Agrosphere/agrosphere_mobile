import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:late_blight/bloc/language_bloc.dart';
import 'package:late_blight/config/config.dart';
import 'package:late_blight/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

String onBoarding = "onboarding";
String accessToken = "accessToken";
String language = "language";
String lccversion = "lccversion";

class YajnaKrishiSharePrefs {
  static Future<SharedPreferences> pref = SharedPreferences.getInstance();

  static Future<bool?> getOnBoarding() async {
    SharedPreferences currentPref = await pref;
    return currentPref.getBool(onBoarding);
  }

  static Future<bool?> setOnBoarding(bool isVisited) async {
    SharedPreferences currentPref = await pref;
    return currentPref.setBool(onBoarding, isVisited);
  }

  static Future<String?> getAccessToken() async {
    SharedPreferences currentPref = await pref;
    return currentPref.getString(accessToken);
  }

  static Future<bool?> logout() async {
    SharedPreferences currentPref = await pref;
    return currentPref.remove(accessToken);
  }

  static Future<bool?> setAccessToken(String token) async {
    SharedPreferences currentPref = await pref;
    return currentPref.setString(accessToken, token);
  }

  static Future<User?> getUser() async {
    SharedPreferences currentPref = await pref;
    var user = currentPref.getString("user");

    if (user != null && user != "null") {
      final currentUser = User.fromJson(jsonDecode(user));
      Config.setAccessToken(currentUser.accessToken);
      return currentUser;
    } else {
      return null;
    }
  }

  static Future<bool> saveCurrentUserLocation(Position postion) async {
    SharedPreferences currentPref = await pref;
    final location = {
      "latitude": postion.latitude,
      "longitude": postion.longitude
    };
    return await currentPref.setString("location", jsonEncode(location));
  }

  static Future<Map<String, dynamic>?> getCurrentUserLocation() async {
    SharedPreferences currentPref = await pref;
    var location = currentPref.getString("location");
    if (location != null) {
      final currentLocation = jsonDecode(location);
      return currentLocation;
    } else {
      return null;
    }
  }

  static Future<bool?> saveUser(User? user) async {
    SharedPreferences currentPref = await pref;
    if (user != null) {
      Config.setAccessToken(user.accessToken);
    } else {
      Config.setAccessToken(null);
    }
    return currentPref.setString("user", jsonEncode(user));
  }

  static Future<bool?> saveLanguage(AppLanguage appLanguage) async {
    SharedPreferences currentPref = await pref;
    return currentPref.setString(language, appLanguage.name);
  }

  static Future<AppLanguage> getLanguage() async {
    SharedPreferences currentPref = await pref;
    var value = currentPref.getString(language);
    AppLanguage lang = AppLanguage.np;
    if (value == "en") {
      lang = AppLanguage.en;
    }
    return lang;
  }

  static Future<bool?> saveModelVersion(String? version) async {
    SharedPreferences currentPref = await pref;
    return currentPref.setString(lccversion, version ?? "null");
  }

  static Future<String?> getmodelVersion() async {
    SharedPreferences currentPref = await pref;
    return currentPref.getString(lccversion);
  }
}

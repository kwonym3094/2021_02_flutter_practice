
import 'dart:async';
import 'dart:core';

import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String sharedPreferenceLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";

  // saving data to sharedPreference

  static Future<void> saveLogIn(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceLoggedInKey, isLoggedIn);
  }

  static Future<void> saveUserName(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserNameKey, username);
  }

  static Future<void> saveUserEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserEmailKey, email);
  }

// getting data from sharedpreferences

  static Future<bool> getLoggdIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferenceLoggedInKey);
  }

  static Future<bool> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferenceUserNameKey);
  }

  static Future<bool> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferenceUserEmailKey);
  }

}
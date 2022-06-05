import 'dart:async';

import 'package:get/get.dart';
import 'package:javizen/Controllers/MainController.dart';
import 'package:javizen/Models/LoginModel.dart';
import 'package:javizen/Screens/Login&RegisterScreen.dart';
import 'package:javizen/bloc/ProfileBloc.dart';

import 'Prefs.dart';

class PrefHelpers {
  static Future<void> setPassword(String password) async {
    await Prefs.set('password', password);
  }

  static Future<String?> getPassword() async {
    return await (Prefs.get('password'));
  }

  static void removePassword() async {
    return await Prefs.clear('password');
  }

  static Future<void> setToken(String token) async {
    await Prefs.set('token', token);
  }

  static Future<String?> getToken() async {
    return await (Prefs.get('token'));
  }

  static void removeToken() async {
    return await Prefs.clear('token');
  }

  static Future<void> setEmail(String email) async {
    await Prefs.set('email', email);
  }

  static Future<String?> getEmail() async {
    return await (Prefs.get('email'));
  }

  static void removeEmail() async {
    return await Prefs.clear('email');
  }




  static void logOut(){
    removeToken();
    removePassword();
    removeEmail();
    getProfileBlocInstance.getProfile(LoginModel());
    Get.find<MainController>().update();
    Get.off(LoginAndRegisterScreen());
  }

}

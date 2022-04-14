import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/apis/auth_api.dart';
import 'package:flutter_cahoi_barbershop/core/services/shared_preferences_service.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/store_secure.dart';
import 'package:flutter_cahoi_barbershop/home_view.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/views/login/forgot_password_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EnterPasswordModel extends ChangeNotifier {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController textEditingController = TextEditingController();
  final _authAPI = locator<AuthAPI>();
  final _storeSecure = locator<StoreSecure>();
  final _prefs = locator<SharedPreferencesService>();
  final formGlobalKey = GlobalKey<FormState>();

  bool isHidePassword = true;
  String currentPassword = '';
  String? messageValidatePassword;
  bool isUppercase = false;
  bool isNumeric = false;
  bool isLength = false;
  bool isAllReady = false;

  changeHidePassword() {
    isHidePassword = !isHidePassword;
    notifyListeners();
  }

  login(String phoneNumber) async {
    if (!isAllReady) {
      return;
    }
    Map<dynamic, dynamic>? response = await _authAPI.loginWithPhoneNumber(
        phoneNumber, currentPassword.trim());

    debugPrint(response.toString());
    if (response == null) {
      //Có lỗi HTTP
      Fluttertoast.showToast(msg: "Connection errors!");
      return;
    } else if (response.values.first == null || response.keys.first == null) {
      //Sai password
      Fluttertoast.showToast(msg: "Wrong password!");
      return;
    } else {
      //Lưu thông tin User vào Store
      await _storeSecure.setUser(jsonEncode(response.keys.first));
      //Lưu thông tin Token vào Store
      await _storeSecure.setToken(jsonEncode(response.values.first));
      //Lưu social
      _prefs.setSocial(TypeSocial.none);

      Navigator.of(scaffoldKey.currentContext!).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomeView(),
          ),
          (route) => false);
    }
  }

  String? validatePassword() {
    RegExp regex =
        RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$');
    if (currentPassword.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(currentPassword)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }

  validateUppercase() {
    RegExp regex = RegExp(r'(?=.*[A-Z])');
    if (!regex.hasMatch(currentPassword)) {
      isUppercase = false;
    } else {
      isUppercase = true;
    }
  }

  validateNumeric() {
    RegExp regex = RegExp(r'(?=.*?[0-9])');
    if (!regex.hasMatch(currentPassword)) {
      isNumeric = false;
    } else {
      isNumeric = true;
    }
  }

  validateLength() {
    RegExp regex = RegExp(r'.{8,}');
    if (!regex.hasMatch(currentPassword)) {
      isLength = false;
    } else {
      isLength = true;
    }
  }

  changeCurrentPassword({String? value}) {
    if (value == null) {
      currentPassword = textEditingController.text.trim();
    } else {
      textEditingController.text = '';
      currentPassword = '';
    }
    validateUppercase();
    validateNumeric();
    validateLength();
    changeAllReady();
    notifyListeners();
  }

  changeAllReady() {
    if (isUppercase && isNumeric && isLength) {
      isAllReady = true;
    } else {
      isAllReady = false;
    }
  }

  forgotPassword() {
    Navigator.of(scaffoldKey.currentContext!).push(MaterialPageRoute(
      builder: (context) => const ForgotPasswordView(),
    ));
  }

  loginWithSMS() {}
}

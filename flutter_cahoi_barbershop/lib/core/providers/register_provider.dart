import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/apis/auth_api.dart';
import 'package:flutter_cahoi_barbershop/core/services/shared_preferences_service.dart';
import 'package:flutter_cahoi_barbershop/home_view.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/store_secure.dart';

class RegisterProvider extends ChangeNotifier {
  final _authAPI = locator<AuthAPI>();
  final _storeSecure = locator<StoreSecure>();
  final _prefs = locator<SharedPreferencesService>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formPassKey = GlobalKey<FormState>();
  final formNameKey = GlobalKey<FormState>();
  final nameEditingController = TextEditingController();
  final passEditingController = TextEditingController();

  bool isHidePassword = true;
  String currentPassword = '';
  String currentName = '';
  String? messageValidatePassword;
  String? messageValidateName;
  bool isUppercase = false;
  bool isNumeric = false;
  bool isLength = false;
  bool isValidatedName = false;
  bool isAllReady = false;

  changeHidePassword() {
    isHidePassword = !isHidePassword;
    notifyListeners();
  }

  register(String phoneNumber) async {
    if (!isAllReady) {
      return;
    }
    Map<dynamic, dynamic>? response = await _authAPI.register(
        phoneNumber, currentName.trim(), currentPassword.trim());

    if (response == null) {
      //Có lỗi HTTP
      debugPrint("Can't connected");
    } else if (response.values.isEmpty && response.keys.isNotEmpty) {
      //Lỗi server
      debugPrint("Lỗi đăng ký!");
    } else {
      //Lưu thông tin User vào Store
      await _storeSecure.setUser(jsonEncode(response.keys.first));
      //Lưu thông tin Token vào Store
      await _storeSecure.setToken(jsonEncode(response.values.first));
      //Lưu social
      _prefs.setSocial(TypeSocial.facebook);

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

  String? validateName() {
    if (currentName.length > 30 || currentName.isEmpty) {
      isValidatedName = false;
      return 'Name is too long';
    } else if (currentName.split(" ").length < 2) {
      isValidatedName = false;
      return 'Name must have at least 2 words';
    } else {
      isValidatedName = true;
      return null;
    }
  }

  changeCurrentPassword({String? value}) {
    if (value == null) {
      currentPassword = passEditingController.text.trim();
    } else {
      passEditingController.text = '';
      currentPassword = '';
    }
    validateUppercase();
    validateNumeric();
    validateLength();
    changeAllReady();
    notifyListeners();
  }

  changeAllReady() {
    if (isUppercase && isNumeric && isLength && isValidatedName) {
      isAllReady = true;
    } else {
      isAllReady = false;
    }
  }

  void changeCurrentName({String? value}) {
    if (value == null) {
      currentName = nameEditingController.text.trim();
    } else {
      nameEditingController.text = '';
      currentName = '';
    }
    validateName();
    changeAllReady();
    notifyListeners();
  }
}

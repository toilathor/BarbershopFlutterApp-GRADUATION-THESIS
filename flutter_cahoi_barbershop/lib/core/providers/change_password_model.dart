import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/apis/auth_api.dart';
import 'package:flutter_cahoi_barbershop/core/providers/base.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';

class ChangePasswordModel extends BaseModel {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final passEditingController = TextEditingController();
  final _authAPI = locator<AuthAPI>();

  bool isHidePassword = true;
  bool isUppercase = false;
  bool isNumeric = false;
  bool isLength = false;
  bool isAllReady = false;
  String currentPassword = '';

  void changeHidePassword() {
    isHidePassword = !isHidePassword;
    notifyListeners();
  }

  void changeCurrentPassword({String? value}) {
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

  void changeAllReady() {
    if (isUppercase && isNumeric && isLength) {
      isAllReady = true;
    } else {
      isAllReady = false;
    }
  }

  changePassword(String phoneNumber) async {
    bool result = await _authAPI.resetPassword(phoneNumber, currentPassword);
    if (result) {
      AwesomeDialog(
        context: scaffoldKey.currentContext!,
        dialogType: DialogType.SUCCES,
        title: 'Successful',
        btnOkOnPress: () {
          Navigator.of(scaffoldKey.currentContext!)
              .popUntil((route) => route.isFirst);
        },
        dismissOnBackKeyPress: false,
        dismissOnTouchOutside: false,
      ).show();
    } else {
      AwesomeDialog(
        context: scaffoldKey.currentContext!,
        dialogType: DialogType.ERROR,
        title: 'Fail',
      ).show();
    }
  }
}

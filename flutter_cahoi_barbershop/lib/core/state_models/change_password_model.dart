// import 'package:flutter/material.dart';
// import 'package:flutter_cahoi_barbershop/core/apis/auth_api.dart';
// import 'package:flutter_cahoi_barbershop/core/state_models/base.dart';
// import 'package:flutter_cahoi_barbershop/service_locator.dart';
//
// class ChangePasswordModel extends BaseModel {
//   final _authAPI = locator<AuthAPI>();
//
//   final passEditingController = TextEditingController();
//
//   bool isHidePassword = true;
//   bool isUppercase = false;
//   bool isNumeric = false;
//   bool isLength = false;
//   bool isAllReady = false;
//   String currentPassword = '';
//
//   void changeCurrentPassword({String? value}) {
//     if (value == null) {
//       currentPassword = passEditingController.text.trim();
//     } else {
//       passEditingController.text = '';
//       currentPassword = '';
//     }
//     validateUppercase();
//     validateNumeric();
//     validateLength();
//     changeAllReady();
//     notifyListeners();
//   }
//
//   String? validatePassword() {
//     RegExp regex =
//         RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$');
//     if (currentPassword.isEmpty) {
//       return 'Please enter password';
//     } else {
//       if (!regex.hasMatch(currentPassword)) {
//         return 'Enter valid password';
//       } else {
//         return null;
//       }
//     }
//   }
//
//   validateUppercase() {
//     RegExp regex = RegExp(r'(?=.*[A-Z])');
//     if (!regex.hasMatch(currentPassword)) {
//       isUppercase = false;
//     } else {
//       isUppercase = true;
//     }
//   }
//
//   validateNumeric() {
//     RegExp regex = RegExp(r'(?=.*?[0-9])');
//     if (!regex.hasMatch(currentPassword)) {
//       isNumeric = false;
//     } else {
//       isNumeric = true;
//     }
//   }
//
//   validateLength() {
//     RegExp regex = RegExp(r'.{8,}');
//     if (!regex.hasMatch(currentPassword)) {
//       isLength = false;
//     } else {
//       isLength = true;
//     }
//   }
//
//   void changeAllReady() {
//     if (isUppercase && isNumeric && isLength) {
//       isAllReady = true;
//     } else {
//       isAllReady = false;
//     }
//   }
// }

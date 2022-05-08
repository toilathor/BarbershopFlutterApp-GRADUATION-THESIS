import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/apis/auth_api.dart';
import 'package:flutter_cahoi_barbershop/core/services/auth_service.dart';
import 'package:flutter_cahoi_barbershop/core/services/shared_preferences_service.dart';
import 'package:flutter_cahoi_barbershop/home_view.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/server_config.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/store_secure.dart';
import 'package:flutter_cahoi_barbershop/ui/views/auth/change_password_view.dart';
import 'package:flutter_cahoi_barbershop/ui/views/auth/enter_pin_view.dart';
import 'package:flutter_cahoi_barbershop/ui/views/auth/register_view.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

class LoginModel extends ChangeNotifier {
  final _authAPI = locator<AuthAPI>();
  final _authService = locator<AuthenticationService>();
  final _storeSecure = locator<StoreSecure>();
  final _prefs = locator<SharedPreferencesService>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _googleAuth = GoogleSignIn();
  GoogleSignInAccount? googleAccount;

  String _verificationId = '';

  Future<bool> checkUserExisted({required String phoneNumber}) async {
    return await _authService.checkUserExist(phoneNumber: phoneNumber);
  }

  sendOTP({required String phoneNumber}) async {
    _authAPI.verifyPhoneNumber(
      phoneNumber:
          PhoneNumber.fromIsoCode(countryCode, phoneNumber).international,
      verificationCompleted: (phoneAuthCredential) =>
          verificationCompleted(phoneAuthCredential, phoneNumber: phoneNumber),
      verificationFailed: (error) => verificationFailed(error),
      codeSent: (verificationId, forceResendingToken) => codeSent(
          verificationId, forceResendingToken,
          phoneNumber: phoneNumber),
      codeAutoRetrievalTimeout: (verificationId) =>
          codeAutoRetrievalTimeout(verificationId),
    );
  }

  verificationCompleted(PhoneAuthCredential phoneAuthCredential,
      {required String phoneNumber}) async {
    // ANDROID ONLY!

    // Sign the user in (or link) with the auto-generated credential
    await _authAPI.firebaseAuth.signInWithCredential(phoneAuthCredential);
    if (_authAPI.firebaseAuth.currentUser != null) {
      Navigator.of(scaffoldKey.currentContext!).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => RegisterView(
              phoneNumber: phoneNumber,
            ),
          ),
          (Route<dynamic> route) => route.isFirst);
    }
  }

  verificationFailed(FirebaseAuthException error) {
    if (error.code == 'invalid-phone-number') {
      Fluttertoast.showToast(msg: 'The provided phone number is not valid.');
    }
    debugPrint(error.toString());
  }

  codeSent(String verificationId, int? forceResendingToken,
      {required String phoneNumber}) {
    _verificationId = verificationId;

    Navigator.of(scaffoldKey.currentContext!).push(
      MaterialPageRoute(
        builder: (context) => EnterPinView(
          phoneNumber: PhoneNumber.fromIsoCode(
            countryCode,
            phoneNumber,
          ).international,
          verificationId: _verificationId,
          typeOTP: TypeOTP.register,
        ),
      ),
    );
  }

  codeAutoRetrievalTimeout(String verificationId) {}

  loginWithGoogle() async {
    googleAccount = await _googleAuth.signIn();
    Map<dynamic, dynamic>? response = await _authAPI.loginWithSocials({
      'name': googleAccount!.displayName.toString(),
      'phone_number': '',
      'email': googleAccount!.email,
      'provider_id': googleAccount!.id,
    }, TypeSocial.google);

    if (response == null) {
      //Có lỗi HTTP
      Fluttertoast.showToast(msg: "Can't connected!");
      return;
    } else if (response.values.first == null || response.keys.first == null) {
      //Sai password
      Fluttertoast.showToast(msg: "Error login with google!");
      return;
    } else {
      //Lưu thông tin User vào Store
      await _storeSecure.setUser(jsonEncode(response.keys.first));
      //Lưu thông tin Token vào Store
      await _storeSecure.setToken(jsonEncode(response.values.first));

      //Lưu social
      _prefs.setSocial(TypeSocial.google);

      Navigator.of(scaffoldKey.currentContext!).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomeView(),
          ),
          (route) => false);
    }
    notifyListeners();
  }

  // loginOutGoogle() async {
  //   debugPrint(googleAccount.toString());
  //   googleAccount = await _googleAuth.signOut();
  //   notifyListeners();
  // }

  loginWithFacebook() async {
    var result = await FacebookAuth.instance.login(loginBehavior: LoginBehavior.webOnly);

    Map? userData;

    if (result.status == LoginStatus.success) {
      final requestData =
          await FacebookAuth.i.getUserData(fields: "id, email, name, picture");
      userData = requestData;
    }

    Map<dynamic, dynamic>? response = await _authAPI.loginWithSocials({
      'name': userData!['name'],
      'phone_number': '',
      'email': userData['email'],
      'provider_id': userData['id'],
    }, TypeSocial.facebook);

    if (response == null) {
      //Có lỗi HTTP
      Fluttertoast.showToast(msg: "Can't connected!");
      return;
    } else if (response.values.first == null || response.keys.first == null) {
      //Sai password
      Fluttertoast.showToast(msg: "Error login with facebook!");
      return;
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
    notifyListeners();
  }

  ///Register
  Future<bool> register(
      {required String phoneNumber,
      required String currentName,
      required String currentPassword}) async {
    Map<dynamic, dynamic>? response = await _authAPI.register(
      phoneNumber,
      currentName.trim(),
      currentPassword.trim(),
    );

    if (response == null) {
      //Có lỗi HTTP
      debugPrint("Can't connected");
      return false;
    } else if (response.values.isEmpty && response.keys.isNotEmpty) {
      //Lỗi server
      debugPrint("Lỗi đăng ký!");
      return false;
    } else {
      //Lưu thông tin User vào Store
      await _storeSecure.setUser(jsonEncode(response.keys.first));
      //Lưu thông tin Token vào Store
      await _storeSecure.setToken(jsonEncode(response.values.first));
      //Lưu social
      _prefs.setSocial(TypeSocial.facebook);
      return true;
    }
  }

  Future<bool> login({
    required String phoneNumber,
    required String currentPassword,
  }) async {
    Map<dynamic, dynamic>? response = await _authAPI.loginWithPhoneNumber(
        phoneNumber, currentPassword.trim());

    if (response == null) {
      //Có lỗi HTTP
      Fluttertoast.showToast(msg: "Connection errors!");
      return false;
    } else if (response.values.first == null || response.keys.first == null) {
      //Sai password
      Fluttertoast.showToast(msg: "Wrong password!");
      return false;
    } else {
      //Lưu thông tin User vào Store
      await _storeSecure.setUser(jsonEncode(response.keys.first));
      //Lưu thông tin Token vào Store
      await _storeSecure.setToken(jsonEncode(response.values.first));
      //Lưu social
      _prefs.setSocial(TypeSocial.none);

      return true;
    }
  }

  sendOTPForgotPassword({required String phoneNumber}) async {
    _authAPI.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) async {
          // ANDROID ONLY!

          // Sign the user in (or link) with the auto-generated credential
          await _authAPI.firebaseAuth.signInWithCredential(phoneAuthCredential);

          Navigator.of(scaffoldKey.currentContext!).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => ChangePasswordView(
                phoneNumber: phoneNumber,
              ),
            ),
            (route) => route.isFirst,
          );
        },
        verificationFailed: (error) {
          debugPrint(error.message);
        },
        codeSent: (verifiId, forceResendingToken) {
          _verificationId = verifiId;
          Navigator.of(scaffoldKey.currentContext!).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => ChangePasswordView(
                phoneNumber: phoneNumber,
              ),
            ),
            (route) => route.isFirst,
          );
          notifyListeners();
        },
        codeAutoRetrievalTimeout: (verificationId) {});
  }

  Future<bool> changePassword({
    required String phoneNumber,
    required String currentPassword,
  }) async {
    return await _authAPI.resetPassword(phoneNumber, currentPassword);
  }
}

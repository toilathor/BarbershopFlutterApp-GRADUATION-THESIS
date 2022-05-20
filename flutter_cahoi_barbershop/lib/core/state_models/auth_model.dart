import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cahoi_barbershop/core/services/auth_service.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/base.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

class AuthModel extends BaseModel {
  final _authService = locator<AuthenticationService>();
  final _googleAuth = GoogleSignIn();

  GoogleSignInAccount? googleAccount;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  int? _resendToken;

  late Timer timer;
  int timeOut = 60;

  Future<bool?> checkUserExisted({required String phoneNumber}) async {
    return await _authService.checkUserExist(phoneNumber: phoneNumber);
  }

  Future<bool> loginWithPhoneNumber({
    required String phoneNumber,
    required String currentPassword,
  }) async {
    return await _authService.loginWithPhoneNumber(
      phoneNumber: phoneNumber,
      password: currentPassword.trim(),
    );
  }

  Future<bool> loginWithFacebook() async {
    var result = await FacebookAuth.instance.login(
      loginBehavior: LoginBehavior.webOnly,
    );

    if (result.status == LoginStatus.success) {
      final requestData =
          await FacebookAuth.i.getUserData(fields: "id, email, name, picture");

      return await _authService.loginWithFacebook(
        name: requestData['name'],
        email: requestData['email'],
        providerId: requestData['id'],
      );
    }

    return false;
  }

  Future<bool> loginWithGoogle() async {
    googleAccount = await _googleAuth.signIn();

    if (googleAccount != null) {
      return await _authService.loginWithGoogle(
        name: googleAccount!.displayName ?? "",
        email: googleAccount!.email,
        providerId: googleAccount!.id,
      );
    }

    return false;
  }

  Future<bool> sendOTPRegister({
    required String phoneNumber,
    Function()? onlyAndroid,
    required Function(String verifyId) gotoVerifyOTP,
  }) async {
    bool sent = false;

    final _formatPhoneNumber =
        PhoneNumber.fromIsoCode(countryCode, phoneNumber).international;

    await firebaseAuth.verifyPhoneNumber(
        phoneNumber: _formatPhoneNumber,
        verificationCompleted: (phoneAuthCredential) {
          // ANDROID ONLY!
          // Sign the user in (or link) with the auto-generated credential
          // await _authAPI.firebaseAuth.signInWithCredential(phoneAuthCredential);
          //
          // if (_authAPI.firebaseAuth.currentUser != null) {
          //   if (onlyAndroid != null) {
          //     onlyAndroid();
          //   }
          //   sent = true;
          // }
        },
        verificationFailed: (error) {
          if (error.code == 'invalid-phone-number') {
            Fluttertoast.showToast(
                msg: 'The provided phone number is not valid.');
          }
          sent = false;
        },
        codeSent: (verificationId, forceResendingToken) {
          _resendToken = forceResendingToken;
          gotoVerifyOTP(verificationId);
        },
        codeAutoRetrievalTimeout: (verificationId) {
          // gotoVerifyOTP(verificationId);
        },
        timeout: const Duration(seconds: 60),
        forceResendingToken: _resendToken);

    return sent;
  }

  Future verifyOTPRegister({
    required String verifyId,
    required String currentPin,
    required Function() gotoRegister,
    required Function(String value) changeMessageValidate,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verifyId, smsCode: currentPin);
      await firebaseAuth.signInWithCredential(credential);

      if (firebaseAuth.currentUser != null) {
        gotoRegister();
      } else {
        changeMessageValidate('*Vui lòng nhập lại ');
      }
    } catch (e) {
      changeMessageValidate('*Vui lòng nhập lại ');
    }
  }

  Future<bool> register({
    required String phoneNumber,
    required String currentName,
    required String currentPassword,
  }) async {
    return await _authService.register(
      phoneNumber: phoneNumber,
      name: currentName.trim(),
      password: currentPassword.trim(),
    );
  }

  Future<bool> loginOutGoogle() async {
    if (await loginOut()) {
      googleAccount = await _googleAuth.signOut();
      return true;
    }
    return false;
  }

  Future<bool> loginOutFacebook() async {
    if (await loginOut()) {
      FacebookAuth.instance.logOut();
      return true;
    }
    return false;
  }

  Future resendOTP() async {}

  verifyPhoneNumber({
    required String phoneNumber,
    required void Function(PhoneAuthCredential phoneAuthCredential)
        verificationCompleted,
    required void Function(FirebaseAuthException error) verificationFailed,
    required void Function(String verificationId, int? forceResendingToken)
        codeSent,
    required void Function(String verificationId) codeAutoRetrievalTimeout,
    Duration timeout = const Duration(seconds: 30),
    int? forceResendingToken,
  }) async {}

  resetFirebaseAuth() {
    firebaseAuth = FirebaseAuth.instance;
  }

  countDown() {
    timeOut = 60;
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (timeOut > 0) {
        timeOut--;
        notifyListeners();
      } else {
        timer.cancel();
        notifyListeners();
      }
    });
  }

  loginOut() async {
    return _authService.logOut();
  }
}

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/apis/auth_api.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/views/login/create_user_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class EnterPinModel extends ChangeNotifier {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  final authAPI = locator<AuthAPI>();

  bool hasError = false;
  late Timer timer;
  int timeOut = 60;
  String? messageValidate;
  String currentPhone = '';
  String currentPin = '';
  String _verificationId = '';
  bool isEnableButtonVerify = false;

  initModel(String phoneNumber, String verificationId) {
    currentPhone = phoneNumber;
    _verificationId = verificationId;
    notifyListeners();
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

  changeCurrentPin() {
    currentPin = textEditingController.text;
    notifyListeners();
  }

  changeHasError() {
    formKey.currentState?.validate();
    // conditions for validating
    if (currentPin.length != 6 || messageValidate != null) {
      errorController
          .add(ErrorAnimationType.shake); // Triggering error shake animation
      textEditingController.text = '';
      hasError = true;
    } else {
      hasError = false;
      Fluttertoast.showToast(msg: "Aye!!");
    }
    notifyListeners();
  }

  changeEnableButtonVerify() {
    if (textEditingController.text.length == 6) {
      isEnableButtonVerify = true;
    } else {
      isEnableButtonVerify = false;
    }
    notifyListeners();
  }

  resendOTP() async {
    authAPI.verifyPhoneNumber(
      phoneNumber:
          PhoneNumber.fromIsoCode(countryCode!, currentPhone).international,
      verificationCompleted: (phoneAuthCredential) =>
          verificationCompleted(phoneAuthCredential),
      verificationFailed: (error) => verificationFailed(error),
      codeSent: (verificationId, forceResendingToken) =>
          codeSent(verificationId, forceResendingToken),
      codeAutoRetrievalTimeout: (verificationId) =>
          codeAutoRetrievalTimeout(verificationId),
    );

    countDown();
  }

  verificationCompleted(PhoneAuthCredential phoneAuthCredential) {
    // ANDROID ONLY!

    // Sign the user in (or link) with the auto-generated credential

    authAPI.firebaseAuth.signInWithCredential(phoneAuthCredential);
    if (authAPI.firebaseAuth.currentUser != null) {
      Navigator.of(scaffoldKey.currentContext!).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const CreateUserView(),
          ),
          (Route<dynamic> route) => false);
    }
  }

  verificationFailed(FirebaseAuthException error) {
    if (error.code == 'invalid-phone-number') {
      Fluttertoast.showToast(msg: 'The provided phone number is not valid.');
    }
    debugPrint(error.toString());
  }

  codeSent(String verificationId, int? forceResendingToken) {
    // Create a PhoneAuthCredential with the code
    _verificationId = verificationId;
  }

  codeAutoRetrievalTimeout(String verificationId) {}

  verifyOTP() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: currentPin);
      await authAPI.firebaseAuth.signInWithCredential(credential);

      if (authAPI.firebaseAuth.currentUser != null) {
        Navigator.of(scaffoldKey.currentContext!).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const CreateUserView(),
            ),
            (Route<dynamic> route) => false);
      } else {
        messageValidate = '*Please fill up all the cells properly';
        changeHasError();
      }
    } catch (e) {
      debugPrint(e.toString());
      messageValidate = '*Please fill up all the cells properly';
      changeHasError();
    }
  }
}

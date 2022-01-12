import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/apis/auth_api.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/views/login/create_user_view.dart';
import 'package:flutter_cahoi_barbershop/ui/views/login/enter_password_view.dart';
import 'package:flutter_cahoi_barbershop/ui/views/login/enter_pin_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

class LoginModel extends ChangeNotifier {
  final _authAPI = locator<AuthAPI>();
  final formGlobalKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  // final FirebaseAuth auth = FirebaseAuth.instance;

  String currentPhone = '';
  String _verificationId = '';
  String? messageValidatePhoneNumber;

  checkUserExisted() async {
    var userExitsted = await _authAPI.checkUserExisis(currentPhone);
    if (userExitsted) {
      Navigator.of(scaffoldKey.currentContext!).push(
        MaterialPageRoute(
          builder: (context) => EnterPasswordView(phoneNumber: currentPhone),
        ),
      );
    } else {
      await sendOTP();
    }
  }

  void changeCurrentPhone(String value) {
    currentPhone = value;
    validatePhoneNumber();
    formGlobalKey.currentState!.validate();
  }

  void validatePhoneNumber() {
    if (PhoneNumber.fromIsoCode(countryCode!, currentPhone).validate()) {
      messageValidatePhoneNumber = null;
    } else if (currentPhone.isEmpty) {
      messageValidatePhoneNumber = "Please enter mobile number";
    } else {
      messageValidatePhoneNumber = "Please enter valid mobile number";
    }
    notifyListeners();
  }

  sendOTP() async {
    _authAPI.verifyPhoneNumber(
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
  }

  verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
    // ANDROID ONLY!

    // Sign the user in (or link) with the auto-generated credential
    await _authAPI.firebaseAuth.signInWithCredential(phoneAuthCredential);
    if (_authAPI.firebaseAuth.currentUser != null) {
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
    _verificationId = verificationId;

    Navigator.of(scaffoldKey.currentContext!).push(
      MaterialPageRoute(
        builder: (context) => EnterPinView(
          phoneNumber: PhoneNumber.fromIsoCode(
            countryCode!,
            currentPhone,
          ).international,
          verificationId: _verificationId,
        ),
      ),
    );
  }

  codeAutoRetrievalTimeout(String verificationId) {}
}

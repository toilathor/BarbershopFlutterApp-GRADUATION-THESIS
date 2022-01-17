import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/apis/auth_api.dart';
import 'package:flutter_cahoi_barbershop/core/services/shared_preferences_service.dart';
import 'package:flutter_cahoi_barbershop/home_view.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/store_secure.dart';
import 'package:flutter_cahoi_barbershop/ui/views/login/enter_password_view.dart';
import 'package:flutter_cahoi_barbershop/ui/views/login/enter_pin_view.dart';
import 'package:flutter_cahoi_barbershop/ui/views/login/register_view.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

class LoginModel extends ChangeNotifier {
  final _authAPI = locator<AuthAPI>();
  final _prefs = locator<SharedPreferencesService>();
  final formGlobalKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController textEditingController = TextEditingController();
  final _googleAuth = GoogleSignIn();
  GoogleSignInAccount? googleAccount;

  String currentPhone = '';
  String _verificationId = '';
  bool isValidatePhoneNumber = false;

  checkUserExisted() async {
    if (!isValidatePhoneNumber) {
      return;
    }
    var userExitsted = await _authAPI.checkUserExisis(
        PhoneNumber.fromIsoCode(countryCode!, textEditingController.text)
            .international);
    debugPrint(PhoneNumber.fromIsoCode(countryCode!, textEditingController.text)
        .international);
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

  void changeCurrentPhone() {
    currentPhone =
        PhoneNumber.fromIsoCode(countryCode!, textEditingController.text.trim())
            .international;
    validatePhoneNumber();
    formGlobalKey.currentState!.validate();
    notifyListeners();
  }

  String? validatePhoneNumber() {
    if (PhoneNumber.fromIsoCode(countryCode!, currentPhone).validate()) {
      isValidatePhoneNumber = true;
      return null;
    } else if (currentPhone.isEmpty) {
      isValidatePhoneNumber = false;
      return "Please enter mobile number";
    } else {
      isValidatePhoneNumber = false;
      return "Please enter valid mobile number";
    }
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
            builder: (context) => RegisterView(
              phoneNumber: currentPhone,
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
          typeOTP: TypeOTP.register,
        ),
      ),
    );
  }

  codeAutoRetrievalTimeout(String verificationId) {}

  loginWithGoogle() async {
    googleAccount = await _googleAuth.signIn();
    Map<String?, String?>? response = await _authAPI.loginWithSocials({
      'name': googleAccount!.displayName.toString(),
      'phone_number': '',
      'email': googleAccount!.email,
      'provider_id': googleAccount!.id,
    }, TypeSocial.google);

    if (response == null) {
      //Có lỗi HTTP
      Fluttertoast.showToast(msg: "Can't connected!");
    } else if (response.values.isEmpty && response.keys.isNotEmpty) {
      //Sai password
      Fluttertoast.showToast(msg: "Error login with google!");
    } else {
      //Lưu thông tin User vào Store
      await StoreSecure.setUser(response.keys.toString());
      //Lưu thông tin Token vào Store
      await StoreSecure.setToken(response.values.toString());

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
    var result = await FacebookAuth.i.login(
        permissions: ["email", "public_profile"],
        loginBehavior: LoginBehavior.webOnly);

    Map? userData;

    if (result.status == LoginStatus.success) {
      final requestData =
          await FacebookAuth.i.getUserData(fields: "id, email, name, picture");
      userData = requestData;
    }

    Map<String?, String?>? response = await _authAPI.loginWithSocials({
      'name': userData!['name'],
      'phone_number': '',
      'email': userData['email'],
      'provider_id': userData['id'],
    }, TypeSocial.facebook);

    if (response == null) {
      //Có lỗi HTTP
      Fluttertoast.showToast(msg: "Can't connected!");
    } else if (response.values.isEmpty && response.keys.isNotEmpty) {
      //Sai password
      Fluttertoast.showToast(msg: "Error login with facebook!");
    } else {
      //Lưu thông tin User vào Store
      await StoreSecure.setUser(response.keys.toString());
      //Lưu thông tin Token vào Store
      await StoreSecure.setToken(response.values.toString());
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
}

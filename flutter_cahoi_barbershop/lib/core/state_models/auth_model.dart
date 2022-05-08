import 'package:flutter_cahoi_barbershop/core/apis/auth_api.dart';
import 'package:flutter_cahoi_barbershop/core/services/auth_service.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/base.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

class AuthModel extends BaseModel {
  final _authAPI = locator<AuthAPI>();
  final _authService = locator<AuthenticationService>();

  final _googleAuth = GoogleSignIn();
  GoogleSignInAccount? googleAccount;

  Future<bool> checkUserExisted({required String phoneNumber}) async {
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

  Future<bool> sendOTPRegister({required String phoneNumber,
    Function()? onlyAndroid,
    required Function(String) gotoVerifyOTP}) async {
    bool sent = false;

    await _authAPI.verifyPhoneNumber(
      phoneNumber:
      PhoneNumber
          .fromIsoCode(countryCode, phoneNumber)
          .international,
      verificationCompleted: (phoneAuthCredential) async {
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
        gotoVerifyOTP(verificationId);
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );

    return sent;
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

  loginOut() async {
    return _authService.logOut();
  }
}

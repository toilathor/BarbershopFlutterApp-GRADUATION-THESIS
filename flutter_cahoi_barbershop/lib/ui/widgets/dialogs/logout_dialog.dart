import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/services/auth_service.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/helper.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/style.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogoutDialog {
  static show(BuildContext context) {
    final _googleAuth = GoogleSignIn();

    AwesomeDialog(
      context: context,
      dialogType: DialogType.QUESTION,
      animType: AnimType.BOTTOMSLIDE,
      title: appLang(context)!.logout,
      desc: appLang(context)!.question_logout,
      descTextStyle: styleDescDialog,
      titleTextStyle: styleTitleDialog,
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        await _googleAuth.signOut();
        await FacebookAuth.i.logOut();
        await locator<AuthenticationService>().logOut();
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/login',
          (route) => false,
        );
      },
    ).show();
  }
}

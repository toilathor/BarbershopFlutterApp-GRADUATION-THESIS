import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/services/auth_service.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';

class LogoutDialog {
  static show(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.QUESTION,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Logout',
      desc: 'Are you sure you want to sign out?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        locator<AuthenticationService>().logOut();
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (route) => false);
      },
    ).show();
  }
}
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class SuccessDialog {
  static show(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      title: "Thành công",
      btnOkOnPress: () {
        Navigator.pop(context);
      },
    ).show();
  }

  static dismiss(BuildContext context) {
    Navigator.pop(context);
  }
}

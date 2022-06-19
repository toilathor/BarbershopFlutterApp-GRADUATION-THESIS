import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/helper.dart';

class FailDialog {
  static show(BuildContext context, {String? title, Function()? btnOkOnPress}) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      desc: title ?? appLang(context)!.has_error,
      btnOkOnPress: btnOkOnPress,
    ).show();
  }

  static dismiss(BuildContext context) {
    Navigator.pop(context);
  }
}

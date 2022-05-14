import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/server_config.dart';

class RouterLogin {
  static navigation(BuildContext context, {required Role role}) {
    switch (role) {
      case Role.none:
      case Role.customer:
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) => false,
        );
        break;
      case Role.manager:
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home-manager',
          (route) => false,
        );
        break;
      case Role.superAdmin:
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home-super-admin',
          (route) => false,
        );
        break;
      case Role.stylist:
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/employee-home',
              (route) => false,
        );
        break;
      default:
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (route) => false,
        );
        break;
    }
  }
}

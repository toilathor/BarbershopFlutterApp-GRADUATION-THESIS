import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/core/apis/api.dart';
import 'package:flutter_cahoi_barbershop/core/models/user.dart';
import 'package:flutter_cahoi_barbershop/core/services/auth_service.dart';
import 'package:flutter_cahoi_barbershop/core/services/booking_service.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/helper.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/router_login.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/server_config.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/store_secure.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  double position = 0;
  double opacity = 0;
  double scale = 0.7;
  Size size = Size.zero;
  final _bookingService = locator<BookingService>();

  @override
  void initState() {
    _bookingService.getAllProduct();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        position = size.width * 0.7;
        opacity = 1;
        scale = 1;
      });
      DateTime now = DateTime.now();
      String? date = await locator<StoreSecure>().getExpiresIn();
      String? token = await locator<StoreSecure>().getToken();
      if (date != null && DateTime.parse(date).isAfter(now) && token != null) {
        logger.d('Login!');

        locator<Api>().setToken(token);

        MUser? user = await locator<AuthenticationService>().getMe();

        Timer(
          const Duration(seconds: 2),
          () {
            if (user != null) {
              Role role = Role.values[user.roles?.first.id ?? 1];

              RouterLogin.navigation(
                context,
                role: role,
              );
            } else {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            }
          },
        );
      } else {
        logger.i('Expires');
        Timer(
          const Duration(seconds: 2),
          () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              "/login",
              (route) => false,
            );
          },
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 700),
              bottom: position,
              width: size.width,
              child: Center(
                child: AnimatedOpacity(
                  opacity: opacity,
                  duration: const Duration(milliseconds: 600),
                  child: AnimatedScale(
                    scale: scale,
                    duration: const Duration(milliseconds: 700),
                    child: Image.asset(
                      'assets/logo-removebg.png',
                    ),
                  ),
                ),
              ),
            ),
            const Positioned(
              bottom: 50,
              width: 100,
              height: 100,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

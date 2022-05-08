import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/home_view.dart';
import 'package:flutter_cahoi_barbershop/ui/views/auth/login_view.dart';
import 'package:flutter_cahoi_barbershop/ui/views/booking/booking_view.dart';

const String initialRoute = "login";

class Router {
  static Map<String, Widget Function(BuildContext)> defineRoute = {
    'home': (BuildContext ctx) => const HomeView(),
    'login': (BuildContext ctx) => const LoginView(),
    'booking': (BuildContext ctx) => const BookingView(),
  };
}

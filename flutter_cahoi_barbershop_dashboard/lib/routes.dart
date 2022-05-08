import 'package:admin/ui/screens/main/main_screen.dart';
import 'package:flutter/material.dart';

const String initialRoute = "login";

class Router {
  static Map<String, Widget Function(BuildContext)> defineRoute = {
    '/': (BuildContext ctx) => MainScreen(),
  };
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cahoi_barbershop/home_screen.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    setupLocator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cá hồi Barbershop',
      theme: ThemeData(
        primaryColor: primaryColor,
        secondaryHeaderColor: secondaryColor,
        backgroundColor: backgroundColor,
        textTheme: const TextTheme(
          headline1: TextStyle(
              color: headerColor1,
              fontSize: 36,
              fontWeight: FontWeight.w700,
              fontFamily: "Classique_Saigon"),
          headline2: TextStyle(
              color: textColorLight2,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              fontFamily: "Classique_Saigon"),
          headline3: TextStyle(
              color: textColorLight1,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              fontFamily: "Classique_Saigon"),
          bodyText1: TextStyle(
              color: primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              fontFamily: "Classique_Saigon"),
          subtitle1: TextStyle(
              color: backgroundColor,
              fontSize: 12,
              fontFamily: "Classique_Saigon"),
          subtitle2: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: "Classique_Saigon"),
        ),
        iconTheme: const IconThemeData(
          size: 32,
          color: backgroundColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          iconTheme: IconThemeData(
            size: 32,
            color: backgroundColor,
          ),
          actionsIconTheme: IconThemeData(
            size: 32,
            color: backgroundColor,
          ),
          centerTitle: true,
          titleTextStyle: TextStyle(
              color: backgroundColor,
              fontSize: 24,
              fontFamily: "Classique_Saigon"),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: acceptColor,
        ),
        cardTheme: const CardTheme(
          elevation: 8,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

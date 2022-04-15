import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/views/auth/login_view_2.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // to hide only status bar & bottom bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  //auto rotate when running the app
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
      debugShowCheckedModeBanner: false,
      // initialRoute: RouterApp.initialRoute,
      // routes: RouterApp.Router.defineRoute,
      theme: ThemeData(
        primaryColor: primaryColor,
        secondaryHeaderColor: secondaryColor,
        backgroundColor: backgroundColor,
        fontFamily: fontLight,
        // textTheme: TextTheme(
        //   headline1: const TextStyle(
        //       color: headerColor1,
        //       fontSize: 36,
        //       fontWeight: FontWeight.w500,
        //       fontFamily: "Jaapokki"),
        //   headline2: const TextStyle(
        //       color: textColorLight2,
        //       fontSize: 24,
        //       fontWeight: FontWeight.w500,
        //       fontFamily: "Jaapokki"),
        //   headline3: const TextStyle(
        //       color: textColorLight1,
        //       fontSize: 18,
        //       fontWeight: FontWeight.w500,
        //       fontFamily: "Jaapokki"),
        //   bodyText1: const TextStyle(
        //       color: primaryColor,
        //       fontSize: 18,
        //       fontWeight: FontWeight.w500,
        //       fontFamily: "Jaapokki"),
        //   bodyText2: const TextStyle(
        //       color: primaryColor,
        //       fontSize: 12,
        //       fontWeight: FontWeight.w500,
        //       fontFamily: "Jaapokki"),
        //   subtitle1: const TextStyle(
        //       color: backgroundColor, fontSize: 12, fontFamily: "Jaapokki"),
        //   subtitle2: TextStyle(
        //       color: primaryColor.withOpacity(0.5),
        //       fontSize: 12,
        //       fontFamily: "Jaapokki"),
        // ),

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
              color: backgroundColor, fontSize: 24, fontFamily: "Jaapokki"),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: acceptColor,
        ),
        cardTheme: const CardTheme(
          elevation: 8,
        ),
        // fontFamily: "Jaapokki",
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(
              width: 2.0,
              color: secondaryColor,
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      ),
      // onGenerateInitialRoutes: RouterApp.Router.generateRoute,
      home: const LoginView2(),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cahoi_barbershop/core/models/user.dart';
import 'package:flutter_cahoi_barbershop/core/services/auth_service.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/ui/router.dart' as router;
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_cahoi_barbershop/ui/views/report_task_view.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // to hide only status bar & bottom bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);

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
    return MultiProvider(
      providers: [
        StreamProvider<MUser>(
          initialData: MUser.initial(),
          create: (context) =>
              locator<AuthenticationService>().userController.stream,
        ),
      ],
      child: MaterialApp(
        title: 'Cá hồi Barbershop',
        debugShowCheckedModeBanner: false,
        initialRoute: router.initialRoute,
        routes: router.Router.defineRoute,
        theme: ThemeData(
          primaryColor: primaryColor,
          secondaryHeaderColor: secondaryColor,
          backgroundColor: backgroundColor,
          fontFamily: fontLight,
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
              fontFamily: "Jaapokki",
            ),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: acceptColor,
          ),
          cardTheme: const CardTheme(
            elevation: 8,
          ),
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
        // home: const ReportTaskView(),
      ),
    );
  }
}

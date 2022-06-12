import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cahoi_barbershop/core/models/user.dart';
import 'package:flutter_cahoi_barbershop/core/services/auth_service.dart';
import 'package:flutter_cahoi_barbershop/core/services/locale_service.dart';
import 'package:flutter_cahoi_barbershop/l10n/l10n.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:flutter_cahoi_barbershop/test_view.dart';
import 'package:flutter_cahoi_barbershop/ui/router.dart' as router;
import 'package:flutter_cahoi_barbershop/ui/utils/colors.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
        StreamProvider<Locale>(
          create: (context) => locator<LocaleService>().localeController.stream,
          initialData: locator<LocaleService>().locale,
        ),
      ],
      child: StreamBuilder<Locale>(
        initialData: locator<LocaleService>().locale,
        stream: locator<LocaleService>().localeResponse,
        builder: (context, snapshot) => MaterialApp(
          title: 'CaHoi Barbershop',
          debugShowCheckedModeBanner: false,
          initialRoute: router.initialRoute,
          routes: router.Router.defineRoute,
          supportedLocales: L10n.all,
          locale: snapshot.data,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
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
                fontFamily: fontBold,
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
          home: const TestView(),
        ),
      ),
    );
  }
}

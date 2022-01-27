import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/home_view.dart';
import 'package:flutter_cahoi_barbershop/ui/views/booking/booking_view.dart';
import 'package:flutter_cahoi_barbershop/ui/views/login/login_view.dart';

const String initialRoute = "login";

class Router {
  static Map<String, Widget Function(BuildContext)> defineRoute = {
    '/': (BuildContext ctx) => const HomeView(),
    'login': (BuildContext ctx) => const LoginView(),
    'booking': (BuildContext ctx) => const BookingView(),
  };

// static generateRoute => (RouteSettings settings) {
//       switch (settings.name) {
//         case '/':
//           return MaterialPageRoute(builder: (_) => const HomeView());
//         case 'login':
//           return MaterialPageRoute(builder: (_) => const LoginView());
//         default:
//           return MaterialPageRoute(
//             builder: (_) => Scaffold(
//               body: Center(
//                 child: Text('No route defined for ${settings.name}'),
//               ),
//             ),
//           );
//       }
//     };
}

import 'package:flutter/material.dart';
import 'package:flutter_cahoi_barbershop/home_view.dart';
import 'package:flutter_cahoi_barbershop/ui/splash_view.dart';
import 'package:flutter_cahoi_barbershop/ui/views/auth/login_view.dart';
import 'package:flutter_cahoi_barbershop/ui/views/booking/booking_view.dart';
import 'package:flutter_cahoi_barbershop/ui/views/history_view.dart';
import 'package:flutter_cahoi_barbershop/ui_employee/employee_home_view.dart';
import 'package:flutter_cahoi_barbershop/ui_employee/report_task_view.dart';
import 'package:flutter_cahoi_barbershop/ui/views/your_story_view.dart';
import 'package:flutter_cahoi_barbershop/ui_admin/home_admin_view.dart';
import 'package:flutter_cahoi_barbershop/ui_admin/views/edit_user_view.dart';

const String initialRoute = "/splash";

class Router {
  static Map<String, Widget Function(BuildContext)> defineRoute = {
    '/splash': (BuildContext ctx) => const SplashView(),
    '/home': (BuildContext ctx) => const HomeView(),
    '/login': (BuildContext ctx) => const LoginView(),
    '/booking': (BuildContext ctx) => const BookingView(),
    '/history': (BuildContext ctx) => const HistoryView(),
    '/your-story': (BuildContext ctx) => const YourStoryView(),

    ///Employee
    '/report-task': (BuildContext ctx) => const ReportTaskView(),
    '/employee-home': (BuildContext ctx) => const EmployeeHomeView(),

    ///admin
    '/home-super-admin': (BuildContext ctx) => const HomeAdminView(),
    '/edit-user': (BuildContext ctx) => const EditUserView()
  };
}

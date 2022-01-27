import 'package:flutter_cahoi_barbershop/core/apis/auth_api.dart';
import 'package:flutter_cahoi_barbershop/core/apis/category_service_api.dart';
import 'package:flutter_cahoi_barbershop/core/apis/db_service_api.dart';
import 'package:flutter_cahoi_barbershop/core/apis/employee_api.dart';
import 'package:flutter_cahoi_barbershop/core/services/geolocator_service.dart';
import 'package:flutter_cahoi_barbershop/core/apis/workplace_api.dart';
import 'package:flutter_cahoi_barbershop/core/services/youtube_service.dart';
import 'package:flutter_cahoi_barbershop/core/providers/booking_provider.dart';
import 'package:flutter_cahoi_barbershop/core/providers/change_password_provider.dart';
import 'package:flutter_cahoi_barbershop/core/providers/discover_provider.dart';
import 'package:flutter_cahoi_barbershop/core/providers/enter_password_provider.dart';
import 'package:flutter_cahoi_barbershop/core/providers/enter_pin_provider.dart';
import 'package:flutter_cahoi_barbershop/core/providers/forgot_password_provider.dart';
import 'package:flutter_cahoi_barbershop/core/providers/home_page_provider.dart';
import 'package:flutter_cahoi_barbershop/core/providers/login_provider.dart';
import 'package:flutter_cahoi_barbershop/core/providers/playlist_youtube_provider.dart';
import 'package:flutter_cahoi_barbershop/core/providers/register_provider.dart';
import 'package:flutter_cahoi_barbershop/core/providers/select_barbershop_provider.dart';
import 'package:flutter_cahoi_barbershop/core/providers/select_service_provider.dart';
import 'package:flutter_cahoi_barbershop/core/services/shared_preferences_service.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/store_secure.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //APIs - Services
  locator.registerLazySingleton(() => AuthAPI());
  locator.registerLazySingleton(() => YoutubeService());
  locator.registerLazySingleton(() => DBServiceAPI());
  locator.registerLazySingleton(() => CategoryServiceAPI());
  locator.registerLazySingleton(() => EmployeeAPI());
  locator.registerLazySingleton(() => GeolocatorService());
  locator.registerLazySingleton(() => WorkplaceAPI());
  locator.registerLazySingleton(() => StoreSecure());
  locator.registerLazySingleton(() => SharedPreferencesService());

  //ViewModels
  locator.registerLazySingleton(() => BookingProvider());
  locator.registerFactory(() => SelectServiceProvider());
  locator.registerFactory(() => SelectBarbershopProvider());
  locator.registerFactory(() => DiscoverProvider());
  locator.registerFactory(() => LoginProvider());
  locator.registerFactory(() => EnterPinProvider());
  locator.registerFactory(() => EnterPasswordProvider());
  locator.registerFactory(() => RegisterProvider());
  locator.registerFactory(() => ForgotPasswordProvider());
  locator.registerFactory(() => ChangePasswordProvider());
  locator.registerFactory(() => HomePageProvider());
  locator.registerFactory(() => PlaylistYoutubeProvider());
}

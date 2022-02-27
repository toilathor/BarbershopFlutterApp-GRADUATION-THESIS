import 'package:flutter_cahoi_barbershop/core/apis/api.dart';
import 'package:flutter_cahoi_barbershop/core/apis/auth_api.dart';
import 'package:flutter_cahoi_barbershop/core/apis/category_service_api.dart';
import 'package:flutter_cahoi_barbershop/core/providers/booking_model.dart';
import 'package:flutter_cahoi_barbershop/core/providers/change_password_model.dart';
import 'package:flutter_cahoi_barbershop/core/providers/discover_model.dart';
import 'package:flutter_cahoi_barbershop/core/providers/enter_password_provider.dart';
import 'package:flutter_cahoi_barbershop/core/providers/enter_pin_provider.dart';
import 'package:flutter_cahoi_barbershop/core/providers/forgot_password_provider.dart';
import 'package:flutter_cahoi_barbershop/core/providers/home_page_provider.dart';
import 'package:flutter_cahoi_barbershop/core/providers/login_provider.dart';
import 'package:flutter_cahoi_barbershop/core/providers/playlist_youtube_provider.dart';
import 'package:flutter_cahoi_barbershop/core/providers/register_provider.dart';
import 'package:flutter_cahoi_barbershop/core/services/booking_service.dart';
import 'package:flutter_cahoi_barbershop/core/services/shared_preferences_service.dart';
import 'package:flutter_cahoi_barbershop/core/services/youtube_service.dart';
import 'package:flutter_cahoi_barbershop/ui/utils/store_secure.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //APIs - Services
  locator.registerLazySingleton(() => AuthAPI());
  locator.registerLazySingleton(() => YoutubeService());
  locator.registerLazySingleton(() => CategoryServiceAPI());
  locator.registerLazySingleton(() => StoreSecure());
  locator.registerLazySingleton(() => SharedPreferencesService());

  //Service
  locator.registerFactory(() => BookingService());

  //Api
  locator.registerLazySingleton(() => Api());

  //ViewModels
  locator.registerFactory(() => BookingModel());
  locator.registerFactory(() => DiscoverModel());
  locator.registerFactory(() => LoginProvider());
  locator.registerFactory(() => EnterPinProvider());
  locator.registerFactory(() => EnterPasswordProvider());
  locator.registerFactory(() => RegisterProvider());
  locator.registerFactory(() => ForgotPasswordProvider());
  locator.registerFactory(() => ChangePasswordModel());
  locator.registerFactory(() => HomePageProvider());
  locator.registerFactory(() => PlaylistYoutubeProvider());
}

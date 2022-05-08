import 'package:flutter_cahoi_barbershop/core/apis/api.dart';
import 'package:flutter_cahoi_barbershop/core/apis/api2.dart';
import 'package:flutter_cahoi_barbershop/core/apis/auth_api.dart';
import 'package:flutter_cahoi_barbershop/core/apis/category_service_api.dart';
import 'package:flutter_cahoi_barbershop/core/services/auth_service.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/auth_model.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/booking_model.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/enter_pin_model.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/home_page_model.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/playlist_youtube_model.dart';
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
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerFactory(() => BookingService());

  //Api
  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton(() => Api2());

  //ViewModels
  locator.registerFactory(() => BookingModel());
  locator.registerFactory(() => AuthModel());
  locator.registerFactory(() => EnterPinModel());
  locator.registerFactory(() => HomePageModel());
  locator.registerFactory(() => PlaylistYoutubeModel());
}

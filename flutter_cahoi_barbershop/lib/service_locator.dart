import 'package:flutter_cahoi_barbershop/core/apis/auth_api.dart';
import 'package:flutter_cahoi_barbershop/core/view_models/booking_model.dart';
import 'package:flutter_cahoi_barbershop/core/view_models/discover_model.dart';
import 'package:flutter_cahoi_barbershop/core/view_models/enter_pin_model.dart';
import 'package:flutter_cahoi_barbershop/core/view_models/login_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //API
  locator.registerLazySingleton(() => AuthAPI());

  //ViewModel
  locator.registerFactory(() => BookingModel());
  locator.registerFactory(() => DiscoverModel());
  locator.registerFactory(() => LoginModel());
  locator.registerFactory(() => EnterPinModel());
}

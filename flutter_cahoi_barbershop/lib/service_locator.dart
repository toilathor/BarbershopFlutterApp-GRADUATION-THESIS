import 'package:flutter_cahoi_barbershop/core/view_models/booking_model.dart';
import 'package:flutter_cahoi_barbershop/core/view_models/discover_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //ViewModel
  locator.registerFactory(() => BookingModel());
  locator.registerFactory(() => DiscoverModel());
}

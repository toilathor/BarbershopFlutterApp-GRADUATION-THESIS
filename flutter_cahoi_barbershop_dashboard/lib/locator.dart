import 'package:admin/core/apis/api.dart';
import 'package:admin/core/services/navigation_service.dart';
import 'package:admin/state_models/menu_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //services
  locator.registerLazySingleton(() => NavigationService());

  // api
  locator.registerLazySingleton(() => Api());

  // state model
  locator.registerFactory(() => MenuModel());
}
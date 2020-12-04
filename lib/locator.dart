import 'package:get_it/get_it.dart';

import 'core/model/homepage_model.dart';
import 'core/services/api_service.dart';
import 'core/services/navigation_service.dart';

GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => ApiService());
  // locator.registerLazySingleton(() => AuthenticationService());
  // locator.registerLazySingleton(() => GeolocationService());
  //
  locator.registerFactory(() => HomePageModel());
}

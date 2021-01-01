import 'package:get_it/get_it.dart';
import 'file:///C:/Users/vinayak/Desktop/movie_base/lib/ui/model/movie_detail_model.dart';
import 'package:movie_base/core/services/sqlite.dart';

import '../ui/model/homepage_model.dart';
import 'services/api_service.dart';
import 'services/navigation_service.dart';

GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => DbConnection());
  locator.registerFactory(() => HomePageModel());
  locator.registerFactory(() => MoreDetailModel());
}

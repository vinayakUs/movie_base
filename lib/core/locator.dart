import 'package:get_it/get_it.dart';
import 'package:movie_base/core/services/sqlite.dart';
import 'package:movie_base/ui/model/more_movie_model.dart';
import 'package:movie_base/ui/model/movie_detail_model.dart';

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
  locator.registerFactory(()=>MoreMovieModel());
}

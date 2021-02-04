import 'package:movie_base/core/constants/app_constants.dart';
import 'package:movie_base/core/locator.dart';
import 'package:movie_base/core/model/base_model.dart';
import 'package:movie_base/core/model/movie_model.dart';
import 'package:movie_base/core/services/api_service.dart';
import 'package:movie_base/core/services/navigation_service.dart';

class HomePageModel extends BaseModel {
  ApiService _apiService = locator<ApiService>();
  NavigationService _navigationService = locator<NavigationService>();

  Future<List<Movie>> getMovieList (String url) async {
     var movies;
    try {
      movies = _apiService.fetchMovieFromUrl(url);
    } catch (e) {
      throw e;
    }
    return movies;
  }

  void navigateToMovieDetail(Movie movieObj) {
    _navigationService.navigateTo(RoutePaths.MovieDetail, argument: movieObj);
  }

  void navigateToMoreMovie({String title, String url}) {
    _navigationService.navigateTo(RoutePaths.MoreMovie, argument: [title, url]);
  }
}

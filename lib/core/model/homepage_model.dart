import 'dart:convert';
import 'package:movie_base/core/constants/app_constants.dart';
import 'package:movie_base/core/model/base_model.dart';
import 'package:movie_base/core/model/movie_model.dart';
import 'package:movie_base/core/services/api_service.dart';
import 'package:movie_base/core/services/navigation_service.dart';
import 'package:movie_base/locator.dart';

class HomePageModel extends BaseModel {
  ApiService _apiService = locator<ApiService>();
  NavigationService _navigationService = locator<NavigationService>();

  Future<List<Movie>> getMovieList(String url) async {
    RegExp reg1 = new RegExp(r'(page=)');
    if (!reg1.hasMatch(url)) {
      url = url + '&page=1';
    }
    print(url);
    var movies;
    try {
      var response = await _apiService.getApiData(url);
      movies = (json.decode(response.body)["results"] as List)
          .map((i) => Movie.fromJson(i))
          .toList();
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

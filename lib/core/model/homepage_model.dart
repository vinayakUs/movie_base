import 'dart:convert';
import 'package:http/http.dart' as https;
import 'package:movie_base/core/constants/app_constants.dart';
import 'package:movie_base/core/model/base_model.dart';
import 'package:movie_base/core/model/movie_model.dart';
import 'package:movie_base/core/services/navigation_service.dart';
import 'package:movie_base/locator.dart';
class HomePageModel extends BaseModel {
  NavigationService _navigationService = locator<NavigationService>();

  Future<List<Movie>> getMovieList() async {
    var url =
        'https://api.themoviedb.org/3/movie/popular?api_key=e779c7981aaf85ea1d97e4bfa667f4a9&language=en-US&page=1';
    var response = await https.post(
      url,
    );
    List<Movie> mov = (json.decode(response.body)["results"] as List)
        .map((i) => Movie.fromJson(i))
        .toList();

    return mov;
  }

  void navigateToMovieDetail(Movie movieObj) {
    _navigationService.navigateTo(RoutePaths.MovieDetail, argument: movieObj);
  }

  void navigateToMoreMovie({String title, String url}) {
    _navigationService.navigateTo(RoutePaths.MoreMovie, argument: [title, url]);
  }
}

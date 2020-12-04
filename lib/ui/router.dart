import 'package:flutter/material.dart';
import 'package:movie_base/core/constants/app_constants.dart';
import 'package:movie_base/core/model/movie_model.dart';
import 'package:movie_base/ui/views/homepage_view.dart';
import 'package:movie_base/ui/views/more_movies_view.dart';
import 'package:movie_base/ui/views/movie_detail_view.dart';

abstract class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.MoreMovie:
        var argument = settings.arguments as List;
        return MaterialPageRoute(
            builder: (_) =>
                MoreMoviesView(title: argument[0], url: argument[1]));
      case RoutePaths.HomePage:
        return MaterialPageRoute(builder: (_) => HomePageView());
      case RoutePaths.MovieDetail:
        Movie movie = settings.arguments as Movie;
        return MaterialPageRoute(
          builder: (_) => MovieDetailsView(
            movieObj: movie,
          ),
        );
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}

class RoutePaths {
  static const String HomePage = 'HomePageView';
  static const String MovieDetail ='MovieDetailView';
  static const String MoreMovie = "MoreMoviesView";
}
const api_key="e779c7981aaf85ea1d97e4bfa667f4a9";



abstract class MovieUrl{
  static const String  baseUrl="https://api.themoviedb.org/3";
  static const String popularMovieUrl = '$baseUrl/movie/popular?api_key=$api_key&language=en-US';
  static const String popularTvUrl = '$baseUrl/tv/popular?api_key=$api_key&language=en-US';
  static const String upcomingMovieUrl = '$baseUrl/movie/upcoming?api_key=$api_key&language=en-US';
}
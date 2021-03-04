import 'package:movie_base/core/constants/app_constants.dart';
import 'package:movie_base/core/error_handler.dart';
import 'package:movie_base/core/locator.dart';
import 'package:movie_base/core/model/base_model.dart';
import 'package:movie_base/core/model/cast_model.dart';
import 'package:movie_base/core/model/movie_model.dart';
import 'dart:convert';
import 'package:movie_base/core/services/api_service.dart';
import 'package:movie_base/core/services/navigation_service.dart';
import 'package:movie_base/ui/model/tvshow_model.dart';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  bool adult;
  String backdropPath;
  dynamic belongsToCollection;
  int budget;
  List<Genre> genres;
  String homepage;
  int id;
  String imdbId;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  List<ProductionCompany> productionCompanies;
  List<ProductionCountry> productionCountries;
  DateTime releaseDate;
  int revenue;
  int runtime;
  List<SpokenLanguage> spokenLanguages;
  String status;
  String tagline;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        belongsToCollection: json["belongs_to_collection"],
        budget: json["budget"],
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        imdbId: json["imdb_id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        productionCompanies: List<ProductionCompany>.from(
            json["production_companies"]
                .map((x) => ProductionCompany.fromJson(x))),
        productionCountries: List<ProductionCountry>.from(
            json["production_countries"]
                .map((x) => ProductionCountry.fromJson(x))),
        releaseDate: DateTime.parse(json["release_date"]),
        revenue: json["revenue"],
        runtime: json["runtime"],
        spokenLanguages: List<SpokenLanguage>.from(
            json["spoken_languages"].map((x) => SpokenLanguage.fromJson(x))),
        status: json["status"],
        tagline: json["tagline"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "belongs_to_collection": belongsToCollection,
        "budget": budget,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage,
        "id": id,
        "imdb_id": imdbId,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "production_companies":
            List<dynamic>.from(productionCompanies.map((x) => x.toJson())),
        "production_countries":
            List<dynamic>.from(productionCountries.map((x) => x.toJson())),
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "revenue": revenue,
        "runtime": runtime,
        "spoken_languages":
            List<dynamic>.from(spokenLanguages.map((x) => x.toJson())),
        "status": status,
        "tagline": tagline,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

class Genre {
  Genre({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class ProductionCompany {
  ProductionCompany({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  int id;
  String logoPath;
  String name;
  String originCountry;

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      ProductionCompany(
        id: json["id"],
        logoPath: json["logo_path"] == null ? null : json["logo_path"],
        name: json["name"],
        originCountry: json["origin_country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "logo_path": logoPath == null ? null : logoPath,
        "name": name,
        "origin_country": originCountry,
      };
}

class ProductionCountry {
  ProductionCountry({
    this.iso31661,
    this.name,
  });

  String iso31661;
  String name;

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      ProductionCountry(
        iso31661: json["iso_3166_1"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "iso_3166_1": iso31661,
        "name": name,
      };
}

class SpokenLanguage {
  SpokenLanguage({
    this.englishName,
    this.iso6391,
    this.name,
  });

  String englishName;
  String iso6391;
  String name;

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
        englishName: json["english_name"],
        iso6391: json["iso_639_1"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "english_name": englishName,
        "iso_639_1": iso6391,
        "name": name,
      };
}

enum Loading { isLoading, error, done }

class MoreDetailModel extends BaseModel {
  ApiService _apiService = locator<ApiService>();
  NavigationService _navigationService = locator<NavigationService>();

  var _movieId;
  get tvId => _movieId;
  set setMovieId(id) {
    _movieId = id;
    notifyListeners();
  }

  Welcome _instance;
  Welcome get instance => _instance;
  set setInstance(instance) {
    _instance = instance;
    notifyListeners();
  }

  InstanceStatus _instanceStatus = new InstanceStatus();
  InstanceStatus get instanceStatus => _instanceStatus;

  Future fetchMovieInstance(id) async {
    try {
      _instanceStatus.status = Status.loading;
      notifyListeners();
      Welcome instance = await _apiService.fetchMovieInstance(id);
      setInstance = instance;
    } on Failure catch (e) {
      _instanceStatus.failure = e;
      print(e.message);
    }
    _instanceStatus.status = Status.done;
    notifyListeners();
  }

  List<Movie> _similarMovies = [];
  List<Movie> _recommended = [];
  List<CastModel> _cast = [];

  List<Movie> get similarMovies => _similarMovies;
  List<CastModel> get cast => _cast;
  List<Movie> get recommended => _recommended;

  

  void onModelReady(id) async {
    setMovieId = id;
    await fetchMovieInstance(id);
    if (_instance != null) {
      getSimilarMovies(id);
      getCastModel(id);
      getRecommendedMovies(id);
    }
  }

  void getSimilarMovies(int id) async {
    var url =
        "https://api.themoviedb.org/3/movie/$id/similar?api_key=$api_key&language=en-US&page=1";
    try {
      var movies = await _apiService.fetchMovieFromUrl(url);
      if (movies.length == 0) {
        throw Exception();
      }
      _similarMovies=movies;
      notifyListeners();
    } catch (e) {
      print("exception getSimilarMovies $e");
      _similarMovies=null;
      notifyListeners();
    }
  }

  void getRecommendedMovies(id) async {
    var url =
        "https://api.themoviedb.org/3/movie/$id/recommendations?api_key=$api_key&language=en-US&page=1";
    try {
      var movies = await _apiService.fetchMovieFromUrl(url);
      if (movies.length == 0) {
        throw Exception();
      }
      _recommended=movies;
      notifyListeners();
    } catch (e) {
      print("exception recommended $e");
      _recommended=null;
      notifyListeners();
    }
  }

  void getCastModel(int id) async {
    var url =
        "https://api.themoviedb.org/3/movie/$id/credits?api_key=$api_key&language=en-US";
    print(url);
    try {
      List<CastModel> cast = await _apiService.fetchMovieCastbyId(_movieId);
      print("cast data is $cast");
      print(cast.length);

      if (cast.length == 0) {
        throw Exception();
      }
      _cast=cast;
      notifyListeners();
    } catch (e) {
       _cast=null;
      print("exception cast $e");
      notifyListeners();
      
    }
  }

  void navigateToMovieDetail(Movie movieObj) {
    _navigationService.navigateAndClose(RoutePaths.MovieDetail,
        argument: movieObj);
  }
}

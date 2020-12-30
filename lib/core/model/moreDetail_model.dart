import 'dart:convert';

import 'package:http/http.dart';
import 'package:movie_base/core/constants/app_constants.dart';
import 'package:movie_base/core/model/MovieDetail_model.dart';
import 'package:movie_base/core/model/base_model.dart';
import 'package:movie_base/core/model/movie_model.dart';
import 'package:movie_base/core/services/api_service.dart';
import 'package:movie_base/locator.dart';

class MoreDetailModel extends BaseModel {
  ApiService _apiService = locator<ApiService>();
  var _url;
  Future<MovieDetailModel> fetchData() async {
    print(_url);
    MovieDetailModel data;
    await _apiService.getApiData(_url).then((response) {
      data = MovieDetailModel.fromJson(json.decode(response.body));
    }).catchError((e) {
      print("error while fetchDataCall $e");
      throw e;
    });
    return data;
  }

  MovieDetailModel _movieObj;

  setMovieObj(data) {
    _movieObj = data;
    notifyListeners();
  }

  void initialize(Movie movieObj) async {
    _url =
        "https://api.themoviedb.org/3/movie/${movieObj.id}?api_key=$api_key&language=en-US";
    try {
      print(_url);
      Response response = await _apiService.getApiData(_url);
      print(response.body);
      // Map<dynamic, dynamic> n = Map<dynamic, dynamic>.from(response.body);
      // // var p = json.decode(response.body).cast<MovieDetailModel>();
      // print(n);

      // print(object)

    } catch (e) {
      print("error at $e");
    }

    // Image im = Image.network(
    //     "https://image.tmdb.org/t/p/original/${response.body[1]}");
    // print(response.body);
  }
}

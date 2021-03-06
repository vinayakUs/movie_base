import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:movie_base/core/constants/app_constants.dart';
import 'package:movie_base/core/error_handler.dart';
import 'package:movie_base/core/model/cast_model.dart';
import 'package:movie_base/core/model/movie_model.dart';
import 'package:movie_base/ui/model/movie_detail_model.dart';
import 'package:movie_base/ui/model/tvshow_model.dart';

import '../../ui/model/tvshow_model.dart';
import '../../ui/model/tvshow_model.dart';
import '../../ui/model/tvshow_model.dart';
import '../constants/app_constants.dart';
import '../constants/app_constants.dart';

class ApiService {
  Future getApiData(String url) async {
    http.Response response = await http.get(url);
    return response;
  }

  Future<List<Movie>> fetchMovieFromUrl(String url) async {
    RegExp reg1 = new RegExp(r'(page=)');
    if (!reg1.hasMatch(url)) {
      url = url + '&page=1';
    }
    var response = await getApiData(url);
    return (json.decode(response.body)["results"] as List)
        .map((i) => Movie.fromJson(i))
        .toList();
  }

  Future<List<CastModel>> fetchMovieCastbyId(String id) async {
    var url =
        "https://api.themoviedb.org/3/movie/$id/credits?api_key=$api_key&language=en-US";

    http.Response response = await getApiData(url);
    print(response.statusCode);
    return (json.decode(response.body)["Cast"] as List)
        .map((i) => CastModel.fromJson(i))
        .toList();
  }

  Future<http.Response> fetfakeApiData(String url) async {
    var a = 'http://lo.com/ds';
    http.Response response = await http.get(a);
    return response;
  }

  Future fetchTvShowInstance(id) async {
    var url = "${MovieUrl.baseUrl}/tv/$id?api_key=$api_key&language=en-US";
    print(url);
    try {
      http.Response response = await getApiData(url);
      if (response.statusCode == 404) {
        throw Failure(message: "404 Error ", type: FailureType.Error404);
      }
      return TvShowInstance.fromJson(json.decode(response.body));
    } on SocketException {
      throw Failure(
          message: "No Internet connection ",
          type: FailureType.SocketException);
    } on HttpException {
      throw Failure(
          message: "Couldn't find the resource ",
          type: FailureType.HttpException);
    } on FormatException {
      throw Failure(
          message: "Bad response format ", type: FailureType.FormatException);
    }
  }

  Future fetchMovieInstance(id) async {
    var url = "${MovieUrl.baseUrl}/movie/$id?api_key=$api_key&language=en-US";
    print(url);
    try {
      http.Response response = await getApiData(url);
      if (response.statusCode == 404) {
        throw Failure(message: "404 Error ", type: FailureType.Error404);
      }
      return Welcome.fromJson(json.decode(response.body));
    } on SocketException {
      throw Failure(
          message: "No Internet connection ",
          type: FailureType.SocketException);
    } on HttpException {
      throw Failure(
          message: "Couldn't find the resource ",
          type: FailureType.HttpException);
    } on FormatException {
      throw Failure(
          message: "Bad response format ", type: FailureType.FormatException);
    }
  }

  Future<EpisodeModel> fetchEpisodesFromId(id, sno) async {
    var url =
        "${MovieUrl.baseUrl}/tv/$id/season/$sno?api_key=$api_key&language=en-US";

    http.Response response = await getApiData(url);
    print(response.statusCode);
    return EpisodeModel.fromJson(json.decode(response.body));
  }

  Future<TvShowModelSr> fetchRecommendedTvShowById(id) async {
    var url =
        "${MovieUrl.baseUrl}tv/$id/recommendations?api_key=$api_key&language=en-US&page=1";
    http.Response res = await getApiData(url);
    return TvShowModelSr.fromJson(json.decode(res.body));
  }

  Future<TvShowModelSr> fetchSimilarTvShowById(id) async {
    var url =
        "${MovieUrl.baseUrl}tv/$id/similar?api_key=$api_key&language=en-US&page=1";
    http.Response res = await getApiData(url);
    return TvShowModelSr.fromJson(json.decode(res.body));
    // print((json.decode(res.body)["results"] as List)
    //     .map((i) => TvShowModelSr.fromJson(i))
    //     .toList());
  }
}

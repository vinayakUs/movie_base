import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:movie_base/core/constants/app_constants.dart';
import 'package:movie_base/core/model/cast_model.dart';
import 'package:movie_base/core/model/movie_model.dart';
import 'package:movie_base/ui/model/tvshow_model.dart';

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

  Future<List<CastModel>> fetchCastModelFromUrl(String url) async {
    var response = await getApiData(url);
    return (json.decode(response.body)["CastModel"] as List)
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
      if(response.statusCode==404){
        throw Failure(
          message: "404 Error ",
          type: FailureType.Error404);
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
}

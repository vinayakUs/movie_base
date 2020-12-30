import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_base/core/constants/app_constants.dart';
import 'package:movie_base/core/model/movie_model.dart';
import 'package:movie_base/core/services/api_service.dart';
import 'package:movie_base/core/services/navigation_service.dart';

import '../../locator.dart';

class ScrollListModel extends ChangeNotifier {
  //Initlize all state var used in model
  String _url;

  Size size;
  void setSize(data) {
    size = size;
    notifyListeners();
  }

  //Initlize model specific var
  ApiService _apiService = locator<ApiService>();
  NavigationService _navigationService = locator<NavigationService>();

  List<Movie> _data = [];
  List<Movie> get getData => _data;
  void setData(data) {
    _data.addAll(data);
    notifyListeners();
  }

  bool _hasmoreData = true;
  bool get hasMore => _hasmoreData;
  void setMore(bool data) {
    _hasmoreData = data;
    notifyListeners();
  }

  bool _error = false;
  bool get hasError => _error;
  void setError(bool data) {
    _error = data;
    notifyListeners();
  }

  int _currentPage = 1;

  handleItemCreated(int index) async {
    var itempos = index + 1;
    bool requestMoreData = itempos % 20 == 0;
    var pageToreq = itempos ~/ 20 + 1;

    if (requestMoreData && pageToreq > _currentPage) {
      print(pageToreq);
      _currentPage = pageToreq;
      try {
        List<Movie> dt = await fetchData(page: pageToreq);

        setData(dt);
      } catch (e) {
        setError(false);
      }
    }
  }

  void onInitialize(String url) async {
    _url = url;
    if (_data.length == 0) {
      try {
        var dt = await fetchData(page: 1);
        setData(dt);
      } catch (e) {
        setError(true);
      }
    }
  }

  Future<List<Movie>> fetchData({page}) async {
    var mUrl = _url + '&page=$page';
    print(mUrl);
    List<Movie> data;
    await _apiService.getApiData(mUrl).then((response) {
      data = (json.decode(response.body)["results"] as List)
          .map((i) => Movie.fromJson(i))
          .toList();
    }).catchError((e) {
      print("error while fetchDataCall $e");
      throw e;
    });
    return data;
  }

  void navigateToDetails(Movie movieObj) {
    _navigationService.navigateTo(RoutePaths.MovieDetail, argument: movieObj);
  }
}

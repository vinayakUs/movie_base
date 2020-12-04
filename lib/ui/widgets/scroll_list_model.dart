import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../core/constants/app_constants.dart';
import '../../core/model/movie_model.dart';
import '../../core/services/api_service.dart';
import '../../core/services/navigation_service.dart';
import '../../locator.dart';

class ScrollListModel extends ChangeNotifier {
  //Initlize all state var used in model
  String _url;

  //Initlize model specific var
  ApiService _apiService = locator<ApiService>();

  List<Movie> _data = [];
  List<Movie> get getData => _data;
  int _currentPage = 1;

  void setData(data) {
    _data.addAll(data);
    notifyListeners();
  }

  void onInitialize(String url) async {
    _url = url;
    if (_data.length == 0) {
      var dt = await fetchData(page: 1);
      setData(dt);
    }
  }

  handleItemCreated(int index) async {
    var itempos = index + 1;
    bool requestMoreData = itempos % 20 == 0;
    var pageToreq = itempos ~/ 20 + 1;

    if (requestMoreData && pageToreq > _currentPage) {
      print(pageToreq);
      _currentPage = pageToreq;
      List<Movie> dt = await fetchData(page: pageToreq);
      setData(dt);
    }
  }

  Future<List<Movie>> fetchData({page}) async {
    var m_url = _url + '&page=$page';

    var response = await _apiService.fetApiData(m_url);
    List<Movie> data = (json.decode(response.body)["results"] as List)
        .map((i) => Movie.fromJson(i))
        .toList();
    return data;
  }

  NavigationService _navigationService = locator<NavigationService>();
  void navigateToDetails(Movie movieObj) {
    print(movieObj.id);
    _navigationService.navigateTo(RoutePaths.MovieDetail, argument: movieObj);
  }
}

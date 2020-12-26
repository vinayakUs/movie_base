import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movie_base/core/services/api_service.dart';
import '../../core/constants/app_constants.dart';
import '../../core/model/movie_model.dart';
import '../../core/services/navigation_service.dart';
import '../../locator.dart';

enum ListViewType { list, grid }
enum ErrorType { network, fetch, noError }

class ScrollListModel extends ChangeNotifier {
  //Initlize all state var used in model
  String _url;

  //Initlize model specific var
  ApiService _apiService = locator<ApiService>();

  //
  ErrorType err = ErrorType.noError;

  List<Movie> _data = [];
  List<Movie> get getData => _data;
  int _currentPage = 1;
  ErrorType get haserror => err;

  void setData(data) {
    _data.addAll(data);
    notifyListeners();
  }

  void onInitialize(String url) async {
    _url = url;
    if (_data.length == 0) {
      try {
        var dt = await fetchData(page: 1);
        setData(dt);
      } on Exception catch (e) {
        err = ErrorType.network;
        notifyListeners();
      }
    }
  }

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
      } on Exception catch (e) {
        err = ErrorType.fetch;
      }
    }
  }

  Future<List<Movie>> fetchData({page}) async {
    var m_url = _url + '&page=$page';
    print(m_url);
    List<Movie> data;
    await _apiService.getApiData(m_url).then((response) {
      data = (json.decode(response.body)["results"] as List)
          .map((i) => Movie.fromJson(i))
          .toList();
    }).catchError((e) {
      print("error msg print at $e");
      throw e;
    });

    return data;
  }

  NavigationService _navigationService = locator<NavigationService>();
  void navigateToDetails(Movie movieObj) {
    print(movieObj.id);
    _navigationService.navigateTo(RoutePaths.MovieDetail, argument: movieObj);
  }
}

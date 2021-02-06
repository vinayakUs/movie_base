import 'dart:convert';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_base/core/constants/app_constants.dart';
import 'package:movie_base/core/locator.dart';
import 'package:movie_base/core/model/base_model.dart';
import 'package:movie_base/core/model/movie_model.dart';
import 'package:movie_base/core/services/api_service.dart';
import 'package:movie_base/core/services/navigation_service.dart';

class MoreMovieModel extends BaseModel {
  final PagingController<int, Movie> _pagingController =
      PagingController(firstPageKey: 1);
  final ApiService _apiService = locator<ApiService>();
  final NavigationService _navigationService=locator<NavigationService>();

  get pagingController => _pagingController;
  get items=>_pagingController.itemList;
   void onModelReady(url) {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey, url);
    });
  }

  bool isLastPage = false;

  Future<void> _fetchPage(int pageKey, url) async {
    
    try {
      final newItems = await fetchData(pageKey, url);
      print(isLastPage);
      if (newItems.length == 0) {
        isLastPage = true;
      }
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
      isLastPage = true;
    }
  }

  Future<List<Movie>> fetchData(key, url) async {
    var mUrl = url + '&page=$key';
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

import 'dart:convert';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_base/core/locator.dart';
import 'package:movie_base/core/model/base_model.dart';
import 'package:movie_base/core/model/movie_model.dart';
import 'package:movie_base/core/services/api_service.dart';

class MoreMovieModel extends BaseModel {
  final PagingController<int, Movie> _pagingController =
      PagingController(firstPageKey: 1);
  final ApiService _apiService = locator<ApiService>();

  get pagingController => _pagingController;
  final _pageSize = 20;

  void onModelReady(url) {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey,
          url);
    });
  }

  Future<void> _fetchPage(int pageKey, url) async {
    try {
      final newItems = await fetchData(pageKey, url);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
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
}

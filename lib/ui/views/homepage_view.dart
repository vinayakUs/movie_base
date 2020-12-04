import 'package:flutter/material.dart';
import 'package:movie_base/core/constants/app_constants.dart';
import 'package:movie_base/core/model/homepage_model.dart';
import 'package:movie_base/ui/widgets/horizontal_list_widget.dart';
import 'package:stacked/stacked.dart';

 class HomePageView extends StatefulWidget {
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomePageModel>.reactive(
        builder: (context, model, child) => SafeArea(
              child: Scaffold(
                  body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Popular",
                  ),
                  HorizontalListWidget(
                    onItemTap: (movie){
                      model.navigateToMovieDetail(movie);
                    },
                    future: model.getMovieList(),
                    onMoreTap: () {
                      model.navigateToMoreMovie(
                          title: "Popular",
                          url:
                              "https://api.themoviedb.org/3/movie/popular?api_key=$api_key&language=en-US");
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "trending",
                  ),
                ],
              )),
            ),
        viewModelBuilder: () => HomePageModel());
  }
}

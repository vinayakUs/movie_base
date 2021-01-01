import 'package:flutter/material.dart';
import 'package:movie_base/core/constants/app_constants.dart';
import 'package:movie_base/ui/model/homepage_model.dart';
import 'package:movie_base/widgets/horizontal_list.dart';
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
                  body: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Popular",
                        ),
                        IconButton(
                            onPressed: () {
                              model.navigateToMoreMovie(
                                  title: "Popular",
                                  url: MovieUrl.popularMovieUrl);
                            },
                            icon: Icon(Icons.arrow_right))
                      ],
                    ),
                    HorizontalListWidget(
                      onItemTap: (movie) {
                        model.navigateToMovieDetail(movie);
                      },
                      future: model.getMovieList(MovieUrl.popularMovieUrl),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Upcomming",
                        ),
                        IconButton(
                            onPressed: () {
                              model.navigateToMoreMovie(
                                  title: "upcomming",
                                  url: MovieUrl.upcomingMovieUrl);
                            },
                            icon: Icon(Icons.arrow_right))
                      ],
                    ),
                    HorizontalListWidget(
                      onItemTap: (movie) {
                        model.navigateToMovieDetail(movie);
                      },
                      future: model.getMovieList(MovieUrl.upcomingMovieUrl),
                    ),
                  ],
                ),
              )),
            ),
        viewModelBuilder: () => HomePageModel());
  }
}

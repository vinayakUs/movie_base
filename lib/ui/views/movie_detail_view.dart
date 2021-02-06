import 'package:flutter/material.dart';
import 'package:movie_base/core/model/cast_model.dart';
import 'package:movie_base/core/model/movie_model.dart';
import 'package:movie_base/ui/model/movie_detail_model.dart';
import 'package:movie_base/widgets/cards/movie_card.dart';
import 'package:stacked/stacked.dart';
import 'package:movie_base/widgets/horizontal_list.dart';

class MovieDetailsView extends StatefulWidget {
  final Movie movieObj;

  const MovieDetailsView({Key key, this.movieObj}) : super(key: key);

  @override
  _MovieDetailsViewState createState() => _MovieDetailsViewState();
}

class _MovieDetailsViewState extends State<MovieDetailsView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MoreDetailModel>.reactive(
      onModelReady: (model) => model.onModelReady(widget.movieObj.id),
      viewModelBuilder: () => MoreDetailModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: model.movieInstance == null
                ? Container(child: Center(child: CircularProgressIndicator()))
                : model.movieInstanceError == true
                    ? Text("error")
                    : Column(
                        children: [
                          Image.network(
                            "https://image.tmdb.org/t/p/original/${model.movieInstance.backdropPath}",
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: Container(
                                  height: 200,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress
                                                  .expectedTotalBytes !=
                                              null
                                          ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes
                                          : null,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          Text(
                            model.movieInstance.title,
                            style: TextStyle(fontSize: 25),
                          ),
                          Text(
                            model.movieInstance.popularity.toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                          Image.network(
                            "https://image.tmdb.org/t/p/w185/${model.movieInstance.posterPath}",
                          ),
                          Wrap(
                              children: model.movieInstance.genres
                                  .map<Widget>((obj) => Container(
                                        child: Text(obj.id.toString()),
                                      ))
                                  .toList()),
                          Text(model.movieInstance.genres.toString()),
                          model.cast == null
                              ? Container()
                              : model.cast.length == 0
                                  ? Container()
                                  : Container(
                                      height: 50,
                                      child:
                                          HorizontalListBuilder<CastModel>.fromData(
                                        data: model.cast,
                                        loadingWidget:
                                            CircularProgressIndicator(),
                                        child: (x) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Container(
                                                color: Colors.grey,
                                                child: Row(
                                                  children: [
                                                    Image.network(
                                                      "http://image.tmdb.org/t/p/w185/${x.profilePath}",
                                                      fit: BoxFit.cover,
                                                      loadingBuilder: (BuildContext
                                                              context,
                                                          Widget child,
                                                          ImageChunkEvent
                                                              loadingProgress) {
                                                        if (loadingProgress ==
                                                            null) return child;
                                                        return Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            value: loadingProgress
                                                                        .expectedTotalBytes !=
                                                                    null
                                                                ? loadingProgress
                                                                        .cumulativeBytesLoaded /
                                                                    loadingProgress
                                                                        .expectedTotalBytes
                                                                : null,
                                                          ),
                                                        );
                                                      },
                                                      errorBuilder:
                                                          (context, obj, e) {
                                                        return Container(
                                                          child:
                                                              Icon(Icons.error),
                                                        );
                                                      },
                                                    ),
                                                    Text(x.name),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                          Text(
                            model.movieInstance.overview,
                          ),
                          model.similarMovies == null
                              ? Container()
                              : model.similarMovies.length == 0
                                  ? Container()
                                  : Container(
                                      height: 200,
                                      child:
                                          HorizontalListBuilder<Movie>.fromData(
                                        data: model.similarMovies,
                                        child: (x) {
                                          return MovieCard(
                                            obj: x,
                                            onItemTap: (x) {
                                              model.navigateToMovieDetail(x);
                                            },
                                            textLabel: true,
                                          );
                                        },
                                        loadingWidget: Center(
                                          child: Container(
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                        errWidget: Text("Text"),
                                      ),
                                    ),
                          model.recommended == null
                              ? Container()
                              : model.recommended.length == 0
                                  ? Container()
                                  : Container(
                                      height: 200,
                                      child:
                                          HorizontalListBuilder<Movie>.fromData(
                                        data: model.recommended,
                                        child: (x) {
                                          return MovieCard(
                                            obj: x,
                                            onItemTap: (x) {
                                              model.navigateToMovieDetail(x);
                                            },
                                            textLabel: true,
                                          );
                                        },
                                        loadingWidget: Center(
                                          child: Container(
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                        errWidget: Text("Text"),
                                      ),
                                    ),
                        ],
                      ),
          ),
        );
        // return Scaffold(
        //   body: SingleChildScrollView(
        //      child: FutureBuilder<Welcome>(
        //       builder: (context, snap) {
        //         if (snap.hasError) {
        //           return Container(
        //             child: Center(child: Text(snap.error.toString())),
        //           );
        //         }
        //         if (snap.connectionState == ConnectionState.active ||
        //             snap.connectionState == ConnectionState.waiting) {
        //           return Container(
        //             child: Center(child: CircularProgressIndicator()),
        //           );
        //         }
        //         return Column(
        //           children: [
        //             Image.network(
        //                 "https://image.tmdb.org/t/p/original/${snap.data.backdropPath}"),
        //             Text(
        //               snap.data.title,
        //               style: TextStyle(fontSize: 25),
        //             ),
        //             Text(
        //               snap.data.popularity.toString(),
        //               style: TextStyle(fontSize: 20),
        //             ),
        //             Image.network(
        //               "https://image.tmdb.org/t/p/w185/${snap.data.posterPath}",
        //             ),
        //             Wrap(
        //                 children: snap.data.genres
        //                     .map<Widget>((obj) => Container(
        //                           child: Text(obj.id.toString()),
        //                         ))
        //                     .toList()),
        //             Text(snap.data.genres.toString()),
        //             model.cast == null
        //                 ? Container()
        //                 : model.cast.length == 0
        //                     ? Container()
        //                     : Container(
        //                         height: 50,
        //                         child: HorizontalListBuilder<Cast>.fromData(
        //                           data: model.cast,
        //                           loadingWidget: CircularProgressIndicator(),
        //                           child: (x) {
        //                             return Padding(
        //                               padding: const EdgeInsets.only(
        //                                   left: 8, right: 8),
        //                               child: ClipRRect(
        //                                 borderRadius: BorderRadius.circular(5),
        //                                 child: Container(
        //                                   color: Colors.grey,
        //                                   child: Row(
        //                                     children: [
        //                                       Image.network(
        //                                         "http://image.tmdb.org/t/p/w185/${x.profilePath}",
        //                                         fit: BoxFit.cover,
        //                                         loadingBuilder:
        //                                             (BuildContext context,
        //                                                 Widget child,
        //                                                 ImageChunkEvent
        //                                                     loadingProgress) {
        //                                           if (loadingProgress == null)
        //                                             return child;
        //                                           return Center(
        //                                             child:
        //                                                 CircularProgressIndicator(
        //                                               value: loadingProgress
        //                                                           .expectedTotalBytes !=
        //                                                       null
        //                                                   ? loadingProgress
        //                                                           .cumulativeBytesLoaded /
        //                                                       loadingProgress
        //                                                           .expectedTotalBytes
        //                                                   : null,
        //                                             ),
        //                                           );
        //                                         },
        //                                         errorBuilder:
        //                                             (context, obj, e) {
        //                                           return Container(
        //                                             child: Icon(Icons.error),
        //                                           );
        //                                         },
        //                                       ),
        //                                       Text(x.name),
        //                                     ],
        //                                   ),
        //                                 ),
        //                               ),
        //                             );
        //                           },
        //                         ),
        //                       ),
        //             Text(
        //               snap.data.overview,
        //             ),
        //             model.similarMovies == null
        //                 ? Container()
        //                 : model.similarMovies.length == 0
        //                     ? Container()
        //                     : Container(
        //                         height: 200,
        //                         child: HorizontalListBuilder<Movie>.fromData(
        //                           data: model.similarMovies,
        //                           child: (x) {
        //                             return MovieCard(
        //                               obj: x,
        //                               onItemTap: (x) {
        //                                 model.navigateToMovieDetail(x);
        //                               },
        //                               textLabel: true,
        //                             );
        //                           },
        //                           loadingWidget: Center(
        //                             child: Container(
        //                               child: CircularProgressIndicator(),
        //                             ),
        //                           ),
        //                           errWidget: Text("Text"),
        //                         ),
        //                       ),
        //             model.recommended == null
        //                 ? Container()
        //                 : model.recommended.length == 0
        //                     ? Container()
        //                     : Container(
        //                         height: 200,
        //                         child: HorizontalListBuilder<Movie>.fromData(
        //                           data: model.recommended,
        //                           child: (x) {
        //                             return MovieCard(
        //                               obj: x,
        //                               onItemTap: (x) {
        //                                 model.navigateToMovieDetail(x);
        //                               },
        //                               textLabel: true,
        //                             );
        //                           },
        //                           loadingWidget: Center(
        //                             child: Container(
        //                               child: CircularProgressIndicator(),
        //                             ),
        //                           ),
        //                           errWidget: Text("Text"),
        //                         ),
        //                       ),
        //           ],
        //         );
        //       },
        //       future: model.initialize(widget.movieObj.id),
        //     ),
        //   ),
        // );
      },
    );
  }
}

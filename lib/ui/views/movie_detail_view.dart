import 'package:flutter/material.dart';
import 'package:movie_base/core/error_handler.dart';
import 'package:movie_base/core/model/cast_model.dart';
import 'package:movie_base/core/model/movie_model.dart';
import 'package:movie_base/ui/error_view/connection_lost.dart';
import 'package:movie_base/ui/error_view/error_404.dart';
import 'package:movie_base/ui/model/movie_detail_model.dart';
import 'package:movie_base/widgets/imagewidget.dart';
import 'package:movie_base/widgets/movie_card.dart';
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
    return Scaffold(
      body: ViewModelBuilder<MoreDetailModel>.reactive(
        viewModelBuilder: () => MoreDetailModel(),
        onModelReady: (model) => model.onModelReady(widget.movieObj.id),
        builder: (context, model, child) {
          if (model.instanceStatus.status == Status.loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (model.instanceStatus.failure != null) {
            if (model.instanceStatus.failure.type ==
                FailureType.SocketException) {
              return ConnectionLostScreen();
            }
            if (model.instanceStatus.failure.type == FailureType.Error404) {
              return Error404();
            }
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                ImageWidget(
                  backdrop: model.instance.backdropPath,
                  loadingHeight: 200.0,
                  quality: "original",
                ),
 
                Text(
                  model.instance.title,
                  style: TextStyle(fontSize: 25),
                ),
                Text(
                  model.instance.popularity.toString(),
                  style: TextStyle(fontSize: 20),
                ),
                Image.network(
                  "https://image.tmdb.org/t/p/w185/${model.instance.posterPath}",
                ),
                Wrap(
                    children: model.instance.genres
                        .map<Widget>((obj) => Container(
                              child: Text(obj.id.toString()),
                            ))
                        .toList()),
                Text(model.instance.genres.toString()),
                // HorizontalListBuilder<>.fromData(),
                model.cast == null
                    ? Container()
                    : model.cast.length == 0
                        ? Container()
                        : Container(
                            height: 50,
                            child: HorizontalListBuilder<CastModel>.fromData(
                              data: model.cast,
                              loadingWidget: CircularProgressIndicator(),
                              child: (x) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Container(
                                      color: Colors.grey,
                                      child: Row(
                                        children: [
                                          Image.network(
                                            "http://image.tmdb.org/t/p/w185/${x.profilePath}",
                                            fit: BoxFit.cover,
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent
                                                        loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
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
                                            errorBuilder: (context, obj, e) {
                                              return Container(
                                                child: Icon(Icons.error),
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
                  model.instance.overview,
                ),
                model.similarMovies == null
                    ? Container()
                    : model.similarMovies.length == 0
                        ? Container()
                        : Container(
                            height: 200,
                            child: HorizontalListBuilder<Movie>.fromData(
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
                            child: HorizontalListBuilder<Movie>.fromData(
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
          );
        },
      ),
    );
  }
}

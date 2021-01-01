import 'package:flutter/material.dart';
import 'package:movie_base/core/model/movie_model.dart';
import 'package:movie_base/ui/model/movie_detail_model.dart';
import 'package:stacked/stacked.dart';

class MovieDetailsView extends StatefulWidget {
  final Movie movieObj;

  const MovieDetailsView({Key key, this.movieObj}) : super(key: key);

  @override
  _MovieDetailsViewState createState() => _MovieDetailsViewState();
}

class _MovieDetailsViewState extends State<MovieDetailsView> {
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return ViewModelBuilder<MoreDetailModel>.nonReactive(
      onModelReady: (model) => model.initialize(widget.movieObj),
      viewModelBuilder: () => MoreDetailModel(),
      builder: (context, model, child) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Flexible(
                    fit: FlexFit.loose,
                    flex: 3,
                    child: Container(
                      child: Image.network(
                        "https://image.tmdb.org/t/p/w500/${widget.movieObj.backdropPath}",
                        filterQuality: FilterQuality.high,
                      ),
                      color: Colors.red,
                    )),
                Flexible(
                    flex: 5,
                    child: Container(
                      color: Colors.green,
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}

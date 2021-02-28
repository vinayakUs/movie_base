import 'package:flutter/material.dart';
import 'package:movie_base/ui/error_view/connection_lost.dart';
import 'package:movie_base/ui/error_view/error_404.dart';
import 'package:movie_base/ui/model/tvshow_model.dart';
import 'package:movie_base/widgets/imagewidget.dart';
import 'package:stacked/stacked.dart';

class TvShowView extends StatefulWidget {
  @override
  _TvShowViewState createState() => _TvShowViewState();
}

class _TvShowViewState extends State<TvShowView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelBuilder<TvShowModel>.reactive(
          onModelReady: (model) => model.onModelReady(1402),
          viewModelBuilder: () => TvShowModel(),
          builder: (context, model, child) {
            if (model.instanceStatus.status == Status.loading) {
              return Center(child: CircularProgressIndicator());
            }
            if (model.instanceStatus.failure != null) {
              if (model.instanceStatus.failure.type ==
                  FailureType.SocketException) {
                return ConnectionLostScreen();
              }
              if (model.instanceStatus.failure.type ==
                  FailureType.Error404) {
                return Error404();
              }
            }
            return Column(
              children: [
                ImageWidget(
                  backdrop: model.instance.backdropPath,
                  quality: "w500",
                ),
                Text(model.instance.name),
                Text(model.instance.homepage),
                Text(model.instance.overview),
                Text(model.instance.voteAverage.toString()),
                Text(model.instance.numberOfSeasons.toString()),
              ],
            );
          }),
    );
  }
}

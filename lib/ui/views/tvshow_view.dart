import 'package:flutter/material.dart';
import 'package:movie_base/core/error_handler.dart';
import 'package:movie_base/core/locator.dart';
import 'package:movie_base/core/services/api_service.dart';
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
      body: SingleChildScrollView(
        child: ViewModelBuilder<TvShowModel>.reactive(
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
                if (model.instanceStatus.failure.type == FailureType.Error404) {
                  return Error404();
                }
              }
              return Column(
                children: [
                  ImageWidget(
                    backdrop: model.instance.backdropPath,
                    quality: "original",
                    loadingHeight: 300.0,
                  ),
                  Text(model.instance.name),
                  Text(model.instance.homepage),
                  Text(model.instance.overview),
                  Text(model.instance.voteAverage.toString()),
                  Text(model.instance.numberOfSeasons.toString()),
                  Container(
                    width: 350,
                    // height: 500,
                    child: EpisodeWidg(
                      sno: model.currentSelectedSeason,
                      tvid: model.tvId,
                      totalSeasons: model.instance.numberOfSeasons,
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}

class EpisodeWidg extends StatefulWidget {
  final sno;
  final tvid;
  final totalSeasons;

  const EpisodeWidg({Key key, this.sno, this.tvid, this.totalSeasons})
      : super(key: key);
  @override
  _EpisodeWidgState createState() => _EpisodeWidgState();
}

class _EpisodeWidgState extends State<EpisodeWidg> {
  int currSno=1;
  ApiService _apiService =locator<ApiService>();
  var _episodeInstance = new Map<int, EpisodeModel>();
  EpisodeModel episodeModel(sno) => _episodeInstance[sno];

  

  Future<EpisodeModel> getEpisodeData(currsno)async{
    if (_episodeInstance[currsno] == null) {
      EpisodeModel model = await _apiService.fetchEpisodesFromId(widget.tvid, currSno);
      _episodeInstance[currSno] = model;
    }
    return _episodeInstance[currsno];
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: widget.totalSeasons,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 4, 0),
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                                              currSno=index+1;
                                            });
                    },
                    child: Container(
                      child: Text("season ${index + 1}"),
                    )),
              );
            },
          ),
        ),
        FutureBuilder<EpisodeModel>(
          future: getEpisodeData(currSno),
          builder: (context,snap){
            return Text(snap.data.episodes[0].name.toString());
          },
        ),
      ],
    );
  }
}

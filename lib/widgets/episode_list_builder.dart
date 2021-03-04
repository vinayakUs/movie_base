import 'package:flutter/material.dart';
import 'package:movie_base/ui/model/tvshow_model.dart';

class EpisodeListBuilder extends StatelessWidget {
  final EpisodeModel episodeModel;

  

  const EpisodeListBuilder({Key key, this.episodeModel}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Text(episodeModel.episodes[index].name);
      },
      itemCount: episodeModel.episodes.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
    );
  }
}

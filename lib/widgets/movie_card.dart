import 'package:flutter/material.dart';
import 'package:movie_base/core/model/movie_model.dart';
import 'package:movie_base/widgets/imagewidget.dart';

class MovieCard extends StatelessWidget {
  final Movie obj;
  final Function(Movie x) onItemTap;
  final bool textLabel;

  MovieCard({this.obj, this.onItemTap, this.textLabel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onItemTap(obj);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.zero,
        width: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Material(
                type: MaterialType.card,
                child: ImageWidget(
                  backdrop: obj.posterPath,
                   quality: "w185",
                ),
 
              ),
            ),
            textLabel
                ? Text(
                    obj.title,
                    softWrap: false,
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

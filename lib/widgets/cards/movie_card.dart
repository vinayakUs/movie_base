import 'package:flutter/material.dart';
import 'package:movie_base/core/model/movie_model.dart';

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
                child: Image.network(
                  "https://image.tmdb.org/t/p/w185/${obj.posterPath}",
                  errorBuilder: (context, child, e) {
                    return Container(
                      child: Center(
                        child: Icon(Icons.error),
                      ),
                    );
                  },
                  fit: BoxFit.fitWidth,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                            : null,
                      ),
                    );
                  },
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

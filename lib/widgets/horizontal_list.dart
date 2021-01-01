import 'package:flutter/material.dart';
import 'package:movie_base/core/model/movie_model.dart';

class HorizontalListWidget extends StatelessWidget {
  final Future future;
  final String url;
  final Function(Movie x) onItemTap;
  final Widget child;

  const HorizontalListWidget(
      {Key key, this.future, this.url, this.onItemTap, this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: FutureBuilder<List<Movie>>(
        future: future,
        builder: (context, snap) {
          print("snap has error ${snap.hasError}");
          print("snap has data ${snap.data}");

          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snap.hasError || snap.data == null) {
            return Container(
              child: Center(
                child: Icon(Icons.error),
              ),
            );
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: snap.data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  onItemTap(snap.data[index]);
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
                            "https://image.tmdb.org/t/p/w185/${snap.data[index].posterPath}",
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
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Text(
                        snap.data[index].title,
                        softWrap: false,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

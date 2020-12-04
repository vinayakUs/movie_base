import 'package:flutter/material.dart';
import 'package:movie_base/core/model/movie_model.dart';

class HorizontalListWidget extends StatefulWidget {
  final Future future;
  final Function(Movie x) onItemTap;
  final Function onMoreTap;
  final Widget child;
  const HorizontalListWidget(
      {Key key, this.future, this.onItemTap, this.onMoreTap, this.child})
      : super(key: key);

  @override
  _HorizontalListWidgetState createState() => _HorizontalListWidgetState();
}

class _HorizontalListWidgetState extends State<HorizontalListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: FutureBuilder<List<Movie>>(
        future: widget.future,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: 20,
            itemBuilder: (context, index) {
              return index == 19
                  ? Center(
                      child: GestureDetector(
                          onTap: () {
                            widget.onMoreTap();
                          },
                          child: SizedBox(
                            width: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey[300]),
                                  height: 50,
                                  width: 50,
                                  child: Icon(
                                    Icons.add,
                                  ),
                                )
                              ],
                            ),
                          )))
                  : GestureDetector(
                      onTap: () {
                        widget.onItemTap(snap.data[index]);
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
                                  fit: BoxFit.fitWidth,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
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

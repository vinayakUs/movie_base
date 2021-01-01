
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_base/core/constants/enums.dart';
import 'package:movie_base/core/model/movie_model.dart';
import 'package:movie_base/widgets/scroll_list_model.dart';
import 'package:stacked/stacked.dart';

class ScrollListView extends StatefulWidget {
  final ListViewType viewType;
  final String url;

  const ScrollListView({Key key, this.viewType, this.url}) : super(key: key);

  @override
  _ScrollListViewState createState() => _ScrollListViewState();
}

class _ScrollListViewState extends State<ScrollListView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ViewModelBuilder<ScrollListModel>.reactive(
      viewModelBuilder: () => ScrollListModel(),
      onModelReady: (model) {
        model.onInitialize(widget.url);
        model.setSize(size);
      },
      builder: (context, model, child) {
        if (model.getData.length == 0) {
          if (model.hasError) {
            return Center(child: Icon(Icons.error));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return widget.viewType == ListViewType.list
            ? ListView.builder(
                itemCount: model.getData.length + 1,
                itemBuilder: (context, index) {
                  if (index < model.getData.length) {
                    return GestureDetector(
                      onTap: () {
                        model.navigateToDetails(model.getData[index]);
                      },
                      child: CustomListItm(
                        index: index,
                        itemCreated: () {
                          model.handleItemCreated(index);
                        },
                        moiveObj: model.getData[index],
                      ),
                    );
                  } else if (model.hasMore && model.hasError) {
                    return Container(
                      child: Icon(Icons.cloud_download),
                    );
                  } else if (model.hasMore) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    );
                  }
                  return ListTile(
                    title: Text("Nothing More to load"),
                  );
                },
              )
            : GridView.builder(
                shrinkWrap: true,
                itemCount: model.getData.length + 1,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: (size.width / size.height)),
                itemBuilder: (context, index) {
                  if (index < model.getData.length) {
                    return GestureDetector(
                      onTap: () {
                        model.navigateToDetails(model.getData[index]);
                      },
                      child: CustomGridItm(
                        index: index,
                        itemCreated: () {
                          model.handleItemCreated(index);
                        },
                        moiveObj: model.getData[index],
                      ),
                    );
                  } else if (model.hasMore && model.hasError) {
                    return Container(
                      child: Icon(Icons.cloud_download),
                    );
                  } else if (model.hasMore) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    );
                  }
                  return ListTile(
                    title: Text("Nothing More to load"),
                  );
                },
              );
      },
    );
  }
}

class CustomGridItm extends StatefulWidget {
  final Movie moiveObj;
  final int index;
  final Function itemCreated;

  const CustomGridItm({Key key, this.moiveObj, this.index, this.itemCreated})
      : super(key: key);

  @override
  _CustomGridItmState createState() => _CustomGridItmState();
}

class _CustomGridItmState extends State<CustomGridItm> {
  @override
  void initState() {
    super.initState();
    if (widget.itemCreated != null) {
      print("item created at index ${widget.index}");
      widget.itemCreated();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          'https://image.tmdb.org/t/p/w185/${widget.moiveObj.posterPath}',
          errorBuilder: (context, e, stack) {
            return Icon(Icons.error);
          },
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
    );
  }
}

class CustomListItm extends StatefulWidget {
  final Movie moiveObj;
  final int index;
  final Function itemCreated;

  const CustomListItm({Key key, this.moiveObj, this.index, this.itemCreated})
      : super(key: key);

  @override
  CustomListItmState createState() => CustomListItmState();
}

class CustomListItmState extends State<CustomListItm> {
  @override
  void initState() {
    super.initState();
    if (widget.itemCreated != null) {
      print("item created at index ${widget.index}");
      widget.itemCreated();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w185/${widget.moiveObj.posterPath}',
                  fit: BoxFit.cover,
                  errorBuilder: (context, e, stack) {
                    return Container(
                        height: 150, child: Center(child: Icon(Icons.error)));
                  },
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;

                    return Center(
                      child: Container(
                        height: 150,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        ),
                      ),
                    );
                  },
                  //
                  // color: Colors.blueAccent,
                ),
              ),
            ),
          ),
          Flexible(
              flex: 5,
              child: Container(
                child: FractionallySizedBox(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(widget.moiveObj.title),
                      RatingBarIndicator(
                          rating: widget.moiveObj.voteAverage / 2,
                          itemSize: 20,
                          itemBuilder: (context, _) {
                            return Icon(Icons.star);
                          })
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movie_base/ui/widgets/scroll_list_model.dart';
import 'package:stacked/stacked.dart';

import '../../core/model/movie_model.dart';

class ScrollListView extends StatefulWidget {
  final ListViewType viewType;
  final String url;

  const ScrollListView({Key key, this.url, this.viewType}) : super(key: key);
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
      },
      builder: (context, model, child) {
        return model.getData.length == 0
            ? model.haserror == ErrorType.network
                ? Icon(Icons.error)
                : Center(
                    child: CircularProgressIndicator(),
                  )
            : widget.viewType == ListViewType.grid
                ? GridView.builder(
                    padding: EdgeInsets.all(3),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 3,
                      childAspectRatio: (size.width / size.height),
                    ),
                    itemCount: model.getData.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          model.navigateToDetails(model.getData[index]);
                        },
                        onLongPress: () {
                          print("long press activated");
                          showModalBottomSheet(
                              context: context,
                              builder: (ctx) {
                                return Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        title: Text("new"),
                                        onTap: () {
                                          print(model.getData[index].id);
                                        },
                                      ),
                                      ListTile(
                                        title: Text("new"),
                                        onTap: () {},
                                      ),
                                      ListTile(
                                        title: Text("new"),
                                        onTap: () {},
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                        child: model.haserror == ErrorType.fetch
                            ? Container(
                                child: CircularProgressIndicator(),
                              )
                            : CustomListGridItm(
                                size: size,
                                index: index,
                                itemCreated: () {
                                  model.handleItemCreated(index);
                                },
                                moiveObj: model.getData[index],
                                onClick: () {},
                              ),
                      );
                    },
                  )
                : ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          model.navigateToDetails(model.getData[index]);
                        },
                        child: CustomListItm(
                          index: index,
                          size: size,
                          moiveObj: model.getData[index],
                          onClick: () {},
                          itemCreated: () {
                            model.handleItemCreated(index);
                          },
                        ),
                      );
                    },
                    itemCount: model.getData.length,
                    scrollDirection: Axis.vertical,
                  );
      },
    );
  }
}

class CustomListItm extends StatefulWidget {
  final Size size;
  final Movie moiveObj;
  final int index;
  final Function itemCreated;
  final Function onClick;

  const CustomListItm(
      {Key key,
      this.moiveObj,
      this.size,
      this.index,
      this.itemCreated,
      this.onClick})
      : super(key: key);
  @override
  _CustomListItmState createState() => _CustomListItmState();
}

class _CustomListItmState extends State<CustomListItm> {
  @override
  void initState() {
    super.initState();

    if (widget.itemCreated != null) {
      widget.itemCreated();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image.network(
            "https://image.tmdb.org/t/p/w185/${widget.moiveObj.posterPath}",
            fit: BoxFit.fitWidth,
            height: widget.size.height / 4,
            errorBuilder: (context, child, e) {
              return Container(
                child: Center(
                  child: Icon(Icons.error),
                ),
              );
            },
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                heightFactor: widget.size.height / 4,
                child: Container(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes
                        : null,
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  widget.moiveObj.title,
                  softWrap: true,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomListGridItm extends StatefulWidget {
  final Movie moiveObj;
  final Size size;
  final int index;
  final Function itemCreated;
  final Function onClick;

  const CustomListGridItm(
      {Key key,
      this.moiveObj,
      this.size,
      this.index,
      this.itemCreated,
      this.onClick})
      : super(key: key);
  @override
  _CustomListGridItmState createState() => _CustomListGridItmState();
}

class _CustomListGridItmState extends State<CustomListGridItm> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Image.network(
            "https://image.tmdb.org/t/p/w185/${widget.moiveObj.posterPath}",
            fit: BoxFit.fitWidth,
            height: widget.size.height / 4,
            errorBuilder: (context, child, e) {
              return Container(
                child: Center(
                  child: Icon(Icons.error),
                ),
              );
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
        Expanded(
          child: Text(
            widget.moiveObj.title,
            softWrap: true,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}

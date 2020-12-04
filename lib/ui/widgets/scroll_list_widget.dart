import 'package:flutter/material.dart';
import 'package:movie_base/ui/widgets/scroll_list_model.dart';
import 'package:stacked/stacked.dart';

import '../../core/model/movie_model.dart';


class ScrollListView extends StatefulWidget {
  final String url;

  const ScrollListView({Key key, this.url}) : super(key: key);
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
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : GridView.builder(
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
                        onTap: (){
                          model.navigateToDetails(model.getData[index]);
                        },
                                              child: CustomListItm(
                          index: index,
                          itemCreated: (){model.handleItemCreated(index);},
                          moiveObj: model.getData[index],
                          onClick: (){},

                        ),
                      );
                    },
                  );
      },
    );
  }
}
class CustomListItm extends StatefulWidget {
  final Movie moiveObj;
  final int index;
  final Function itemCreated;
  final Function onClick;

  const CustomListItm({Key key, this.moiveObj, this.index, this.itemCreated, this.onClick})
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Image.network(
            "https://image.tmdb.org/t/p/w185/${widget.moiveObj.posterPath}",
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
        Text(
          widget.moiveObj.title,
          softWrap: true,
          maxLines: 2,
        ),
      ],
    );
  }
}

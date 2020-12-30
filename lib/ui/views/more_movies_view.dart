import 'package:flutter/material.dart';
import 'package:movie_base/core/constants/enums.dart';
import 'package:movie_base/ui/widgets/scroll_list_widget.dart';

class MoreMoviesView extends StatefulWidget {
  final String title;
  final String url;

  const MoreMoviesView({Key key, this.title, this.url}) : super(key: key);
  @override
  _MoreMoviesViewState createState() => _MoreMoviesViewState();
}

class _MoreMoviesViewState extends State<MoreMoviesView> {
  ListViewType type = ListViewType.grid;
  setType(var data) {
    setState(() {
      type = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          type == ListViewType.grid
              ? GestureDetector(
                  onTap: () {
                    setType(ListViewType.list);
                  },
                  child: Icon(Icons.list))
              : GestureDetector(
                  onTap: () {
                    setType(ListViewType.grid);
                  },
                  child: Icon(Icons.grid_view)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ScrollListView(
              viewType: type,
              url: widget.url,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movie_base/ui/widgets/scroll_list_widget.dart';

class MoreMoviesView extends StatefulWidget {
  final String title;
  final String url;

  const MoreMoviesView({Key key, this.title, this.url}) : super(key: key);
  @override
  _MoreMoviesViewState createState() => _MoreMoviesViewState();
}

class _MoreMoviesViewState extends State<MoreMoviesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ScrollListView(
              url:
                  widget.url,
            ),
          ),
        ],
      ),
    );
  }
}

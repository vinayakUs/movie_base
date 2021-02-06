import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_base/core/constants/enums.dart';
import 'package:movie_base/core/model/movie_model.dart';
import 'package:movie_base/ui/model/more_movie_model.dart';
import 'package:movie_base/widgets/scroll_list.dart';
import 'package:stacked/stacked.dart';

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
    return ViewModelBuilder<MoreMovieModel>.reactive(
      viewModelBuilder: () => MoreMovieModel(),
      onModelReady: (model) => model.onModelReady(widget.url),
      builder: (context, model, child) {
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
          body: RefreshIndicator(
              onRefresh: () =>
                  Future.sync(() => model.pagingController.refresh()),
              child: PagedListView<int, Movie>.separated(
                pagingController: model.pagingController,
                builderDelegate: PagedChildBuilderDelegate<Movie>(
                    itemBuilder: (context, item, index) {
                  return GestureDetector(
                    onTap: () {
                      model.navigateToDetails(model.items[index]);
                    },
                    child: CustomListItm(
                      moiveObj: item,
                      index: index,
                      // itemCreated: (){},
                    ),
                  );
                }),
                separatorBuilder: (context, index) => const Divider(
                  thickness: 2,
                ),
              )),
        );
      },
    );
  }
}

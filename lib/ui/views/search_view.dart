import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: _myController,
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: "Movies"),
              Tab(text: "Tv Show"),
              Tab(text: "People")
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Movies(),
            TvShow(),
            People(),
          ],
        ),
      ),
    );
  }
}

class People extends StatefulWidget {
  @override
  _PeopleState createState() => _PeopleState();
}

class _PeopleState extends State<People> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Movies extends StatefulWidget {
  @override
  _MoviesState createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class TvShow extends StatefulWidget {
  @override
  _TvShowState createState() => _TvShowState();
}

class _TvShowState extends State<TvShow> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

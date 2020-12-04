import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:movie_base/ui/views/search_view.dart';


class DiscoverView extends StatefulWidget {
  @override
  _DiscoverViewState createState() => _DiscoverViewState();
}

class _DiscoverViewState extends State<DiscoverView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: MaterialButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchView()));
            },
            child: Text("search"),
          ),
        ),
        Center(
          child: MaterialButton(
            child: Text("geolocation"),
            onPressed: () async {
              Position position = await Geolocator.getCurrentPosition(
                  desiredAccuracy: LocationAccuracy.high);
              print(position);
            },
          ),
        ),
      ],
    );
  }
}

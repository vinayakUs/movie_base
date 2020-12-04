import 'package:flutter/material.dart';

class AccountView extends StatefulWidget {
  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListBody(
          children: [
            ListTile(
              title: Text("My List"),
              onTap: () {},
            )
          ],
        ),
        ListBody(
          children: [
            ListTile(
              title: Text("Liked"),
              onTap: () {},
            )
          ],
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
//
// class CustomNavigationBar extends StatefulWidget {
//   final int currentTab;
//   final List<Widget> widget;
//
//   const CustomNavigationBar({Key key, this.currentTab, this.widget}) : super(key: key);
//   @override
//   CustomNavigationBarState createState() => CustomNavigationBarState();
// }
//
// class CustomNavigationBarState extends State<CustomNavigationBar> with TickerProviderStateMixin {
//   Animation animation1;
//   AnimationController animationController;
//
//   int currentTab = 0;
//
//   @override
//   void initState() {
//     super.initState();
//
//     animationController =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 150));
//
//     animationController.forward();
//
//     animation1 =
//         ReverseTween(Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 1.0)))
//             .animate(animationController);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: 60,
//         width: MediaQuery.of(context).size.width,
//         padding: EdgeInsets.only(right: 16, bottom: 5, top: 10, left: 16),
//         child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               _buildTab("Hotels", Icons.hotel, 0),
//               _buildTab("Favorites", Icons.favorite, 1),
//               _buildTab("Map", Icons.map, 2)
//             ]
//             ));
//   }
//
//   Widget _buildTab(String text, IconData icon, int index) {
//     return currentTab == index
//         ? ActiveTab(
//             animation1: animation1, key: Key(text), text: text, iconData: icon)
//         : Material(
//             child: InkWell(
//                 onTap: () {
//                   setState(() {
//                     currentTab = index;
//                     if (animation1.status == AnimationStatus.completed) {}
//                     animationController.reset();
//                     animationController.forward();
//                   });
//                 },
//                 child: Text(text)));
//   }
//
//   @override
//   void dispose() {
//     animationController.dispose();
//     super.dispose();
//   }
// }
//
// class ActiveTab extends AnimatedWidget {
//   final IconData iconData;
//   final String text;
//
//   ActiveTab({Key key, Animation animation1, this.iconData, this.text})
//       : super(key: key, listenable: animation1);
//
//   @override
//   Widget build(BuildContext context) {
//     final Animation animation1 = listenable;
//     return SlideTransition(
//       position: animation1,
//       child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Icon(iconData, size: 25),
//           ]),
//     );
//   }
// }
//
// class PreviousTab extends AnimatedWidget {
//   final IconData iconData;
//   final String text;
//
//   PreviousTab({Key key, Animation animation2, this.iconData, this.text})
//       : super(key: key, listenable: animation2);
//
//   @override
//   Widget build(BuildContext context) {
//     final Animation animation2 = listenable;
//     return animation2.status == AnimationStatus.completed
//         ? Text(text)
//         : SlideTransition(
//             position: animation2,
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Icon(iconData, size: 25),
//                 ]),
//           );
//   }
// }

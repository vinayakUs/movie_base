
import 'package:flutter/material.dart';
class NavigationService {
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  void pop() {
    return _navigationKey.currentState.pop();
  }
  Future<dynamic> navigateAndClose(String routeNamed,{dynamic argument }){
    return _navigationKey.currentState.pushReplacementNamed(routeNamed,arguments: argument);
  }

  Future<dynamic> navigateTo(String routeName, {dynamic argument}) {
    return _navigationKey.currentState
        .pushNamed(routeName, arguments: argument);
  }
}

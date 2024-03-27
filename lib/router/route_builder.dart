import 'package:flutter/material.dart';
import 'package:movie_app/core/home/screens/home_screen.dart';
import 'package:movie_app/core/navigation_screen.dart';
import 'package:movie_app/router/route_path.dart';

class RouteBuilder {
  static navigationScreen() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: RoutePath.navigationScreen),
      builder: (context) => NavigationScreen(),
    );
  }

  static homeScreen() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: RoutePath.homeScreen),
      builder: (context) => HomeScreen(),
    );
  }
}

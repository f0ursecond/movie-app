import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/detail/screens/movie_detail_screen.dart';
import 'package:movie_app/router/route_builder.dart';
import 'package:movie_app/router/route_path.dart';
import 'package:movie_app/utils/transition.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    if (kDebugMode) {
      print("=>>>> ${settings.name}");
    }

    final args = settings.arguments;

    switch (settings.name) {
      case RoutePath.homeScreen:
        return RouteBuilder.homeScreen();
      case RoutePath.detailScreen:
        return customTransitionRouteBuilder(MovieDetailScreen(movieId: args as String));
      default:
        onErrorRoute();
    }

    return null;
  }

  static onErrorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: "error"),
      builder: (_) => const Scaffold(
        body: Center(
          child: Text("Route Not Found"),
        ),
      ),
    );
  }
}

PageRouteBuilder customTransitionRouteBuilder(Widget page) {
  return CustomTransition(page);
}

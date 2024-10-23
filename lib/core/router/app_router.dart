import 'package:atomic_habits/core/router/routes_names.dart';
import 'package:atomic_habits/features/home_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings value) {
    String? name = value.name;
    final args = value.arguments;

    switch (name) {
      case RoutesNames.home:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
          ),
          body: const Center(
            child: Text('no screen found'),
          ),
        );
      },
    );
  }
}

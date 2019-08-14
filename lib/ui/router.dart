import 'package:flutter/material.dart';
import 'package:flutter_firebase_template/ui/views/home_view.dart';
import 'package:flutter_firebase_template/ui/views/login_view.dart';

class Router {
  static const root = '/';
  static const login = '/login';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case root:
        return MaterialPageRoute(builder: (_) => HomeView());
      case login:
        {
        return MaterialPageRoute(builder: (_) => LoginView());
        }
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}

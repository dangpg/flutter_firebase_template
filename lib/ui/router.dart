import 'package:flutter/material.dart';
import 'package:flutter_firebase_template/core/models/item.dart';
import 'package:flutter_firebase_template/ui/views/detail_view.dart';
import 'package:flutter_firebase_template/ui/views/detail_view_args.dart';
import 'package:flutter_firebase_template/ui/views/home_view.dart';
import 'package:flutter_firebase_template/ui/views/home_view_args.dart';
import 'package:flutter_firebase_template/ui/views/loading_view.dart';
import 'package:flutter_firebase_template/ui/views/login_view.dart';

class Router {
  static const root = '/';
  static const login = '/login';
  static const home = '/home';
  static const detail = '/detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case root:
        return MaterialPageRoute(
            builder: (_) => LoadingView(), settings: RouteSettings(name: root));
      case login:
        return MaterialPageRoute(
            builder: (_) => LoginView(), settings: RouteSettings(name: login));
      case home:
        return MaterialPageRoute(
            builder: (_) => HomeView(
                  homeViewArgs: settings.arguments as HomeViewArgs,
                ),
            settings: RouteSettings(name: home));
      case detail:
        return MaterialPageRoute(
            builder: (_) => DetailView(detailViewArgs: settings.arguments as DetailViewArgs),
            settings: RouteSettings(name: detail));
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

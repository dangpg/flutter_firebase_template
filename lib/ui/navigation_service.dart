import 'package:flutter/material.dart';
import 'package:flutter_firebase_template/core/models/user.dart';
import 'package:flutter_firebase_template/ui/router.dart';

class NavigationService {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  NavigationService(Stream<User> userStream) {
    userStream.listen(returnToLoginView);
  }

  Future<dynamic> navigateTo(String routeName) =>
      _navigatorKey.currentState.pushNamed(routeName);

  Future<dynamic> navigateToArgs(String routeName, dynamic arguments) =>
      _navigatorKey.currentState.pushNamed(routeName, arguments: arguments);

  Future<dynamic> pushReplacementNamed(String routeName) =>
      _navigatorKey.currentState.pushReplacementNamed(routeName);

  Future<dynamic> returnToLoginView(User user) {
    if (user.id == '-1') {
      return _navigatorKey.currentState
          .pushNamedAndRemoveUntil(Router.login, (Route route) => false);
    }
    return null;
  }

  bool pop() => _navigatorKey.currentState.pop();
}

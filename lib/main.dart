import 'package:flutter/material.dart';
import 'package:flutter_firebase_template/core/models/user.dart';
import 'package:flutter_firebase_template/core/services/authentication_service.dart';
import 'package:flutter_firebase_template/locator.dart';
import 'package:flutter_firebase_template/ui/navigation_service.dart';
import 'package:flutter_firebase_template/ui/router.dart';
import 'package:flutter_firebase_template/ui/views/loading_view.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: locator<AuthenticationService>().getCurrentUser(),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case (ConnectionState.done):
            {
              return StreamProvider<User>.value(
                value: locator<AuthenticationService>().userController.stream,
                initialData: snapshot.hasData ? User.fromFirebaseUser(snapshot.data) : User.initial(),
                child: MaterialApp(
                  title: 'Flutter Firebase Template',
                  theme: ThemeData(),
                  initialRoute: snapshot.hasData ? Router.home : Router.login,
                  navigatorKey: locator<NavigationService>().navigatorKey,
                  onGenerateRoute: Router.generateRoute,
                ),
              );
            }
          default:
            {
              return LoadingView();
            }
        }
      },
    );
  }
}

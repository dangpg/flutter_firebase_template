import 'package:flutter/material.dart';
import 'package:flutter_firebase_template/core/models/user.dart';
import 'package:flutter_firebase_template/core/services/authentication_service.dart';
import 'package:flutter_firebase_template/core/services/setting_keys.dart';
import 'package:flutter_firebase_template/core/services/settings_service.dart';
import 'package:flutter_firebase_template/locator.dart';
import 'package:flutter_firebase_template/ui/navigation_service.dart';
import 'package:flutter_firebase_template/ui/router.dart';
import 'package:flutter_firebase_template/ui/theme_service.dart';
import 'package:flutter_firebase_template/ui/views/loading_view.dart';
import 'package:provider/provider.dart';

import 'core/models/settings.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: locator<AuthenticationService>().getCurrentUser(),
      builder: (context, AsyncSnapshot<User> userSnapshot) {
        switch (userSnapshot.connectionState) {
          case ConnectionState.done:
            return afterUserLoaded(userSnapshot.data);
          default:
            return LoadingView();
        }
      },
    );
  }

  Widget afterUserLoaded(User user) {
    return FutureBuilder<Settings>(
      future: locator<SettingsService>().getSettingsFromLocalStorage(),
      builder: (context, AsyncSnapshot<Settings> settingsSnapshot) {
        switch (settingsSnapshot.connectionState) {
          case (ConnectionState.done):
            return afterSettingsLoaded(user, settingsSnapshot.data);
          default:
            return LoadingView();
        }
      },
    );
  }

  Widget afterSettingsLoaded(User user, Settings settings) {
    return MultiProvider(
      providers: [
        StreamProvider<User>(
          builder: (_) => locator<AuthenticationService>().userStream,
          initialData: user,
        ),
        ChangeNotifierProvider<Settings>(
          builder: (_) => settings,
        ),
      ],
      child: ProxyProvider<Settings, ThemeData>(
        builder: (context, settings, _) => locator<ThemeService>()
            .getThemeData(settings.getSettingValue(SettingKeys.theme)),
        child: Consumer<ThemeData>(
          builder: (context, theme, _) => MaterialApp(
            title: 'Flutter Firebase Template',
            theme: theme,
            initialRoute: user != null ? Router.home : Router.login,
            navigatorKey: locator<NavigationService>().navigatorKey,
            onGenerateRoute: Router.generateRoute,
          ),
        ),
      ),
    );
  }
}

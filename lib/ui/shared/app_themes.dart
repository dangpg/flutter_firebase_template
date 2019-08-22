import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum AppThemeKeys {
  light, dark
}

class AppThemes{
  static final _lightTheme = ThemeData();
  static final _darkTheme = ThemeData.dark();

  static final Map<AppThemeKeys, ThemeData> _appThemeDict = {
    AppThemeKeys.light: _lightTheme,
    AppThemeKeys.dark: _darkTheme
  };

  static AppThemeKeys getKeyfromString(String s) => AppThemeKeys.values.firstWhere((e) => describeEnum(e) == s);

  static ThemeData getThemeFromKey(AppThemeKeys appThemeKey) => _appThemeDict[appThemeKey];

  static ThemeData getThemeFromString(String s) => getThemeFromKey(getKeyfromString(s));
}
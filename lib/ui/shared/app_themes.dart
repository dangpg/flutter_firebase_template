import 'package:flutter/material.dart';

class AppThemeKeys {
  static const String light = 'light';
  static const String dark = 'dark';
}

class AppThemes{
  static final _lightTheme = ThemeData();
  static final _darkTheme = ThemeData.dark();

  static final Map<String, ThemeData> _appThemeDict = {
    AppThemeKeys.light: _lightTheme,
    AppThemeKeys.dark: _darkTheme
  };

  static ThemeData getTheme(String appThemeKey) => _appThemeDict[appThemeKey];
}
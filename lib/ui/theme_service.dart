import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_template/ui/shared/app_themes.dart';

class ThemeService {
  StreamController<ThemeData> _themeController = StreamController<ThemeData>.broadcast();
  Stream<ThemeData> get themeStream => _themeController.stream;

  ThemeData _currentTheme;
  ThemeData get currentTheme => _currentTheme;

  ThemeService() : _currentTheme = AppThemes.defaultTheme;

  void updateTheme(ThemeData themeData) {
    _currentTheme = themeData;
    _themeController.add(_currentTheme);
  }
}
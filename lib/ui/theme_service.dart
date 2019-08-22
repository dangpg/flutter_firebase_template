import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_template/core/services/settings_service.dart';
import 'package:flutter_firebase_template/locator.dart';
import 'package:flutter_firebase_template/ui/shared/app_themes.dart';

class ThemeService {
  final SettingsService _settingsService = locator<SettingsService>();

  StreamController<ThemeData> _themeController = StreamController<ThemeData>.broadcast();
  Stream<ThemeData> get themeStream => _themeController.stream;

  ThemeData _currentTheme;
  ThemeData get currentTheme => _currentTheme;

  ThemeService() {
    _currentTheme = AppThemes.getThemeFromKey(_settingsService.settings.theme);
  }

  void updateTheme(ThemeData themeData) {
    _currentTheme = themeData;
    _themeController.add(_currentTheme);
  }
}
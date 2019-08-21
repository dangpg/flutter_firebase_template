import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_template/core/models/settings.dart';
import 'package:flutter_firebase_template/core/services/local_storage_service.dart';
import 'package:flutter_firebase_template/locator.dart';
import 'package:flutter_firebase_template/ui/shared/app_themes.dart';

class ThemeService {
  final LocalStorageService _localStorageService = locator<LocalStorageService>();

  StreamController<ThemeData> _themeController = StreamController<ThemeData>.broadcast();
  Stream<ThemeData> get themeStream => _themeController.stream;

  ThemeData _currentTheme;
  ThemeData get currentTheme => _currentTheme;

  ThemeService._();

  static Future<ThemeService> init() async {
    ThemeService themeService = ThemeService._();
    Settings settings = await themeService._localStorageService.getSettings();
    themeService._currentTheme = settings.theme == 'default' ? AppThemes.defaultTheme : AppThemes.darkTheme; // TODO: switch logic
    return themeService;
  }

  void updateTheme(ThemeData themeData) {
    _currentTheme = themeData;
    _themeController.add(_currentTheme);
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_firebase_template/ui/shared/app_themes.dart';

class ThemeService{
  ThemeData getThemeData(String themeKey) => AppThemes.getTheme(themeKey);
}

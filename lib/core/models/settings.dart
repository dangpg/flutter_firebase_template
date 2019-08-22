import 'package:flutter/foundation.dart';
import 'package:flutter_firebase_template/ui/shared/app_themes.dart';

class Settings {
  AppThemeKeys theme;

  Settings({this.theme});

  Settings.initial()
      : theme = AppThemeKeys.light;

  Settings.fromConfig(String theme) {
    this.theme = theme != null ? AppThemes.getKeyfromString(theme) : AppThemeKeys.light;
  }

  Settings.fromJson(Map<String, dynamic> map)
      : theme = (map ?? const {})['theme'] != null ? AppThemes.getKeyfromString(map['theme']) : AppThemeKeys.light;

  Map<String, dynamic> toJson() {
    return {
      'theme' : describeEnum(theme),
    };
  }
}
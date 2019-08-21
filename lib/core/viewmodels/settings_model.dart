import 'package:flutter_firebase_template/core/viewmodels/base_model.dart';
import 'package:flutter_firebase_template/locator.dart';
import 'package:flutter_firebase_template/ui/shared/app_themes.dart';
import 'package:flutter_firebase_template/ui/theme_service.dart';

class SettingsModel extends BaseModel {
  final ThemeService _themeService = locator<ThemeService>();

  bool get useDarkTheme => _themeService.currentTheme == AppThemes.darkTheme;

  void switchToDarkTheme(bool useDarkTheme) {
    setState(ViewState.Busy);
    _themeService.updateTheme(useDarkTheme ? AppThemes.darkTheme : AppThemes.defaultTheme);
    setState(ViewState.Idle);
  }
}

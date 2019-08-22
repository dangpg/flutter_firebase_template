import 'package:flutter_firebase_template/core/services/settings_service.dart';
import 'package:flutter_firebase_template/core/viewmodels/base_model.dart';
import 'package:flutter_firebase_template/locator.dart';
import 'package:flutter_firebase_template/ui/navigation_service.dart';
import 'package:flutter_firebase_template/ui/shared/app_themes.dart';
import 'package:flutter_firebase_template/ui/theme_service.dart';
import 'package:flutter_firebase_template/ui/views/home_view_args.dart';

class SettingsModel extends BaseModel {
  // TODO: deal with dirty, not saved changes
  final ThemeService _themeService = locator<ThemeService>();
  final SettingsService _settingsService = locator<SettingsService>();
  final NavigationService _navigationService = locator<NavigationService>();

  bool get useDarkTheme => _settingsService.settings.theme == AppThemeKeys.dark;

  void switchToDarkTheme(bool useDarkTheme) {
    setState(ViewState.Busy);
    _themeService.updateTheme(useDarkTheme
        ? AppThemes.getThemeFromKey(AppThemeKeys.dark)
        : AppThemes.getThemeFromKey(AppThemeKeys.light));
    _settingsService.changeThemeSetting(
        useDarkTheme ? AppThemeKeys.dark : AppThemeKeys.light);
    setState(ViewState.Idle);
  }

  Future<void> saveSettings() async {
    setState(ViewState.Busy);
    await _settingsService.saveSettingsToLocalStorage();
    setState(ViewState.Idle);
    _navigationService.returnToHomeView(
      arguments: HomeViewArgs(snackbarMessage: 'Settings saved'),
    );
  }
}

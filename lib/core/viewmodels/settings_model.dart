import 'package:flutter/foundation.dart';
import 'package:flutter_firebase_template/core/services/settings_service.dart';
import 'package:flutter_firebase_template/core/viewmodels/base_model.dart';
import 'package:flutter_firebase_template/locator.dart';
import 'package:flutter_firebase_template/ui/navigation_service.dart';
import 'package:flutter_firebase_template/ui/shared/app_themes.dart';
import 'package:flutter_firebase_template/ui/theme_service.dart';
import 'package:flutter_firebase_template/ui/views/home_view_args.dart';

class SettingsModel extends BaseModel {
  final ThemeService _themeService = locator<ThemeService>();
  final SettingsService _settingsService = locator<SettingsService>();
  final NavigationService _navigationService = locator<NavigationService>();

  bool get pendingChanges => _settingsService.pendingChanges;

  bool dismissAlert(bool result) => _navigationService.pop(result);

  bool get useDarkTheme =>
      _settingsService.getSettingFromKey(SettingsService.keyTheme).value ==
      describeEnum(AppThemeKeys.dark);

  void revertChanges() {
    _settingsService.revertChanges();
    _themeService.updateTheme();
  }

  void switchToDarkTheme(bool useDarkTheme) {
    setState(ViewState.Busy);
    _settingsService.changeSettingValue(
        SettingsService.keyTheme,
        useDarkTheme
            ? describeEnum(AppThemeKeys.dark)
            : describeEnum(AppThemeKeys.light));
    _themeService.updateTheme();
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

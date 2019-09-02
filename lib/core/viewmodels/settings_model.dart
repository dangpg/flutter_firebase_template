import 'package:flutter_firebase_template/core/services/setting_keys.dart';
import 'package:flutter_firebase_template/core/services/settings_service.dart';
import 'package:flutter_firebase_template/core/viewmodels/base_model.dart';
import 'package:flutter_firebase_template/locator.dart';
import 'package:flutter_firebase_template/ui/navigation_service.dart';
import 'package:flutter_firebase_template/ui/shared/app_themes.dart';
import 'package:flutter_firebase_template/ui/views/home_view_args.dart';

class SettingsModel extends BaseModel {
  final SettingsService _settingsService = locator<SettingsService>();
  final NavigationService _navigationService = locator<NavigationService>();

  bool get pendingChanges => _settingsService.pendingChanges;

  bool dismissAlert(bool result) => _navigationService.pop(result);

  bool get useDarkTheme =>
      _settingsService.getSettingFromKey(SettingKeys.theme).value ==
      AppThemeKeys.dark;

  List<String> get supportedLanguage => ['English', 'Deutsch'];
  String get selectedLanguage => _convertCountryCode(
      _settingsService.getSettingFromKey(SettingKeys.locale).value);

  String _convertCountryCode(String countryCode) {
    switch (countryCode) {
      case 'en':
        return 'English';
      case 'de':
        return 'Deutsch';
      default:
        return 'English';
    }
  }

  String _convertLanguage(String language) {
    switch (language) {
      case 'English':
        return 'en';
      case 'Deutsch':
        return 'de';
      default:
        return 'en';
    }
  }

  void switchAppLanguage(String language) {
    setState(ViewState.Busy);
    _settingsService.changeSettingValue(
        SettingKeys.locale, _convertLanguage(language));
    setState(ViewState.Idle);
  }

  void revertChanges() {
    _settingsService.revertChanges();
  }

  void switchToDarkTheme(bool useDarkTheme) {
    setState(ViewState.Busy);
    _settingsService.changeSettingValue(SettingKeys.theme,
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

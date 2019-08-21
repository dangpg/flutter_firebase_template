import 'package:flutter_firebase_template/core/models/settings.dart';
import 'package:flutter_firebase_template/core/services/local_storage_service.dart';
import 'package:flutter_firebase_template/core/viewmodels/base_model.dart';
import 'package:flutter_firebase_template/locator.dart';
import 'package:flutter_firebase_template/ui/navigation_service.dart';
import 'package:flutter_firebase_template/ui/shared/app_themes.dart';
import 'package:flutter_firebase_template/ui/theme_service.dart';
import 'package:flutter_firebase_template/ui/views/home_view_args.dart';

class SettingsModel extends BaseModel {
  // TODO: deal with dirty, not saved changes
  final ThemeService _themeService = locator<ThemeService>();
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();
  final NavigationService _navigationService = locator<NavigationService>();

  bool get useDarkTheme => _themeService.currentTheme == AppThemes.darkTheme;

  void switchToDarkTheme(bool useDarkTheme) {
    setState(ViewState.Busy);
    _themeService.updateTheme(
        useDarkTheme ? AppThemes.darkTheme : AppThemes.defaultTheme);
    setState(ViewState.Idle);
  }

  Future<void> saveSettings() async {
    setState(ViewState.Busy);
    Settings settings = Settings(theme: useDarkTheme ? 'dark' : 'default'); // TODO: Use fixed keys instead
    await _localStorageService.saveSettings(settings); // TODO: Deal with failed save
    setState(ViewState.Idle);
    _navigationService.returnToHomeView(
      arguments: HomeViewArgs(snackbarMessage: 'Settings saved'),
    );
  }
}

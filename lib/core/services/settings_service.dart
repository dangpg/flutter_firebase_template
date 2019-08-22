import 'package:flutter_firebase_template/core/models/settings.dart';
import 'package:flutter_firebase_template/core/services/local_storage_service.dart';
import 'package:flutter_firebase_template/locator.dart';
import 'package:flutter_firebase_template/ui/shared/app_themes.dart';

class SettingsService {
  final LocalStorageService _localStorageService = locator<LocalStorageService>();

  static const String _themeKey = 'theme'; //TODO: Define somewhere else

  Settings _settings = Settings.initial();
  Settings get settings => _settings;

  SettingsService._();

  static Future<SettingsService> init() async {
    SettingsService settingsService = SettingsService._();
    settingsService._settings = await settingsService._getSettingsFromLocalStorage();
    return settingsService;
  }

  void changeThemeSetting(AppThemeKeys appThemeKey) => _settings.theme = appThemeKey;

  Future<Settings> _getSettingsFromLocalStorage() async {
    String theme = await _localStorageService.getFromDisk(_themeKey);
    return Settings.fromConfig(theme);
  }
  
  Future<bool> saveSettingsToLocalStorage() async {
    try {
      await Future.forEach(_settings.toJson().entries, (MapEntry entry) async {
        await _localStorageService.saveToDisk(entry.key, entry.value);
      });
      return true;
    } on Exception {
      print('An error occurred when writing to local storage');
      return false;
    } 
  }
}
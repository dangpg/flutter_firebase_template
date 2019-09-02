import 'dart:async';

import 'package:flutter_firebase_template/core/models/setting.dart';
import 'package:flutter_firebase_template/core/models/settings.dart';
import 'package:flutter_firebase_template/core/services/local_storage_service.dart';
import 'package:flutter_firebase_template/core/services/setting_keys.dart';
import 'package:flutter_firebase_template/locator.dart';
import 'package:flutter_firebase_template/ui/shared/app_themes.dart';

class SettingsService{
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();

  Settings _settings;
  Settings get settings => _settings;
  Settings _copySettings;

  bool _pendingChanges;
  bool get pendingChanges => _pendingChanges;

  Setting getSettingFromKey(String key) => _settings.getSetting(key);

  void revertChanges() {
    if (_pendingChanges) {
      _pendingChanges = false;
      _settings.revertChanges(_copySettings);
    }
  }

  void changeSettingValue(String key, dynamic value) {
    if (!_pendingChanges) {
        _copySettings = _cloneSettings(_settings);
        _pendingChanges = true;
    }
    _settings.setSetting(key, value);
  }

  Future<Settings> getSettingsFromLocalStorage() async {
    // Initialize default setting values
    _settings = Settings();
    _settings.addSetting(SettingKeys.theme, String, AppThemeKeys.light);
    _settings.addSetting(SettingKeys.locale, String, 'en');
    _pendingChanges = false;

    await Future.forEach(_settings.getSettingKeys(), (String key) async {
      var s = await _localStorageService.getFromDisk(key);
      _settings.setSetting(key, s);
    });
    return _settings;
  }

  Future<bool> saveSettingsToLocalStorage() async {
    try {
      await Future.forEach(_settings.getSettingKeys(), (String key) async {
        await _localStorageService.saveToDisk(key, _settings.getSettingValue(key));
      });
      _pendingChanges = false;
      return true;
    } on Exception {
      print('An error occurred when writing to local storage');
      return false;
    }
  }

  Settings _cloneSettings(Settings settings) {
    Settings clone = Settings();
    settings.getSettingKeys().forEach((key) {
      Setting s = settings.getSetting(key);
      clone.addSetting(key, s.type, s.value);
    });
    return clone;
  }
}

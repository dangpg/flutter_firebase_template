import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_firebase_template/core/models/setting.dart';
import 'package:flutter_firebase_template/core/services/local_storage_service.dart';
import 'package:flutter_firebase_template/locator.dart';
import 'package:flutter_firebase_template/ui/shared/app_themes.dart';

class SettingsService {
  static const keyTheme = 'theme';

  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();

  Map<String, Setting> _settings = {};
  Map<String, Setting> _copySettings = {};

  bool _pendingChanges;
  bool get pendingChanges => _pendingChanges;

  Setting getSettingFromKey(String settingKey) => _settings[settingKey];

  SettingsService._();

  static Future<SettingsService> init() async {
    SettingsService settingsService = SettingsService._();

    // Initialize default setting values
    settingsService._settings.putIfAbsent(keyTheme,
        () => Setting(type: String, value: describeEnum(AppThemeKeys.light)));

    settingsService._settings =
        await settingsService._getSettingsFromLocalStorage();

    settingsService._pendingChanges = false;

    return settingsService;
  }

  void revertChanges() {
    if (_pendingChanges) {
      _settings = _copySettings;
      _pendingChanges = false;
    }
  }

  void changeSettingValue(String key, dynamic value) {
    if (_settings[key].type == value.runtimeType) {
      if (!_pendingChanges) {
        _copySettings = _cloneSettings(_settings);
        _pendingChanges = true;
      }
      _settings[key].value = value;
    } else {
      throw FormatException('New value does not match type of setting.');
    }
  }

  Future<Map<String, Setting>> _getSettingsFromLocalStorage() async {
    await Future.forEach(_settings.entries,
        (MapEntry<String, Setting> entry) async {
      var s = await _localStorageService.getFromDisk(entry.key);
      entry.value.value = s ?? entry.value.value;
    });
    return _settings;
  }

  Future<bool> saveSettingsToLocalStorage() async {
    try {
      await Future.forEach(_settings.entries,
          (MapEntry<String, Setting> entry) async {
        await _localStorageService.saveToDisk(entry.key, entry.value.value);
      });
      _pendingChanges = false;
      return true;
    } on Exception {
      print('An error occurred when writing to local storage');
      return false;
    }
  }

  Map<String, Setting> _cloneSettings(Map<String, Setting> settings) {
    Map<String, Setting> clone = {};
    settings.forEach((key, value) {
      clone.putIfAbsent(key, () => Setting.clone(value));
    });
    return clone;
  }
}

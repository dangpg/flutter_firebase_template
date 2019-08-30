import 'package:flutter/foundation.dart';
import 'package:flutter_firebase_template/core/models/setting.dart';

class Settings with ChangeNotifier {
  Map<String, Setting> _settings = {};

  void addSetting(String key, Type type, dynamic value) =>
      _settings.putIfAbsent(key, () => Setting(type: type, value: value));

  void setSetting(String key, dynamic value) {
    if (!_settings.containsKey(key) || value == null)
      return;

    if (_settings[key].type == value.runtimeType) {
      if (_settings[key].value != value) {
        _settings[key].value = value;
        notifyListeners();
      }
    } else {
      throw FormatException('New value does not match type of setting.');
    }
  }

  Iterable<String> getSettingKeys() => _settings.keys;

  Setting getSetting(String key) => _settings[key];

  dynamic getSettingValue(String key) => _settings[key].value;

  void revertChanges(Settings clone) {
    _settings = clone._settings;
    notifyListeners();
  }
}

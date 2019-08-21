import 'package:flutter_firebase_template/core/models/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _themeKey = 'theme';

  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();
  
  Future<Settings> getSettings() async {
    String theme =  await _getFromDisk(_themeKey) ?? 'default'; // TODO: Find a way to do this dynamically
    return Settings(theme: theme);
  }

  Future<bool> saveSettings(Settings settings) async {
    try {
      await Future.forEach(settings.toJson().entries, (MapEntry entry) async {
        await _saveToDisk(entry.key, entry.value);
      });
      return true;
    } on Exception {
      print('An error occurred when writing to local storage');
      return false;
    } 
  }

  Future<dynamic> _getFromDisk(String key) async {
    var pref = await _sharedPreferences;
    return pref.get(key);
  }

  Future<bool> _saveToDisk<T>(String key, T value) async {
    var pref = await _sharedPreferences;
    if (value is String) {
      return pref.setString(key, value);
    } else if (value is bool) {
      return pref.setBool(key, value);
    } else if (value is int) {
      return pref.setInt(key, value);
    } else if (value is double) {
      return pref.setDouble(key, value);
    } else if (value is List<String>) {
      return pref.setStringList(key, value);
    } else {
      throw Exception();
    }
  }
}

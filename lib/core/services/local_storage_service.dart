import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();
  
  Future<dynamic> getFromDisk(String key) async {
    var pref = await _sharedPreferences;
    return pref.get(key);
  }

  Future<bool> saveToDisk<T>(String key, T value) async {
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

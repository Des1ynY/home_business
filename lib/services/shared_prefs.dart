import 'package:shared_preferences/shared_preferences.dart';

class LocalDataStorage {
  static late final SharedPreferences _prefs;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static void setUserData(Map<String, dynamic> data) {
    data.forEach((key, value) async {
      await _prefs.setString(key, value.toString());
    });
  }

  static String? getUserDataByKey(String key) {
    return _prefs.getString(key);
  }

  static Map<String, String> getUserData(List<String> keys) {
    Map<String, String> map = {};

    for (String key in keys) {
      map[key] = _prefs.getString(key) ?? 'unknown';
    }

    return map;
  }

  static Future deleteUserData() async {
    await _prefs.clear();
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageRepository {
  LocalStorageRepository({required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  Future<void> saveString(String key, String value) async {
    await sharedPreferences.setString(key, value);
  }

  Future<String?> getString(String key) async {
    return sharedPreferences.getString(key);
  }

  Future<void> saveBool(String key, bool value) async {
    await sharedPreferences.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    return sharedPreferences.getBool(key);
  }

  Future<void> saveInt(String key, int value) async {
    await sharedPreferences.setInt(key, value);
  }

  Future<int?> getInt(String key) async {
    return sharedPreferences.getInt(key);
  }

  Future<void> saveDouble(String key, double value) async {
    await sharedPreferences.setDouble(key, value);
  }

  Future<double?> getDouble(String key) async {
    return sharedPreferences.getDouble(key);
  }

  Future<void> remove(String key) async {
    await sharedPreferences.remove(key);
  }

  Future<void> clear() async {
    await sharedPreferences.clear();
  }
}
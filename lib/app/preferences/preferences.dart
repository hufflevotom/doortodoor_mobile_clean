import 'package:shared_preferences/shared_preferences.dart';

const _key = 'abc123';

class LocalPreferences {
  LocalPreferences(this._preferences);
  final SharedPreferences _preferences;

  String? get token => _preferences.getString(_key);
  Future<bool> setToken(String token) => _preferences.setString(_key, token);
  Future<void> removetoken() => _preferences.clear();
}

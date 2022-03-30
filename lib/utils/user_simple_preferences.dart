import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static const _keyUsername = 'username';
  static const _keyEmail = 'email';
  //static const _keyId = 'id';
  static const _keyIsLogin = 'isLogin';
  static SharedPreferences _preferences =
      SharedPreferences.getInstance() as SharedPreferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUsername(String username) async =>
      await _preferences.setString(_keyUsername, username);
  static Future setEmail(String email) async =>
      await _preferences.setString(_keyEmail, email);
  static Future setIsLoing(bool isLoing) async =>
      await _preferences.setBool(_keyIsLogin, isLoing);
  //static Future setId(int id) async => await _preferences.setInt(_keyId, id);
  static String? getUsername() => _preferences.getString(_keyUsername);
  static String? getEmail() => _preferences.getString(_keyEmail);
  //static int? getId() => _preferences.getInt(_keyId);
  static bool? isLogin() => _preferences.getBool(_keyIsLogin);
}

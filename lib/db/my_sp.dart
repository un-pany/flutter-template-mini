import 'package:shared_preferences/shared_preferences.dart';

// SharedPreferences
class MySP {
  static SharedPreferences? prefs;

  // 初始化
  static Future<bool> init() async {
    prefs = await SharedPreferences.getInstance();
    return true;
  }

  // token
  static String? getToken() {
    return prefs?.getString('token');
  }

  static Future<bool?> setToken(string) async {
    return await prefs?.setString('token', string);
  }

  static Future<bool?> removeToken() async {
    return await prefs?.remove('token');
  }

  // Theme Mode
  static String? getThemeMode() {
    return prefs?.getString('theme-mode');
  }

  static Future<bool?> setThemeMode(string) async {
    return await prefs?.setString('theme-mode', string);
  }
}

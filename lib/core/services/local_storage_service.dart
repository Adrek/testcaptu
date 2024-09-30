import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String userKey = 'user_credentials';

  Future<void> saveUserCredentials(String userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userKey, userData);
  }

  Future<String?> getUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userKey);
  }

  Future<void> clearUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(userKey);
  }
}

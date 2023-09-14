import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  void setUser(String name) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('user', name);
  }

  Future<String?> fetchUser() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString('user');
  }
}

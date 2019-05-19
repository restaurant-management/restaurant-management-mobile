import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dataProviders/userProvider.dart';

class UserRepository {
  static const String PrepsTokenKey = 'jwt-login-token';

  final UserProvider _userProvider = UserProvider();

  Future<String> authenticate(
      {@required String usernameOrEmail, @required String password}) async {
    final token = await _userProvider.login(usernameOrEmail, password);
    return token;
  }

  Future<void> deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(PrepsTokenKey);
    return;
  }

  Future<void> persistToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PrepsTokenKey, token);
    return;
  }

  Future<bool> hasToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PrepsTokenKey) != null;
  }

  Future<void> register(String username, String email, String password) async {
    await _userProvider.register(username, email, password);
  }
}

import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthService {
  Future<bool> login(String usernameOrEmail, String password);

  Future<bool> isLoggingIn() async {
    print('check');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('jwt-login-token');
    return token != null && token.isNotEmpty;
  }

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt-login-token', token);
  }
}

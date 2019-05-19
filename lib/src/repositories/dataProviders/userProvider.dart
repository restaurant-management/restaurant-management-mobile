import 'dart:convert';

import 'package:http/http.dart';

class UserProvider {
  static String apiUrl = 'https://restaurant-management-server.herokuapp.com';
  Client client = Client();

  Future<String> login(String usernameOrEmail, String password) async {
    print('Login...');
    final response = await client.post('$apiUrl/api/users/login',
        body: {'usernameOrEmail': usernameOrEmail, 'password': password});
    if (response.statusCode == 200) {
      return response.body.toString();
    } else {
      String message;
      try {
        message = jsonDecode(response.body)['message'];
      } catch (e) {
        print('Error: $e');
        throw Exception('Đăng nhập thất bại.');
      }
      if (message != null && message.isNotEmpty) throw Exception(message);
      throw Exception('Đăng nhập thất bại.');
    }
  }

  Future<void> register(String username, String email, String password) async {
    final response = await client.post('$apiUrl/api/users/register',
        body: {'username': username, 'password': password, 'email': email});
    if (response.statusCode != 200) {
      String message;
      try {
        message = jsonDecode(response.body)['message'];
      } catch (e) {
        print('Error: $e');
        throw Exception('Đăng ký thất bại.');
      }
      if (message != null && message.isNotEmpty) throw Exception(message);
      throw Exception('Đăng ký thất bại.');
    }
  }
}

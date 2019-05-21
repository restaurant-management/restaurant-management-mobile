import 'dart:convert';

import 'package:http/http.dart';

import '../../models/userModel.dart';

class UserProvider {
  static String apiUrl = 'https://restaurant-management-server.herokuapp.com';
  Client client = Client();

  Future<String> login(String usernameOrEmail, String password) async {
    print('Login...');
    final response = await client.post('$apiUrl/api/users/login',
        body: {'usernameOrEmail': usernameOrEmail, 'password': password});
    if (response.statusCode == 200) {
      final token = response.body.toString().replaceAll('"', '');
      return token;
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
    print('Register...');
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

  Future<UserModel> getProfileByUsername(String username, String token) async {
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': token
    };
    final response =
        await client.get('$apiUrl/api/users/$username', headers: headers);
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
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

  Future<UserModel> getProfileByEmail(String email, String token) async {
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': token
    };
    final response =
        await client.get('$apiUrl/api/users/email/$email', headers: headers);
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
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
}

import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../../models/userModel.dart';

class UserProvider {
  static String apiUrl = 'https://restaurant-management-server.herokuapp.com';
  Client client = Client();

  Future<String> login(String usernameOrEmail, String password) async {
    print('Login...');
    final response = await client.post('$apiUrl/api/users/login',
        body: {'usernameOrEmail': usernameOrEmail, 'password': password});
    print(response.body);
    if (response.statusCode == 200) {
      final token = response.body.toString().replaceAll('"', '');
      return token;
    } else {
      String message;
      try {
        message = jsonDecode(response.body)['message'];
      } catch (e) {
        print('Error: $e');
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
      }
      if (message != null && message.isNotEmpty) throw Exception(message);
      throw Exception('Đăng nhập thất bại.');
    }
  }

  Future<UserModel> editUserProfile(String token, String username, String email,
      String fullName, DateTime birthday, String avatar) async {
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': token
    };

    final response = await client
        .put('$apiUrl/api/users/$username', headers: headers, body: {
      'email': email,
      'fullName': fullName,
      'birthday': DateFormat('yyyy-MM-dd').format(birthday).toString(),
      'avatar': avatar
    });
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      String message;
      try {
        message = jsonDecode(response.body)['message'];
      } catch (e) {
        print('Error: $e');
      }
      if (message != null && message.isNotEmpty) throw Exception(message);
      throw Exception('Sửa thông tin thất bại.');
    }
  }

  Future changePassword(String token, String username, String oldPassword,
      String newPassword) async {
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': token
    };
    final response = await client
        .put('$apiUrl/api/users/$username/password', headers: headers, body: {
      'oldPassword': oldPassword,
      'newPassword': newPassword
    });

    if (response.statusCode != 200) {
      String message;
      try {
        message = jsonDecode(response.body)['message'];
      } catch (e) {
        print('Error: $e');
      }
      if (message != null && message.isNotEmpty) throw Exception(message);
      throw Exception('Sửa mật khẩu thất bại.');
    }
  }
}

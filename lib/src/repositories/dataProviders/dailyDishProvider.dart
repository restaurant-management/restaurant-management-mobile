import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../../models/dailyDish.dart';

class DailyDishProvider {
  static String apiUrl = 'https://restaurant-management-server.herokuapp.com';
  Client client = Client();

  Future<List<DailyDish>> getAll() async {
    final response = await client.get('$apiUrl/api/dailyDishes');
    if (response.statusCode == 200) {
      List<DailyDish> result = [];
      List<dynamic> list = jsonDecode(response.body);
      for (int i = 0; i < list.length; i++) {
        var dailyDish = DailyDish.fromJson(list[i]);
        result.add(dailyDish);
      }
      return result;
    } else {
      String message;
      try {
        message = jsonDecode(response.body)['message'];
      } catch (e) {
        print('Error: $e');
      }
      if (message != null && message.isNotEmpty) throw Exception(message);
      throw Exception('Tải danh sách món ăn thất bại.');
    }
  }

  Future<List<DailyDish>> getAllDishToday() async {
    var day = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final response = await client.get('$apiUrl/api/dailyDishes/getBy?day=$day');
    if (response.statusCode == 200) {
      List<DailyDish> result = [];
      List<dynamic> list = jsonDecode(response.body);
      for (int i = 0; i < list.length; i++) {
        var dailyDish = DailyDish.fromJson(list[i]);
        result.add(dailyDish);
      }
      return result;
    } else {
      String message;
      try {
        message = jsonDecode(response.body)['message'];
      } catch (e) {
        print('Error: $e');
      }
      if (message != null && message.isNotEmpty) throw Exception(message);
      throw Exception('Tải danh sách món ăn thất bại.');
    }
  }
}

import 'dart:convert';

import 'package:http/http.dart';
import '../../models/dishModal.dart';

class DishProvider {
  static String apiUrl = 'https://restaurant-management-server.herokuapp.com';
  Client client = Client();

  Future<DishModal> getDishDetail(int dishId) async {
    final response = await client.get('$apiUrl/api/dishes/$dishId');
    if (response.statusCode == 200) {
      return DishModal.fromJson(jsonDecode(response.body));
    } else {
      String message;
      try {
        message = jsonDecode(response.body)['message'];
      } catch (e) {
        print('Error: $e');
      }
      if (message != null && message.isNotEmpty) throw Exception(message);
      throw Exception('Tải thông tin món ăn thất bại.');
    }
  }

  Future<List<DishModal>> getAll() async {
    final response = await client.get('$apiUrl/api/dishes/');
    if (response.statusCode == 200) {
      List<DishModal> result = [];
      List<dynamic> list = jsonDecode(response.body);
      for (int i = 0; i < list.length; i++) {
        var dish = DishModal.fromJson(list[i]);
        result.add(dish);
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
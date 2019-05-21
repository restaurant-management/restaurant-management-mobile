import 'dart:convert';

import 'package:http/http.dart';
import 'package:restaurant_management_mobile/src/models/billModel.dart';

class BillProvider {
  static String apiUrl = 'https://restaurant-management-server.herokuapp.com';
  Client client = Client();

  Future<List<BillModel>> getAll(String token) async {
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': token
    };
    final response = await client.get('$apiUrl/api/bills', headers: headers);
    if (response.statusCode == 200) {
      List<BillModel> result = [];
      List<dynamic> list = jsonDecode(response.body);
      for (int i = 0; i < list.length; i++) {
        var billModel = BillModel.fromJson(list[i]);
        result.add(billModel);
      }
      return result;
    } else {
      String message;
      try {
        message = jsonDecode(response.body)['message'];
      } catch (e) {
        print('Error: $e');
        throw Exception('Có lỗi xảy ra khi tải danh sách hoá đơn.');
      }
      if (message != null && message.isNotEmpty) throw Exception(message);
      throw Exception('Có lỗi xảy ra khi tải danh sách hoá đơn.');
    }
  }
}

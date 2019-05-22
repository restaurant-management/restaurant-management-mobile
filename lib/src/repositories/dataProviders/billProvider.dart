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

  Future<BillModel> createBill(String token, List<int> dishIds,
      List<int> quantities, List<int> prices) async {
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': token
    };
    Map<String, String> body = {};

    for (int i = 0; i < dishIds.length; i++) {
      body.addAll({
        'dishIds[$i]': dishIds[i].toString(),
        'quantities[$i]': quantities[i].toString(),
        'prices[$i]': prices[i].toString()
      });
    }
    final response =
        await client.post('$apiUrl/api/bills', body: body, headers: headers);
    if (response.statusCode != 200) {
      String message;
      try {
        message = jsonDecode(response.body)['message'];
      } catch (e) {
        print('Error: $e');
        throw Exception('Tạo hoá đơn thất bại.');
      }
      if (message != null && message.isNotEmpty) throw Exception(message);
      throw Exception('Tạo hoá đơn thất bại.');
    } else {
      return BillModel.fromJson(jsonDecode(response.body));
    }
  }

  Future<BillModel> getBill(String token, int billId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization': token
    };
    final response =
        await client.post('$apiUrl/api/bills/$billId', headers: headers);
    if (response.statusCode == 200) {
      return BillModel.fromJson(jsonDecode(response.body));
    } else {
      String message;
      try {
        message = jsonDecode(response.body)['message'];
      } catch (e) {
        print('Error: $e');
        throw Exception('Có lỗi xảy ra khi tải hoá đơn.');
      }
      if (message != null && message.isNotEmpty) throw Exception(message);
      throw Exception('Có lỗi xảy ra khi tải hoá đơn.');
    }
  }
}

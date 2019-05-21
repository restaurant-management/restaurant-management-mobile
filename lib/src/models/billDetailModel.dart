import 'package:equatable/equatable.dart';

class BillDetailModel extends Equatable {
  int _billId;
  int _dishId;
  int _quantity;

  int get billId => _billId;

  int get dishId => _dishId;

  int get quantity => _quantity;

  BillDetailModel.fromJson(Map<String, dynamic> parsedJson) {
    _billId = parsedJson['billId'];
    _dishId = parsedJson['dishId'];
    _quantity = parsedJson['quantity'];
  }
}

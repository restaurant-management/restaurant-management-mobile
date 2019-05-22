import 'package:equatable/equatable.dart';
import 'package:restaurant_management_mobile/src/models/dishModal.dart';

class BillDetailModel extends Equatable {
  int _billId;
  int _dishId;
  int _quantity;
  int _price;
  DishModal _dish;

  int get billId => _billId;

  int get dishId => _dishId;

  int get quantity => _quantity;

  int get price => _price;

  DishModal get dish => _dish;

  BillDetailModel.fromJson(Map<String, dynamic> parsedJson) {
    _billId = parsedJson['billId'];
    _dishId = parsedJson['dishId'];
    _quantity = parsedJson['quantity'];
    _price = parsedJson['price'];
    _dish = DishModal.fromJson(parsedJson['dish']);
  }
}

import 'package:equatable/equatable.dart';
import 'package:restaurant_management_mobile/src/models/cartDishModel.dart';
import 'package:restaurant_management_mobile/src/models/dailyDish.dart';

abstract class CartItemState extends Equatable {
  CartItemState([List props = const []]) : super(props);
}

class CartItemInitialize extends CartItemState {
  @override
  String toString() => 'CartItemInitialize';
}

class CartItemFetchedCartDishDetail extends CartItemState {
  final DailyDish dailyDish;

  CartItemFetchedCartDishDetail(this.dailyDish) : super([dailyDish]);

  @override
  String toString() =>
      'CartItemFetchedCartDishDetail (dishId: ${dailyDish.dish.dishId})';
}

class CartItemToFetchDetailNotSellToDay extends CartItemState {
  final CartDishModel cartDish;

  CartItemToFetchDetailNotSellToDay(this.cartDish) : super([cartDish]);

  @override
  String toString() =>
      'CartItemToFetchDetailNotSellToDay (dishId: ${cartDish.dishId})';
}

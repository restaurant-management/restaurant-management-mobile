import 'package:equatable/equatable.dart';
import 'package:restaurant_management_mobile/src/models/cartModel.dart';
import 'package:restaurant_management_mobile/src/models/dailyDish.dart';

abstract class CartBlocEvent extends Equatable {
  CartBlocEvent([List props = const []]) : super(props);
}

class FetchCartBloc extends CartBlocEvent {
  @override
  String toString() => 'FetchCartBloc';
}

class SaveCartBloc extends CartBlocEvent {
  @override
  String toString() => 'SaveCartBloc';
}

class AddDishIntoCart extends CartBlocEvent {
  final DailyDish dish;

  AddDishIntoCart(this.dish) : super([dish]);

  @override
  String toString() => 'AddDishIntoCart {id: ${dish.dish.dishId}';
}

class RemoveDishFromCart extends CartBlocEvent {
  final int dishId;

  RemoveDishFromCart(this.dishId) : super([dishId]);

  @override
  String toString() => 'RemoveDishFromCart (dishId: $dishId})';
}

class ChangeDistQuantityInCart extends CartBlocEvent {
  final int dishId;
  final int quantity;

  ChangeDistQuantityInCart(this.dishId, this.quantity)
      : super([dishId, quantity]);

  @override
  String toString() =>
      'ChangeDistQuantityInCart (dishid: $dishId, quantity: $quantity)';
}

class CreateBillFromCart extends CartBlocEvent {
  @override
  String toString() => 'CreateBillFromCart';
}

import 'package:equatable/equatable.dart';
import 'package:restaurant_management_mobile/src/models/cartDishModel.dart';

abstract class CartBlocState extends Equatable {
  CartBlocState([List props = const []]) : super(props);
}

class CartBlocInitialize extends CartBlocState {
  @override
  String toString() => 'CartBlocInitialize';
}

class CartBlocFetching extends CartBlocState {
  @override
  String toString() => 'CartBlocFetching';
}

class CartBlocAddedDish extends CartBlocState {
  final CartDishModel dish;

  CartBlocAddedDish(this.dish) : super([dish]);

  @override
  String toString() =>
      'CartBlocAddedDish (dishId: ${dish.dishId}, quantity: ${dish.quantity}, price: ${dish.price})';
}

class CartBlocRemovedDish extends CartBlocState {
  final int dishId;

  CartBlocRemovedDish(this.dishId) : super([dishId]);

  @override
  String toString() => 'CartBlocRemovedDish (dishId: $dishId)';
}

class CartBlocChangedDishQuantity extends CartBlocState {
  final int dishId;
  final int quantity;

  CartBlocChangedDishQuantity(this.dishId, this.quantity)
      : super([dishId, quantity]);

  @override
  String toString() =>
      'CartBlocChangedDishQuantity (dishId: $dishId, quantity: $quantity)';
}

class CartBlocSaving extends CartBlocState {
  @override
  String toString() => 'CartBlocSaving';
}

class CartBlocSaved extends CartBlocState {
  @override
  String toString() => 'CartBlocSaved';
}

class CartBlocFetched extends CartBlocState {
  @override
  String toString() => 'CartBlocFetched';
}

class CartBlocFailure extends CartBlocState {
  final String error;

  CartBlocFailure(this.error) : super([error]);

  @override
  String toString() => 'CartBlocFailure {error: $error}';
}

class CartBlocCreatingBill extends CartBlocState {
  @override
  String toString() => 'CartBlocCreatingBill';
}

class CartBlocCreatedBill extends CartBlocState {
  final int billId;

  CartBlocCreatedBill(this.billId) : super([billId]);

  @override
  String toString() => 'CartBlocCreatedBill (billId: $billId)';
}

class CartBlocCreateBillFailure extends CartBlocState {
  final String error;

  CartBlocCreateBillFailure(this.error) : super([error]);

  @override
  String toString() => 'CartBlocCreateBillFailure (error: $error)';
}

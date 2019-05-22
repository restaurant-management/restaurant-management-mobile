import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:restaurant_management_mobile/src/models/billModel.dart';
import 'package:restaurant_management_mobile/src/models/cartDishModel.dart';
import 'package:restaurant_management_mobile/src/models/cartModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/dailyDish.dart';
import '../models/dishModal.dart';
import '../models/userModel.dart';
import '../utils/validateEmail.dart';
import 'dataProviders/billProvider.dart';
import 'dataProviders/dailyDishProvider.dart';
import 'dataProviders/dishProvider.dart';
import 'dataProviders/userProvider.dart';

class Repository {
  static Repository _singleton;

  static Repository get instance {
    if (_singleton == null) {
      print('Initialize Repository ...');
      _singleton = Repository._internal();
    }
    return _singleton;
  }

  factory Repository() {
    return instance;
  }

  Repository._internal();

  static const String PrepsTokenKey = 'jwt-login-token';
  static const String PrepsUsernameOrEmail = 'logged-in-username-or-email';
  static const String PrepsCart = 'user-cart';

  final UserProvider _userProvider = UserProvider();
  final DailyDishProvider _dailyDishProvider = DailyDishProvider();
  final DishProvider _dishProvider = DishProvider();
  final BillProvider _billProvider = BillProvider();

  UserModel _currentUser;
  CartModel _currentCart = CartModel.empty();
  List<DailyDish> _dailyDishes;

  List<DailyDish> get dailyDishes => _dailyDishes;

  CartModel get currentCart => _currentCart;

  UserModel get currentUser => _currentUser;

  Future<String> authenticate(
      {@required String usernameOrEmail, @required String password}) async {
    return await _userProvider.login(usernameOrEmail, password);
  }

  Future<void> deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(PrepsTokenKey); // Delete token
    await prefs.remove(PrepsUsernameOrEmail); // Delete username or email
    _currentUser = null;
    return;
  }

  Future<void> persistToken(String token, String usernameOrEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PrepsTokenKey, token); // Save token
    await prefs.setString(
        PrepsUsernameOrEmail, usernameOrEmail); // Save username or email
    return;
  }

  Future<bool> hasToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PrepsTokenKey) != null;
  }

  Future<void> register(String username, String email, String password) async {
    await _userProvider.register(username, email, password);
  }

  Future<void> fetchCurrentUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final usernameOrEmail = prefs.getString(PrepsUsernameOrEmail);
    final token = prefs.getString(PrepsTokenKey);
    if (validateEmail(usernameOrEmail)) {
      _currentUser =
          await _userProvider.getProfileByEmail(usernameOrEmail, token);
    } else {
      _currentUser =
          await _userProvider.getProfileByUsername(usernameOrEmail, token);
    }
    print(_currentUser);
  }

  Future<List<DailyDish>> getAllDailyDish() async {
    return await _dailyDishProvider.getAll();
  }

  Future<List<DailyDish>> fetchAllDishToday() async {
    _dailyDishes = await _dailyDishProvider.getAllDishToday();
    return _dailyDishes;
  }

  Future<DishModal> getDishDetail(int dishId) async {
    return await _dishProvider.getDishDetail(dishId);
  }

  Future<List<DishModal>> getAllDish() async {
    return await _dishProvider.getAll();
  }

  Future<List<BillModel>> getAllBill() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(PrepsTokenKey);
    return await _billProvider.getAll(token);
  }

  /// Return bill id.
  Future<int> createBill(List<int> dishIds, List<int> quantities) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(PrepsTokenKey);
    return await _billProvider.createBill(token, dishIds, quantities);
  }

  Future<void> saveCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PrepsCart, jsonEncode(_currentCart.toJson()));
  }

  CartDishModel addDishIntoCart(DailyDish dish) {
    int quantity = 1;

    // Remove dish if it existed, then add a same new one with quantity increase one.
    int index = _currentCart.listDishes
        .indexWhere((_cartDish) => _cartDish.dishId == dish.dish.dishId);
    if (index >= 0) {
      quantity = _currentCart.listDishes[index].quantity + 1;
      _currentCart.listDishes.removeAt(index);
    }

    var cartDish = CartDishModel.fromDailyDish(dish, quantity: quantity);
    _currentCart.listDishes.add(cartDish);
    return cartDish;
  }

  void removeDishFromCart(int dishId) {
    _currentCart.listDishes
        .removeWhere((cartDish) => cartDish.dishId == dishId);
  }

  void changeDistQuantityInCart(int dishId, int quantity) {
    // Remove dish if it existed, then add a same new one with new quantity.
    CartDishModel cartDish = _currentCart.listDishes
        .firstWhere((e) => e.dishId == dishId, orElse: () => null);
    if (cartDish != null) {
      cartDish.quantity = quantity;
      _currentCart.listDishes.removeWhere((e) => e.dishId == dishId);
      _currentCart.listDishes.add(cartDish);
    }
  }

  Future<void> getCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringCart = prefs.getString(PrepsCart);
    _currentCart = CartModel.fromJson(jsonDecode(stringCart));
  }

  Future<void> clearCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _currentCart = CartModel.empty();
    await prefs.setString(PrepsCart, jsonEncode(_currentCart.toJson()));
  }
}

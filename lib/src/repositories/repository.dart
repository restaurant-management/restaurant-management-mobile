import 'package:meta/meta.dart';
import 'package:restaurant_management_mobile/src/models/billModel.dart';
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

  final UserProvider _userProvider = UserProvider();
  final DailyDishProvider _dailyDishProvider = DailyDishProvider();
  final DishProvider _dishProvider = DishProvider();
  final BillProvider _billProvider = BillProvider();

  UserModel _currentUser;

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
}

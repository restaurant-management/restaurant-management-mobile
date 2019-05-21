import 'package:restaurant_management_mobile/src/models/dailyDish.dart';
import 'package:restaurant_management_mobile/src/repositories/dataProviders/dailyDishProvider.dart';

class DailyDishRepository {
  static DailyDishRepository _singleton;

  static DailyDishRepository get instance {
    if (_singleton == null) {
      print('Initialize DailyDishRepository ...');
      _singleton = DailyDishRepository._internal();
    }
    return _singleton;
  }

  factory DailyDishRepository() {
    return instance;
  }

  DailyDishRepository._internal();

  final DailyDishProvider _dailyDishProvider = DailyDishProvider();

  Future<List<DailyDish>> getAllDailyDish () async {
    return await _dailyDishProvider.getAll();
  }
}

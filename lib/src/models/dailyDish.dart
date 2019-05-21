import 'package:equatable/equatable.dart';

import 'dishModal.dart';
import '..//enums/dailyDishStatus.dart';
import '../enums/daySession.dart';

class DailyDish extends Equatable {
  DateTime _day;
  DaySession _session;
  DailyDishStatus _status;
  int _price;
  DishModal _dish;

  DateTime get day => _day;

  DaySession get session => _session;

  DailyDishStatus get status => _status;

  int get price => _price;

  DishModal get dish => _dish;

  DailyDish.fromJson(Map<String, dynamic> parsedJson) {
    _day = DateTime.parse(parsedJson['day']);
    _session = DaySession(parsedJson['session']);
    _status = DailyDishStatus(parsedJson['status']);
    _price = parsedJson['price'];
    _dish = DishModal.fromJson(parsedJson['dish']);
  }
}

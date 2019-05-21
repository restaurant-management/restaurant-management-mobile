import 'package:equatable/equatable.dart';

abstract class DailyDishEvent extends Equatable {
  DailyDishEvent([List props = const []]) : super(props);
}

class FetchDailyDish extends DailyDishEvent {
  @override
  String toString() => 'FetchDailyDish';
}
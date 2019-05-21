import 'package:equatable/equatable.dart';
import '../../models/dailyDish.dart';

abstract class DailyDishState extends Equatable {
  DailyDishState([List props = const []]) : super(props);
}

class DailyDishInitialized extends DailyDishState {
  @override
  String toString() => 'DailyDishInitialized';
}

class DailyDishFetching extends DailyDishState {
  @override
  String toString() => 'DailyDishFetching';
}

class DailyDishFetched extends DailyDishState {
  final List<DailyDish> listDailyDish;

  DailyDishFetched(this.listDailyDish) : super([listDailyDish]);

  @override
  String toString() => 'DailyDishFetched';
}

class DailyDishFetchFailure extends DailyDishState {
  final String error;

  DailyDishFetchFailure(this.error) : super([error]);

  @override
  String toString() => 'DailyDishFetchFailure {error: $error}';
}

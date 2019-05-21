import 'package:bloc/bloc.dart';
import 'package:restaurant_management_mobile/src/repositories/dailyDishRepository.dart';

import 'event.dart';
import 'state.dart';

class DailyDishBloc extends Bloc<DailyDishEvent, DailyDishState> {
  final DailyDishRepository _dailyDishRepository = DailyDishRepository();

  @override
  DailyDishState get initialState => DailyDishInitialized();

  @override
  Stream<DailyDishState> mapEventToState(DailyDishEvent event) async* {
    if (event is FetchDailyDish) {
      yield DailyDishFetching();
      try {
        var listDailyDish = await _dailyDishRepository.getAllDailyDish();
        yield DailyDishFetched(listDailyDish);
      } catch (e) {
        DailyDishFetchFailure(e.toString());
      }
    }
  }
}

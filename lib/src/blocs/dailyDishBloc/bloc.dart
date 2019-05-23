import 'package:bloc/bloc.dart';
import '../../repositories/repository.dart';

import 'event.dart';
import 'state.dart';

class DailyDishBloc extends Bloc<DailyDishEvent, DailyDishState> {
  final Repository _repository = Repository();

  @override
  DailyDishState get initialState => DailyDishInitialized();

  @override
  Stream<DailyDishState> mapEventToState(DailyDishEvent event) async* {
    if (event is FetchDailyDish) {
      yield DailyDishFetching();
      try {
        var listDailyDish = await _repository.fetchAllDishToday();
        yield DailyDishFetched(listDailyDish);
      } catch (e) {
        yield DailyDishFetchFailure(e.toString());
      }
    }
  }
}

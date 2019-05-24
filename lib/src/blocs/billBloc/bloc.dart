import 'package:bloc/bloc.dart';
import 'package:restaurant_management_mobile/src/repositories/repository.dart';

import 'event.dart';
import 'state.dart';

class BillBloc extends Bloc<BillBlocEvent, BillBlocState> {
  final Repository _repository = Repository();

  final bool isMyBill;

  BillBloc({this.isMyBill = false});

  @override
  BillBlocState get initialState => BillBlocInitialize();

  @override
  Stream<BillBlocState> mapEventToState(BillBlocEvent event) async* {
    if (event is FetchAllBill) {
      yield BillBlocFetching();
      try {
        var listBill;
        if(isMyBill){
          listBill = await _repository.getAllCurrentUserBills();
        } else listBill = await _repository.getAllBill();
        yield BillBlocFetched(listBill);
      } catch (e) {
        yield BillBlocFetchFailure(e.toString());
      }
    }
  }
}

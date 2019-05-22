import 'package:bloc/bloc.dart';
import 'package:restaurant_management_mobile/src/blocs/billItemBloc/event.dart';
import 'package:restaurant_management_mobile/src/blocs/billItemBloc/state.dart';
import 'package:restaurant_management_mobile/src/repositories/repository.dart';

class BillItemBloc extends Bloc<BillItemEvent, BillItemState> {
  final Repository _repository = Repository();

  @override
  BillItemState get initialState => BillItemInitialize();

  @override
  Stream<BillItemState> mapEventToState(BillItemEvent event) async* {
    if (event is FetchBillData) {
      yield BillItemFetchingData(event.billDetailModel);
    }
  }
}

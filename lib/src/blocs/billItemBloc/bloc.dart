import 'package:bloc/bloc.dart';
import 'package:restaurant_management_mobile/src/blocs/billBloc/event.dart';
import 'package:restaurant_management_mobile/src/blocs/billItemBloc/event.dart';
import 'package:restaurant_management_mobile/src/blocs/billItemBloc/state.dart';
import 'package:restaurant_management_mobile/src/enums/billStatus.dart';
import 'package:restaurant_management_mobile/src/repositories/repository.dart';

class BillItemBloc extends Bloc<BillItemEvent, BillItemState> {
  final Repository _repository = Repository();

  @override
  BillItemState get initialState => BillItemInitialize();

  @override
  Stream<BillItemState> mapEventToState(BillItemEvent event) async* {
    try {
      if (event is PayBill ||
          event is PrepareBill ||
          event is FinishPrepareBill ||
          event is DeliveryBill ||
          event is FinishDeliveryBill) {
        if (event is PayBill) {
          yield BillItemUpdatingStatus(
              event.bill.status.toString(), BillStatus.paid.toString());
          await _repository.updatePaidBillStatus(event.bill.billId);
          event.billBloc.dispatch(FetchAllBill());
        }
        if (event is PrepareBill) {
          yield BillItemUpdatingStatus(
              event.bill.status.toString(), BillStatus.preparing.toString());
          await _repository.updatePreparingBillStatus(event.bill.billId);
          event.billBloc.dispatch(FetchAllBill());
        }
        if (event is FinishPrepareBill) {
          yield BillItemUpdatingStatus(
              event.bill.status.toString(), BillStatus.prepareDone.toString());
          await _repository.updatePrepareDoneBillStatus(event.bill.billId);
          event.billBloc.dispatch(FetchAllBill());
        }
        if (event is DeliveryBill) {
          yield BillItemUpdatingStatus(
              event.bill.status.toString(), BillStatus.delivering.toString());
          await _repository.updateDeliveringBillStatus(event.bill.billId);
          event.billBloc.dispatch(FetchAllBill());
        }
        if (event is FinishDeliveryBill) {
          yield BillItemUpdatingStatus(
              event.bill.status.toString(), BillStatus.complete.toString());
          await _repository.updateCompleteBillStatus(event.bill.billId);
          event.billBloc.dispatch(FetchAllBill());
        }
        yield BillItemUpdatedStatus();
      }
    } catch (e) {
      yield BillItemUpdateStatusFailure(e.toString());
    }
  }
}

import 'package:equatable/equatable.dart';
import 'package:restaurant_management_mobile/src/models/billDetailModel.dart';

abstract class BillItemEvent extends Equatable {
  BillItemEvent([List props = const []]) : super(props);
}

class FetchBillData extends BillItemEvent {
  final BillDetailModel billDetailModel;

  FetchBillData(this.billDetailModel) : super([billDetailModel]);

  @override
  String toString() => 'FetchBillData (${billDetailModel.dishId})';
}

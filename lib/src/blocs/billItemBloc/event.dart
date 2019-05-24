import 'package:equatable/equatable.dart';
import 'package:restaurant_management_mobile/src/blocs/billBloc/bloc.dart';
import 'package:restaurant_management_mobile/src/models/billModel.dart';

abstract class BillItemEvent extends Equatable {
  BillItemEvent([List props = const []]) : super(props);
}

class PayBill extends BillItemEvent {
  final BillModel bill;
  final BillBloc billBloc;

  PayBill(this.bill, this.billBloc) : super([bill, billBloc]);

  @override
  String toString() => 'PayBill (${bill.billId})';
}

class PrepareBill extends BillItemEvent {
  final BillModel bill;
  final BillBloc billBloc;

  PrepareBill(this.bill, this.billBloc) : super([bill, billBloc]);

  @override
  String toString() => 'PrepareBill (${bill.billId})';
}

class FinishPrepareBill extends BillItemEvent {
  final BillModel bill;
  final BillBloc billBloc;

  FinishPrepareBill(this.bill, this.billBloc) : super([bill, billBloc]);

  @override
  String toString() => 'FinishPrepareBill (${bill.billId})';
}

class DeliveryBill extends BillItemEvent {
  final BillModel bill;
  final BillBloc billBloc;

  DeliveryBill(this.bill, this.billBloc) : super([bill, billBloc]);

  @override
  String toString() => 'DeliveryBill (${bill.billId})';
}

class FinishDeliveryBill extends BillItemEvent {
  final BillModel bill;
  final BillBloc billBloc;

  FinishDeliveryBill(this.bill, this.billBloc) : super([bill, billBloc]);

  @override
  String toString() => 'FinishDeliveryBill (${bill.billId})';
}

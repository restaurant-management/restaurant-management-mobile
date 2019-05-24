import 'package:equatable/equatable.dart';

abstract class BillBlocEvent extends Equatable {
  BillBlocEvent([List props = const []]) : super(props);
}

class FetchAllBill extends BillBlocEvent {
  @override
  String toString() => 'FetchAllBill';
}

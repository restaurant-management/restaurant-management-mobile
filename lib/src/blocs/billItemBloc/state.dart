import 'package:equatable/equatable.dart';

abstract class BillItemState extends Equatable {
  BillItemState([List props = const []]) : super(props);
}

class BillItemInitialize extends BillItemState {
  @override
  String toString() => 'BillItemInitialize';
}

class BillItemUpdatingStatus extends BillItemState {
  final String oldStatus;
  final String newStatus;

  BillItemUpdatingStatus(this.oldStatus, this.newStatus)
      : super([oldStatus, newStatus]);

  @override
  String toString() => 'BillItemUpdatingStatus ($oldStatus=>$newStatus)';
}

class BillItemUpdatedStatus extends BillItemState {
  @override
  String toString() => 'BillItemUpdatedStatus';
}

class BillItemUpdateStatusFailure extends BillItemState {
  final String error;

  BillItemUpdateStatusFailure(this.error) : super([error]);

  @override
  String toString() => 'BillItemUpdateStatusFailure ($error)';
}

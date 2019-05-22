import 'package:equatable/equatable.dart';
import 'package:restaurant_management_mobile/src/models/billDetailModel.dart';
import 'package:restaurant_management_mobile/src/models/billModel.dart';
import 'package:restaurant_management_mobile/src/models/dishModal.dart';

abstract class BillItemState extends Equatable {
  BillItemState([List props = const []]) : super(props);
}

class BillItemInitialize extends BillItemState {
  @override
  String toString() => 'BillItemInitialize';
}

class BillItemFetchingData extends BillItemState {
  final BillDetailModel billDetail;

  BillItemFetchingData(this.billDetail) : super([billDetail]);

  @override
  String toString() =>
      'BillItemFetchingData (billId: ${billDetail.billId}, dishId: ${billDetail.dishId})';
}

class BillItemFetchedData extends BillItemState {
  final DishModal dishDetail;

  BillItemFetchedData(this.dishDetail) : super([dishDetail]);

  @override
  String toString() => 'BillItemFetchedData (dishId: ${dishDetail.dishId})';
}

class BillItemFetchFailure extends BillItemState {
  final String error;

  BillItemFetchFailure(this.error) : super([error]);

  @override
  String toString() => 'BillItemFetchFailure (error: $error)';
}

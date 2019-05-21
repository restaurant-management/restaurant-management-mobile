import 'package:equatable/equatable.dart';
import 'package:restaurant_management_mobile/src/models/billModel.dart';

abstract class BillBlocState extends Equatable {
  BillBlocState([List props = const []]) : super(props);
}

class BillBlocInitialize extends BillBlocState {
  @override
  String toString() => 'BillBlocInitialize';
}

class BillBlocFetching extends BillBlocState {
  @override
  String toString() => 'BillBlocFetching';
}

class BillBlocFetched extends BillBlocState {
  final List<BillModel> listBill;

  BillBlocFetched(this.listBill) : super([listBill]);

  @override
  String toString() => 'BillBlocFetched ${listBill.length} bills';
}

class BillBlocFetchFailure extends BillBlocState {
  final String error;

  BillBlocFetchFailure(this.error) : super([error]);

  @override
  String toString() => 'BillBlocFetchFailure {error: $error}';
}

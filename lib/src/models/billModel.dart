import 'package:equatable/equatable.dart';

import '../enums/billStatus.dart';
import '../models/billDetailModel.dart';

class BillModel extends Equatable {
  int _billId;
  DateTime _day;
  BillStatus _status;
  String _username;
  List<BillDetailModel> _billDetails;

  int get billId => _billId;

  DateTime get day => _day;

  BillStatus get status => _status;

  String get username => _username;

  List<BillDetailModel> get billDetails => _billDetails;

  BillModel.fromJson(Map<String, dynamic> parsedJson) {
    _billId = parsedJson['billId'];
    _day = DateTime.parse(parsedJson['day']);
    _status = BillStatus(parsedJson['status']);
    _username = parsedJson['username'];
    List<dynamic> jsonBillDetails = parsedJson['billDetails'];
    _billDetails = [];
    for (int i = 0; i < jsonBillDetails.length; i++) {
      _billDetails.add(BillDetailModel.fromJson(jsonBillDetails[i]));
    }
  }
}

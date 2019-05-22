import 'package:equatable/equatable.dart';
import 'package:restaurant_management_mobile/src/models/userModel.dart';

import '../enums/billStatus.dart';
import '../models/billDetailModel.dart';

class BillModel extends Equatable {
  int _billId;
  DateTime _day;
  BillStatus _status;
  String _username;
  UserModel _user;
  List<BillDetailModel> _billDetails;

  int get billId => _billId;

  DateTime get day => _day;

  BillStatus get status => _status;

  String get username => _username;

  UserModel get user => _user;

  List<BillDetailModel> get billDetails => _billDetails;

  BillModel.fromJson(Map<String, dynamic> parsedJson) {
    _billId = parsedJson['billId'];
    _day = DateTime.parse(parsedJson['day']);
    _status = BillStatus(parsedJson['status']);
    _username = parsedJson['username'];
    _user = UserModel.fromJson(parsedJson['user']);
    List<dynamic> jsonBillDetails = parsedJson['billDetails'];
    _billDetails = [];
    for (int i = 0; i < jsonBillDetails.length; i++) {
      _billDetails.add(BillDetailModel.fromJson(jsonBillDetails[i]));
    }
  }
}

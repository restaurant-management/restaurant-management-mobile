import 'dart:core';

class UserModel {
  String _uuid;
  String _username;
  String _fullName;
  String _email;
  DateTime _birthday;
  int _point;

  String get uuid => _uuid;
  String get username => _username;
  String get fullName => _fullName;
  String get email => _email;
  DateTime get birthday => _birthday;
  int get point => _point;

  UserModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson);
    _uuid = parsedJson['uuid'];
    _username = parsedJson['userName'];
    _fullName = parsedJson['fullName'];
    _email = parsedJson['email'];
    _birthday = parsedJson['birthday'];
  }
}
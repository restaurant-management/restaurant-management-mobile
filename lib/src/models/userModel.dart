import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

import 'package:restaurant_management_mobile/src/enums/permission.dart';

class UserModel extends Equatable {
  String _uuid;
  String _username;
  String _fullName;
  String _avatar;
  String _email;
  DateTime _birthday;
  List<Permission> _permissions;
  String _role;
  int _point;

  String get uuid => _uuid;

  String get username => _username;

  String get fullName => _fullName;

  String get avatar => _avatar;

  String get email => _email;

  DateTime get birthday => _birthday;

  List<Permission> get permissions => _permissions;

  String get role => _role;

  int get point => _point;

  UserModel.fromJson(Map<String, dynamic> parsedJson) {
    _uuid = parsedJson['uuid'];
    _username = parsedJson['userName'];
    _fullName = parsedJson['fullName'];
    _avatar = parsedJson['avatar'];
    _email = parsedJson['email'];
    _birthday = parsedJson['birthday'] != null
        ? DateFormat('yyyy-MM-dd').parse(parsedJson['birthday'])
        : null;
    List<String> stringPermissions = parsedJson['permissions'];
    _permissions = Permission.fromListString(stringPermissions);
    _point = parsedJson['point'];
    _role = parsedJson['role'];
  }

  UserModel.empty() {
    _uuid = '';
    _username = 'username';
    _fullName = 'fullName';
    _avatar = '';
    _email = 'email@gmail.com';
    _birthday = DateTime.now();
    _permissions = [];
    _point = 0;
    _role = '';
  }

  @override
  String toString() {
    return '{uuid: $uuid, username: $username, fullname: $fullName, email: $email, birthday: $birthday, point: $point, role: $role, permissions: $permissions}';
  }
}

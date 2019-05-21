import 'package:restaurant_management_mobile/src/enums/permission.dart';

class RoleModel {
  String _slug;
  String _name;
  String _description;
  List<Permission> _permissions;

  String get slug => _slug;
  String get name => _name;
  String get description => _description;
  List<Permission> get permissions => _permissions;

  RoleModel.fromJson(Map<String, dynamic> parsedJson) {
    _slug = parsedJson['slug'];
    _name = parsedJson['name'];
    _description = parsedJson['description'];
    List<String> stringPermissions = parsedJson['permissions'];
    _permissions = Permission.fromListString(stringPermissions);
  }
}
enum Permission {
  /// Permission about *role*.
  RoleManagement,

  /// Permission about *user*.
  UserManagement,

  /// Permission about *bill*.
  BillManagement,
  CreateBill,
  UpdateBillStatus,

  /// Permission about *dish*.
  DishManagement,

  /// Permission about *daily dish*.
  DailyDishManagement,
}

/// role-management => Permission.RoleManagement
Permission permissionFromString(String value) {
  try {
    return Permission.values.firstWhere((e) =>
        e.toString().split('.')[1].toUpperCase() ==
        value.replaceAll('-', '').toUpperCase());
  } catch (e) {
    return null;
  }
}

/// Permission.RoleManagement => role-management
String permissionToString(Permission permission) {
  switch (permission) {
    case Permission.RoleManagement:
      return 'role-management';
    case Permission.UserManagement:
      return 'user-management';
    case Permission.BillManagement:
      return 'bill-management';
    case Permission.CreateBill:
      return 'create-bill';
    case Permission.UpdateBillStatus:
      return 'update-bill-status';
    case Permission.DishManagement:
      return 'dish-management';
    case Permission.DailyDishManagement:
      return 'daily-dish-management';
  }
  return null;
}

List<Permission> listPermissionFromListString(List<String> stringPermissions) {
  if (stringPermissions == [] || stringPermissions == null) return [];
  List<Permission> result =
      stringPermissions.map((item) => permissionFromString(item)).toList();
  result.removeWhere((item) => item == null);
  return result;
}

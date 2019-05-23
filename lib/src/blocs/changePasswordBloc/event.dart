import 'package:equatable/equatable.dart';
import 'package:restaurant_management_mobile/src/models/userModel.dart';

abstract class ChangePasswordBlocEvent extends Equatable {
  ChangePasswordBlocEvent([List props = const []]) : super(props);
}

class ChangePasswordEvent extends ChangePasswordBlocEvent {
  final UserModel user;
  final String oldPassword;
  final String newPassword;

  ChangePasswordEvent(this.oldPassword, this.newPassword, this.user)
      : super([oldPassword, newPassword, user]);

  @override
  String toString() => 'ChangePasswordEvent ($oldPassword => $newPassword)';
}

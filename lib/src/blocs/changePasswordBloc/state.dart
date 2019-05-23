import 'package:equatable/equatable.dart';

abstract class ChangePasswordBlocState extends Equatable {
  ChangePasswordBlocState([List props = const []]) : super(props);
}

class ChangePasswordBlocInitialize extends ChangePasswordBlocState {
  @override
  String toString() => 'ChangePasswordBlocInitialize';
}

class ChangePasswordBlocChanging extends ChangePasswordBlocState {
  @override
  String toString() => 'ChangePasswordBlocChanging';
}

class ChangePasswordBlocChanged extends ChangePasswordBlocState {
  @override
  String toString() => 'ChangePasswordBlocChanged';
}

class ChangePasswordBlocFailure extends ChangePasswordBlocState {
  final String error;

  ChangePasswordBlocFailure(this.error) : super([error]);

  @override
  String toString() => 'ChangePasswordBlocFailure ($error)';
}

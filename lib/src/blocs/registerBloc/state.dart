import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RegisterState extends Equatable {
  RegisterState([List props = const []]) : super(props);
}

class RegisterInitial extends RegisterState {
  @override
  String toString() => 'RegisterInitial';
}

class RegisterLoading extends RegisterState {
  @override
  String toString() => 'RegisterLoading';
}

class RegisterSuccess extends RegisterState{
  @override
  String toString() => 'RegisterSuccess';
}

class RegisterFailure extends RegisterState {
  final String error;

  RegisterFailure(this.error);

  @override
  String toString() => 'RegisterFailure';
}
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable{
  AuthenticationEvent([List props = const []]) : super(props);
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends AuthenticationEvent {
  final String token;
  final String usernameOrEmail;

  LoggedIn(this.usernameOrEmail, this.token) : super([token]);

  @override
  String toString() => 'LoggedIn { user: $usernameOrEmail }';
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}
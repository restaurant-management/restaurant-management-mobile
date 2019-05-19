import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../repositories/userRepository.dart';
import '../authenticationBloc/bloc.dart';
import '../authenticationBloc/event.dart';
import 'event.dart';
import 'state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository = UserRepository();
  final AuthenticationBloc authenticationBloc;

  LoginBloc({@required this.authenticationBloc})
      : assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final token = await _userRepository.authenticate(
            usernameOrEmail: event.usernameOrEmail, password: event.password);
        authenticationBloc.dispatch(LoggedIn(token: token));
      } catch (e) {
        yield LoginFailure(error: e.toString());
      }
    }

    if (event is InitializeLoginForm) {
      yield LoginInitial();
    }
  }
}

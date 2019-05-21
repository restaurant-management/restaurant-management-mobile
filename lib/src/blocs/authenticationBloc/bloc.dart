import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../repositories/userRepository.dart';
import '../currentUserBloc/bloc.dart';
import '../currentUserBloc/event.dart';
import 'event.dart';
import 'state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository = UserRepository.instance;
  final CurrentUserBloc _currentUserBloc = CurrentUserBloc();

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      final bool hasToken = await _userRepository.hasToken();
      if (hasToken) {
        _currentUserBloc.dispatch(FetchCurrentUserProfile());
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await _userRepository.persistToken(event.token, event.usernameOrEmail);
      _currentUserBloc.dispatch(FetchCurrentUserProfile());
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await _userRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}

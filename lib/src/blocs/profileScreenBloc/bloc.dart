import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../repositories/userRepository.dart';
import '../currentUserBloc/bloc.dart';
import '../currentUserBloc/event.dart';
import '../currentUserBloc/state.dart';
import 'event.dart';
import 'state.dart';

class ProfileScreenBloc extends Bloc<ProfileScreenEvent, ProfileScreenState> {
  final UserRepository _userRepository = UserRepository.instance;
  final CurrentUserBloc _currentUserBloc = CurrentUserBloc();

  StreamSubscription _currentUserBlocSubscription;

  @override
  ProfileScreenState get initialState =>
      ProfileScreenInitialize(_userRepository.currentUser);

  @override
  Stream<ProfileScreenState> mapEventToState(ProfileScreenEvent event) async* {
    if (event is ProfileScreenFetchProfile) {
      _currentUserBloc.dispatch(FetchCurrentUserProfile());
      yield ProfileScreenFetching();
      _currentUserBlocSubscription = _currentUserBloc.state.listen((state) {
        if (state is CurrentUserProfileFetched) {
          this.dispatch(ProfileScreenFinishFetching());
        }
        if (state is CurrentUserProfileFetchFailure) {
          this.dispatch(ProfileScreenFailFetching(state.error));
        }
      });
    }

    if (event is ProfileScreenFinishFetching) {
      yield ProfileScreenFetched(_userRepository.currentUser);
    }

    if (event is ProfileScreenFailFetching) {
      yield ProfileScreenFetchFailure(event.error);
    }
  }

  @override
  void dispose() {
    _currentUserBlocSubscription.cancel();
    super.dispose();
  }
}

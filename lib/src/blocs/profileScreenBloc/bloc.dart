import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../repositories/repository.dart';
import '../currentUserBloc/bloc.dart';
import '../currentUserBloc/event.dart';
import '../currentUserBloc/state.dart';
import 'event.dart';
import 'state.dart';

class ProfileScreenBloc extends Bloc<ProfileScreenEvent, ProfileScreenState> {
  final Repository _repository = Repository.instance;
  final CurrentUserBloc _currentUserBloc = CurrentUserBloc();

  StreamSubscription _currentUserBlocSubscription;

  @override
  ProfileScreenState get initialState =>
      ProfileScreenInitialize(_repository.currentUser);

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
      yield ProfileScreenFetched(_repository.currentUser);
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

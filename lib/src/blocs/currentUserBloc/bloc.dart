import 'package:bloc/bloc.dart';
import '../../repositories/userRepository.dart';

import 'event.dart';
import 'state.dart';


/// Singleton Bloc
class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  final UserRepository _userRepository = UserRepository();

  CurrentUserBloc._internal();

  static CurrentUserBloc _singleton = CurrentUserBloc._internal();

  factory CurrentUserBloc(){
    return _singleton;
  }

  @override
  CurrentUserState get initialState => CurrentUserProfileEmpty();

  @override
  Stream<CurrentUserState> mapEventToState(CurrentUserEvent event) async* {
    if (event is FetchCurrentUserProfile) {
      yield CurrentUserProfileFetching();
      try {
        await _userRepository.fetchCurrentUserProfile();
        yield CurrentUserProfileFetched();
      } catch (e) {
        yield CurrentUserProfileFetchFailure(e.toString());
      }
    }
  }
}

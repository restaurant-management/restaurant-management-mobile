import 'package:bloc/bloc.dart';
import 'package:restaurant_management_mobile/src/enums/permission.dart';
import '../../repositories/repository.dart';

import 'event.dart';
import 'state.dart';

/// Singleton Bloc
class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  final Repository _repository = Repository();

  List<Permission> _allPermission;

  List<Permission> get allPermission => _allPermission;

  CurrentUserBloc._internal();

  static CurrentUserBloc _singleton = CurrentUserBloc._internal();

  factory CurrentUserBloc() {
    return _singleton;
  }

  @override
  CurrentUserState get initialState => CurrentUserProfileEmpty();

  @override
  Stream<CurrentUserState> mapEventToState(CurrentUserEvent event) async* {
    if (event is FetchCurrentUserProfile) {
      yield CurrentUserProfileFetching();
      try {
        await _repository.fetchCurrentUserProfile();
        _allPermission = await _repository.getAllCurrentUserPermission();
        yield CurrentUserProfileFetched(_repository.currentUser);
      } catch (e) {
        yield CurrentUserProfileFetchFailure(e.toString());
      }
    }
  }
}

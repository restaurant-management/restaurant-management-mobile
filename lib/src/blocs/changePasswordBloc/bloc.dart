import 'package:bloc/bloc.dart';
import 'package:restaurant_management_mobile/src/blocs/changePasswordBloc/event.dart';
import 'package:restaurant_management_mobile/src/blocs/changePasswordBloc/state.dart';
import 'package:restaurant_management_mobile/src/repositories/repository.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordBlocEvent, ChangePasswordBlocState> {
  final Repository _repository = Repository();

  @override
  ChangePasswordBlocState get initialState => ChangePasswordBlocInitialize();

  @override
  Stream<ChangePasswordBlocState> mapEventToState(
      ChangePasswordBlocEvent event) async* {
    if (event is ChangePasswordEvent) {
      yield ChangePasswordBlocChanging();
      try {
        await _repository.changeUserPassword(
            event.user, event.oldPassword, event.newPassword);
        yield ChangePasswordBlocChanged();
      } catch (e) {
        yield ChangePasswordBlocFailure(e.toString());
      }
    }
  }
}

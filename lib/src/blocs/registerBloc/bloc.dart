import 'package:bloc/bloc.dart';

import '../../repositories/userRepository.dart';
import 'event.dart';
import 'state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository = UserRepository.instance;

  @override
  RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterButtonPressed) {
      yield RegisterLoading();

      try {
        await _userRepository.register(
            event.username, event.email, event.password);
        yield RegisterSuccess();
      } catch (e) {
        yield RegisterFailure(e.toString());
      }
    }
  }
}

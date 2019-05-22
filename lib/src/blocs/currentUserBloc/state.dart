import 'package:equatable/equatable.dart';
import 'package:restaurant_management_mobile/src/models/userModel.dart';

abstract class CurrentUserState extends Equatable {
  CurrentUserState([List props = const[]]) : super(props);
}

class CurrentUserProfileEmpty extends CurrentUserState {
  @override
  String toString() => 'CurrentUserProfileEmpty';
}

class CurrentUserProfileFetching extends CurrentUserState {
  @override
  String toString() => 'FetchingCurrentUserProfile';
}

class CurrentUserProfileFetched extends CurrentUserState {
  final UserModel user;

  CurrentUserProfileFetched(this.user) : super([user]);

  @override
  String toString() => 'CurrentUserProfileFetched';
}

class CurrentUserProfileFetchFailure extends CurrentUserState {

  final String error;

  CurrentUserProfileFetchFailure(this.error) : super([error]);

  @override
  String toString() => 'CurrentUserProfileFetchFailure {error: $error}';
}
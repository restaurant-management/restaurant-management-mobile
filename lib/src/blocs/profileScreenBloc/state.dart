import 'package:equatable/equatable.dart';

import '../../models/userModel.dart';

abstract class ProfileScreenState extends Equatable {
  ProfileScreenState([List props = const []]) : super(props);
}

class ProfileScreenFetching extends ProfileScreenState {
  @override
  String toString() => 'ProfileScreenFetching';
}

class ProfileScreenFetched extends ProfileScreenState {
  final UserModel currentUser;

  ProfileScreenFetched(this.currentUser) : super([currentUser]);

  @override
  String toString() => 'ProfileScreenFetched';
}

class ProfileScreenFetchFailure extends ProfileScreenState {
  final String error;

  ProfileScreenFetchFailure(this.error) : super([error]);

  @override
  String toString() => 'ProfileScreenFetchFailure {error: $error}';
}

class ProfileScreenInitialize extends ProfileScreenState {
  final UserModel currentUser;

  ProfileScreenInitialize(this.currentUser) : super([currentUser]);

  @override
  String toString() => 'ProfileScreenInitialize';
}

import 'package:equatable/equatable.dart';

abstract class ProfileScreenEvent extends Equatable {
  ProfileScreenEvent([List props = const []]) : super(props);
}

class ProfileScreenFetchProfile extends ProfileScreenEvent {
  @override
  String toString() => 'ProfileScreenFetchProfile';
}

class ProfileScreenFinishFetching extends ProfileScreenEvent {
  @override
  String toString() => 'ProfileScreenFinishFetching';
}

class ProfileScreenFailFetching extends ProfileScreenEvent {
  final String error;

  ProfileScreenFailFetching(this.error) : super([error]);

  @override
  String toString() => 'ProfileScreenFailFetching {error: $error}';
}
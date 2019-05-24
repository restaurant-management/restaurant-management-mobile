import 'package:equatable/equatable.dart';

abstract class CurrentUserEvent extends Equatable {
  CurrentUserEvent([List props = const []]) : super(props);
}

class FetchCurrentUserProfile extends CurrentUserEvent {
  @override
  String toString() => 'FetchCurrentUserProfile';
}

class GetAllCurrentUserPermissions extends CurrentUserEvent {
  @override
  String toString() => 'GetAllCurrentUserPermissions';
}

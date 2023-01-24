part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthInitEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class AuthCheckExpiredEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class AuthLogoutEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

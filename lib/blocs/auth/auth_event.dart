part of 'auth_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class AuthenticationLoginEvent extends AuthenticationEvent {
  final UserModel user;

  const AuthenticationLoginEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthenticationLogoutEvent extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class AuthenticationAuthenticatedState extends AuthenticationState {
  final UserModel user;

  const AuthenticationAuthenticatedState({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthenticationUnauthenticatedState extends AuthenticationState {}

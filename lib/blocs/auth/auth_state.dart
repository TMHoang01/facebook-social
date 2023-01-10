part of 'auth_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthenticationState {}

class AuthenticationInitialState extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}

class UnauthenticatedState extends AuthenticationState {}

class AuthenticatedState extends AuthenticationState {
  final UserModel user;

  AuthenticatedState(this.user);

  @override
  List<Object> get props => [user];
}

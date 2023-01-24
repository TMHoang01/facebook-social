part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

// class AuthInitialState extends AuthState {}

class AuthInitialState extends AuthState {}

class AuthExpiredState extends AuthState {}

class UnAuthState extends AuthState {}

class AuthSuccessState extends AuthState {
  final AuthModel? user;

  const AuthSuccessState({required this.user});

  @override
  List<Object> get props => [user!];
}

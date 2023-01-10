part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginFailureState extends LoginState {
  final String message;

  LoginFailureState({required this.message});
}

class LoginErrorState extends LoginState {
  final String message;

  LoginErrorState({required this.message});
}

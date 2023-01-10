part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginInitial extends LoginEvent {
  LoginInitial();
}

class LoginLoading extends LoginEvent {}

class LoginButtonPress extends LoginEvent {
  final String phone;
  final String password;

  LoginButtonPress({required this.phone, required this.password}) : super();
}

// class LoginSuccess extends LoginEvent {}

class LoginFailure extends LoginEvent {}

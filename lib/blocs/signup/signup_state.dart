part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitialState extends SignupState {}

class SignupUserState extends SignupState {}

class SignupLoadingState extends SignupState {}

class SignupSuccessState extends SignupState {}

class ErrorPhoneState extends SignupState {
  final String message;
  ErrorPhoneState({
    required this.message,
  });
}

class ErrorPasswordState extends SignupState {
  final String message;
  ErrorPasswordState({
    required this.message,
  });
}

class SignupFailureState extends SignupState {
  final String message;
  SignupFailureState({
    required this.message,
  });
}

class SignupVerifyCode extends SignupState {
  final String message;
  SignupVerifyCode({
    required this.message,
  });
}

class SignupVerifyLoadingState extends SignupState {}

class SignupVerifySuccessState extends SignupState {}

class SignupVerifyFailureState extends SignupState {
  final String message;
  SignupVerifyFailureState({
    required this.message,
  });
}

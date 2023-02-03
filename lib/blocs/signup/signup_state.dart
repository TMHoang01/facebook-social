// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitialState extends SignupState {}

class SignupUserState extends SignupState {
  String? phoneNumber;
  String? password;
  SignupUserState({
    this.phoneNumber,
    this.password,
  });

  SignupUserState copyWith({
    String? phoneNumber,
    String? password,
  }) {
    return SignupUserState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
    );
  }
}

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

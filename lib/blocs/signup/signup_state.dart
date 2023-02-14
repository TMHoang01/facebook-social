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

class SignupErrorState extends SignupState {
  final String message;
  SignupErrorState({
    required this.message,
  });
}

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
  final bool? failurePhone;
  SignupFailureState({
    required this.message,
    this.failurePhone,
  });
}

class SignupVerifyCodeState extends SignupState {
  final String code;
  final String phone;
  SignupVerifyCodeState({
    required this.code,
    required this.phone,
  });
}

class SignupVerifyLoadingState extends SignupState {}

class SignupVerifySuccessState extends SignupState {}

class AwaitVerifyState extends SignupState {
  final String phone;
  final int seconds;
  AwaitVerifyState({
    required this.phone,
    required this.seconds,
  });
}

class SignupVerifyFailureState extends SignupState {
  final String message;
  SignupVerifyFailureState({
    required this.message,
  });
  @override
  // TODO: implement props
  List<Object> get props => super.props + [message];
}

class SignupChangeInfoLoadingState extends SignupState {}

class SignupChangeInfoSuccessState extends SignupState {}

class SignupChangeInfoFailureState extends SignupState {
  final String message;
  SignupChangeInfoFailureState({
    required this.message,
  });
}

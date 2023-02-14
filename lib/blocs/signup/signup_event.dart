// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupUserEvent extends SignupEvent {
  final String phone;
  final String password;
  SignupUserEvent({
    required this.phone,
    required this.password,
  });
}

class VerifyCodeEvent extends SignupEvent {
  final String code;
  final String phone;
  VerifyCodeEvent({
    required this.code,
    required this.phone,
  });
}

// class VerifyCodeLoadingEvent extends SignupEvent {}

class SignupGetCodeVerifyEvent extends SignupEvent {
  final String phone;
  SignupGetCodeVerifyEvent({
    required this.phone,
  });
}

class VerifyPhoneNumberEvent extends SignupEvent {
  final String phoneNumber;
  VerifyPhoneNumberEvent({
    required this.phoneNumber,
  });
}

class VerifyPasswordEvent extends SignupEvent {
  final String password;
  VerifyPasswordEvent({
    required this.password,
  });
}

class ChangeInfoAfterSignup extends SignupEvent {
  final String username;
  final XFile? avatar;
  ChangeInfoAfterSignup({
    required this.username,
    required this.avatar,
  });
}

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

class verifyCodeEvent extends SignupEvent {
  final String code;
  verifyCodeEvent({
    required this.code,
  });
}

class verifyPhoneNumberEvent extends SignupEvent {
  final String phoneNumber;
  verifyPhoneNumberEvent({
    required this.phoneNumber,
  });
}

class verifyPasswordEvent extends SignupEvent {
  final String password;
  verifyPasswordEvent({
    required this.password,
  });
}

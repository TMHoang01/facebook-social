import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fb_copy/constants.dart';
import 'package:fb_copy/models/auth_model.dart';
import 'package:fb_copy/repositories/api_repository.dart';
import 'package:fb_copy/repositories/auth_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  AuthRepository authRepository;

  SignupBloc(this.authRepository) : super(SignupInitialState()) {
    on<SignupUserEvent>(_onSignupUserEvent);
    on<VerifyCodeEvent>(_onSignupVerifyEvent);
    on<SignupGetCodeVerifyEvent>(_onSignupGetCodeVerifyEvent);
    on<ChangeInfoAfterSignup>(_onChangeInfoAfterSignup);
  }

  FutureOr<void> _onSignupUserEvent(SignupUserEvent event, Emitter<SignupState> emit) async {
    emit(SignupLoadingState());
    try {
      ApiResponse response = await authRepository.signupUser(
        phone: event.phone,
        password: event.password,
      );
      Logger().i(response);
      if (response.code == '1000') {
        emit(SignupSuccessState());
        final code = response.getData('verifyCode');
        final phone = response.getData('phonenumber');
        Logger().i(response.getData('verifyCode'));

        emit(SignupVerifyCodeState(code: code, phone: phone));
      } else if (response.code == '9996') {
        emit(SignupFailureState(message: 'Số điện thoại đã được đăng ký', failurePhone: true));
      } else if (response.code == '1002') {
      } else if (response.code == '1004') {
        if (response.details != null && response.details!.contains('phonenumber')) {
          emit(SignupFailureState(message: 'Số điện thoại không đúng định dạng', failurePhone: true));
        } else {
          emit(SignupFailureState(message: 'Mật khẩu không đúng định dạng', failurePhone: false));
        }
        emit(SignupFailureState(message: 'Có lỗi xảy ra vui lòng thử lại khi đăng ký'));
      } else {
        emit(SignupFailureState(message: 'Có lỗi xảy ra vui lòng thử lại'));
      }
    } catch (e) {
      emit(SignupErrorState(message: 'Có lỗi xảy ra vui lòng thử lại. Chúng tôi hông thể đăng ký tài khoản của bạn'));
    }
  }

  FutureOr<void> _onSignupVerifyEvent(VerifyCodeEvent event, Emitter<SignupState> emit) async {
    emit(SignupVerifyLoadingState());
    Logger().i(event.code, event.phone);
    try {
      ApiResponse response = await authRepository.checkVerifyCode(
        phone: event.phone,
        code: event.code,
      );
      if (response.code == '1000') {
        authUser = AuthModel.fromJson(response.data);
        token = authUser!.token!;
        Logger().i(token);
        emit(SignupVerifySuccessState());
      } else if (response.code == '9996') {
        emit(SignupVerifyFailureState(message: 'Số điện thoại đã được đăng ký'));
      } else if (response.code == '1004') {
        emit(SignupVerifyFailureState(message: 'Mã xác thực không đúng'));
      } else {
        emit(SignupVerifyFailureState(message: 'Có lỗi xảy ra vui lòng thử lại'));
      }
    } catch (e) {
      emit(SignupVerifyFailureState(message: 'Chúng tôi hông thể đăng ký tài khoản của bạn'));
    }
  }

  FutureOr<void> _onSignupGetCodeVerifyEvent(SignupGetCodeVerifyEvent event, Emitter<SignupState> emit) async {
    final phone = event.phone;
    emit(SignupVerifyLoadingState());
    try {
      ApiResponse response = await authRepository.getVerifyCode(phone: phone);
      Logger().i(response);
      if (response.code == '1000') {
        // emit(SignupVerifySuccessState());
        final code = response.getData('verifyCode');
        emit(SignupVerifyCodeState(code: code, phone: phone));
      }
      if (response.code == '1010') {
        // response.details = "Await 116.292s"
        emit(AwaitVerifyState(phone: phone, seconds: 120));
      } else {
        emit(SignupVerifyCodeState(code: '', phone: phone));
      }
    } catch (e) {
      emit(SignupVerifyCodeState(code: '', phone: phone));
    }
  }

  FutureOr<void> _onChangeInfoAfterSignup(ChangeInfoAfterSignup event, Emitter<SignupState> emit) async {
    if (state is SignupChangeInfoLoadingState) return;
    emit(SignupChangeInfoLoadingState());
    // try {
    ApiResponse response = await authRepository.changeIfnoAfterSignup(
      username: event.username,
      avatar: event.avatar ?? null,
    );
    Logger().i(response);
    if (response.code == null) {
      emit(SignupChangeInfoSuccessState());
    } else if (response.code == '1000') {
      authUser = AuthModel.fromJson(response.data);
      token = authUser!.token!;
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('authUser', json.encode(authUser!.toJson()));
      Logger().i(pref.getString('authUser'));
      emit(SignupChangeInfoSuccessState());
    } else {
      emit(SignupChangeInfoFailureState(message: 'Có lỗi xảy ra vui lòng thử lại'));
    }
    // } catch (e) {
    //   Logger().e(e);
    //   emit(SignupChangeInfoFailureState(message: 'Có lỗi xảy ra vui lòng thử lại'));
    // }
  }
}

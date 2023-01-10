import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fb_copy/models/user_model.dart';
import 'package:fb_copy/repositories/api_repository.dart';
import 'package:fb_copy/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthRepository repo;

  LoginBloc(this.repo) : super(LoginInitialState()) {
    on<LoginButtonPress>((event, emit) async {
      emit(LoginLoadingState());
      try {
        final ApiResponse response = await repo.login(event.phone, event.password);
        print('asass ' +
            response.data.toString() +
            ' ' +
            (response.code).toString() +
            ' ' +
            (response.code == '1000').toString());
        if (response.code == '1000') {
          // Map<String, dynamic> data = json.decode(response.data);

          UserModel user = UserModel.fromJson(response.data as Map<String, dynamic>);
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString('token', user.token ??= '');
          // pref.setString('user_logig', user.toJson().toString());
          emit(LoginSuccessState());
        } else if (response.code == '9995' || response.code == '1004') {
          emit(LoginErrorState(message: '${response.details}'));
        } else {
          emit(LoginErrorState(message: 'Server Error: ${response.message}}'));
        }
      } catch (e) {
        Logger().e(e);
        emit(LoginFailureState(message: 'Server Error :::'));
      }
    });
  }
  // LoginBloc(LoginState initialSate, this.repo) : super(LoginInitialState());
  // @override
  // Stream<LoginState> mapEventToState(LoginEvent event) async* {
  //   var pref = await SharedPreferences.getInstance();
  //   if (event is LoginInitial) {
  //     yield LoginInitialState();
  //     // } else if (event is LoginLoading) {
  //     //   yield LoginLoadingState();
  //   } else if (event is LoginButtonPress) {
  //     yield LoginLoadingState();
  //     try {
  //       final ApiResponse response =
  //           await repo.login(event.phone, event.password);
  //       print(response.data);
  //       if (response.codeStatus == 200) {
  //         // String token = response.data ??= '';
  //         UserModel user = response.data as UserModel;
  //         pref.setString('token', user.token ??= '');
  //         pref.setString('user_logig', user.toJson().toString());
  //         yield LoginSuccessState();
  //       } else {
  //         yield LoginFailureState();
  //       }
  //     } catch (e) {
  //       yield LoginErrorState(message: e.toString());
  //     }
  //   } else if (event is LoginFailure) {
  //     yield LoginFailureState();
  //   }
  // }

  @override
  Future<void> close() {
    return super.close();
  }
}

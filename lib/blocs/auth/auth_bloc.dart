import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fb_copy/constants.dart';
import 'package:fb_copy/models/auth_model.dart';
import 'package:fb_copy/repositories/api_repository.dart';
import 'package:fb_copy/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late SharedPreferences _prefs;

  AuthBloc() : super(AuthInitialState()) {
    // on<AuthEvent>((event, emit) {});
    on<AuthInitEvent>(
      (event, emit) async {
        // emit(AuthInitialState());
        try {
          _prefs = await SharedPreferences.getInstance();
          if (_prefs.containsKey('authUser')) {
            Logger().d(_prefs.getString('authUser'));
            authUser = AuthModel.fromJson(json.decode(_prefs.getString('authUser')!));
            // token = authUser!.token!;

            AuthRepository repository = AuthRepository();
            add(AuthCheckExpiredEvent());
          } else {
            emit(UnAuthState());
          }
        } catch (e) {
          Logger().e(e);
          emit(UnAuthState());
        }
      },
    );
    on<AuthLogoutEvent>((event, emit) async {
      emit(AuthInitialState());
      try {
        // _prefs = await SharedPreferences.getInstance();
        token = '';
        if (_prefs.containsKey('authUser')) {
          _prefs.remove('authUser');
          emit(UnAuthState());
        } else {
          emit(UnAuthState());
        }
      } catch (e) {
        Logger().e(e);
        emit(UnAuthState());
      }
    });

    on<AuthCheckExpiredEvent>((event, emit) async {
      emit(AuthInitialState());
      try {
        AuthRepository repository = AuthRepository();
        ApiResponse apiResponse = await repository.checkNewVersion();
        if (apiResponse.code == '1000') {
          emit(AuthSuccessState(user: authUser));
        } else {
          emit(AuthExpiredState());
        }
      } catch (e) {
        Logger().e(e);
        emit(UnAuthState());
      }
    });
  }
}

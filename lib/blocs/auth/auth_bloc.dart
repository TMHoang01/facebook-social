import 'package:equatable/equatable.dart';
import 'package:fb_copy/models/user_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SharedPreferences _prefs;

  AuthenticationBloc({required SharedPreferences prefs})
      : _prefs = prefs,
        super(AuthenticationInitialState());

  // AuthenticationState get initialState => _prefs.containsKey('user')
  //     ? AuthenticationAuthenticatedState(
  //         user: UserModel.fromJson(_prefs.getString('user'))
  //     : AuthenticationUnauthenticatedState();

  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationLoginEvent) {
      // Lưu thông tin người dùng vào SharedPreferences
      // _prefs.setString('user', event.user.toJson());
      yield AuthenticationAuthenticatedState(user: event.user);
    } else if (event is AuthenticationLogoutEvent) {
      // Xóa thông tin người dùng khỏi SharedPreferences
      _prefs.remove('user');
      yield AuthenticationUnauthenticatedState();
    }
  }
}

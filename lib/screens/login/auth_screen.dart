import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../blocs/auth/auth_bloc.dart';

class AuthScreen extends StatefulWidget {
  final SharedPreferences prefs;

  AuthScreen({super.key, required this.prefs});
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final authBloc = AuthenticationBloc(prefs: widget.prefs);
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationInitialState) {
          // Hiển thị giao diện chờ nếu chưa có thông tin người dùng
          // return LoadingIndicator();
        } else if (state is AuthenticationAuthenticatedState) {
          // Hiển thị giao diện đăng nhập thành công với thông tin người dùng
          // return UserInfo(user: state.user);
        } else if (state is AuthenticationUnauthenticatedState) {
          // Hiển thị giao diện chưa đăng nhập
          // return LoginForm();
        }
        return Container();
      },
    );
  }
}

// BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLoginEvent(user: user));
// BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLogoutEvent());
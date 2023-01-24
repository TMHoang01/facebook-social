import 'package:fb_copy/screens/home/home_screen.dart';
import 'package:fb_copy/screens/login/login_screen.dart';
import 'package:fb_copy/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../blocs/auth/auth_bloc.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({super.key});
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    // final authBloc = BlocProvider.of<AuthBloc>(context).add(AuthInitEvent());
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthInitialState) {
          // Hiển thị giao diện chờ nếu chưa có thông tin người dùng
          print('AuthInitialState AuthScreen');
          return const SplashScreen();
        } else if (state is AuthSuccessState) {
          // Hiển thị giao diện chưa đăng nhập
          print('AuthSuccessState AuthScreen');
          return const HomeScreen();
        } else if (state is UnAuthState) {
          // Hiển thị giao diện chưa đăng nhập
          print('UnAuthState AuthScreen');
          return const LoginScreen();
        } else if (state is AuthExpiredState) {
          print('AuthExpiredState AuthScreen');
          return const LoginScreen();
        } else {
          print('Auth else AuthScreen');
          return const SplashScreen();
        }

        return const SplashScreen();
      },
    );
  }
}

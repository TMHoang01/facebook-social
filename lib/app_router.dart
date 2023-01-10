import 'package:fb_copy/screens/home/home_screen.dart';
import 'package:fb_copy/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
      // return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());

      default:
      // return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }
}

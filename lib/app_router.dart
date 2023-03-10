import 'package:fb_copy/models/post_model.dart';
import 'package:fb_copy/screens/comment/comment_screen.dart';
import 'package:fb_copy/screens/home/home_screen.dart';
import 'package:fb_copy/screens/login/auth_screen.dart';
import 'package:fb_copy/screens/login/login_screen.dart';
import 'package:fb_copy/screens/post/add_post_screen.dart';
import 'package:fb_copy/screens/post/edit_post_screen.dart';
import 'package:fb_copy/screens/signup/signup_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => AuthScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case '/signup/phone':
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case '/signup/otp':
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case '/signup/complete':
        return MaterialPageRoute(builder: (_) => SignupScreen());

      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/add-post':
        return MaterialPageRoute(builder: (_) => AddPostScreen());
      case '/edit-post:id':
        var post = settings.arguments as PostModel;
        var id = post.id;
        return MaterialPageRoute(builder: (_) => EditPostScreen(post: post));
      case '/comment:id':
        var post = settings.arguments as PostModel;
        var id = post.id;
        return MaterialPageRoute(builder: (_) => CommentScreen(post: post));
      default:
        return MaterialPageRoute(builder: (_) => AuthScreen());
    }
  }
}

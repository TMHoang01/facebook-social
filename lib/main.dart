// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fb_copy/blocs/auth/auth_bloc.dart';
import 'package:fb_copy/blocs/internet/internet_bloc.dart';
import 'package:fb_copy/blocs/login/login_bloc.dart';
import 'package:fb_copy/blocs/picker_image/picker_image_bloc.dart';
import 'package:fb_copy/blocs/post/post_bloc.dart';
import 'package:fb_copy/repositories/auth_repository.dart';
import 'package:fb_copy/repositories/post_repository.dart';
import 'package:fb_copy/screens/home/home_screen.dart';
import 'package:fb_copy/screens/login/auth_screen.dart';
import 'package:fb_copy/screens/login/login_screen.dart';
import 'package:fb_copy/screens/post/add_post_screen.dart';
import 'package:fb_copy/screens/post/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fb_copy/app_router.dart';
import 'package:fb_copy/blocs/AppBlocObserver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timeago/timeago.dart' as timeago;

main() {
  Bloc.observer = AppBlocObserver();
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(AuthRepository()),
        ),
        BlocProvider(
          create: (context) => InternetBloc(),
        ),
        BlocProvider(
          create: (context) => PostBloc(PostRepository()),
        ),
        BlocProvider(
          create: (context) => PickerImageBloc(ImagePicker()),
        ),
        BlocProvider(
          create: (context) => AuthBloc()..add(AuthInitEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Facebook',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: appRouter.generateRoute,
        home: BlocListener<InternetBloc, InternetState>(
          listenWhen: (previous, current) => (previous is! InternetInitialState),
          listener: (context, state) {
            // TODO: implement listener
            if (state is ConnectionInternetState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.wifi_outlined, size: 24.0, color: Colors.green),
                      const SizedBox(width: 16.0),
                      Text(state.message, style: const TextStyle(fontSize: 16.0)),
                    ],
                  ),
                ),
              );
            } else if (state is NotConnectionInternetState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.wifi_off_outlined, size: 24.0, color: Colors.white),
                      const SizedBox(width: 16.0),
                      Text(state.message, style: const TextStyle(fontSize: 16.0)),
                    ],
                  ),
                ),
              );
            }
          },
          child: AuthScreen(),
          // child: LoginScreen(),
        ),
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fb_copy/blocs/internet/internet_bloc.dart';
import 'package:fb_copy/blocs/login/login_bloc.dart';
import 'package:fb_copy/blocs/picker_image/picker_image_bloc.dart';
import 'package:fb_copy/blocs/post/post_bloc.dart';
import 'package:fb_copy/repositories/auth_repository.dart';
import 'package:fb_copy/repositories/post_repository.dart';
import 'package:fb_copy/screens/home/home_screen.dart';
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
        BlocProvider(create: (context) => PickerImageBloc(ImagePicker())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // onGenerateRoute: appRouter.generateRoute,
        home: BlocListener<InternetBloc, InternetState>(
          listenWhen: (previous, current) => (previous is! InternetInitialState),
          listener: (context, state) {
            // TODO: implement listener
            if (state is ConnectionInternetState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            } else if (state is NotConnectionInternetState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: HomeScreen(),
          // child: LoginScreen(),
        ),
      ),
    );
  }
}

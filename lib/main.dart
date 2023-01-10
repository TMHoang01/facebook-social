// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fb_copy/blocs/internet/internet_bloc.dart';
import 'package:fb_copy/blocs/login/login_bloc.dart';
import 'package:fb_copy/blocs/post/post_bloc.dart';
import 'package:fb_copy/models/post_model.dart';
import 'package:fb_copy/repositories/auth_repository.dart';
import 'package:fb_copy/screens/home/home_screen.dart';
import 'package:fb_copy/screens/login/login_screen.dart';
import 'package:fb_copy/screens/post/post_screen.dart';
import 'package:fb_copy/screens/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fb_copy/app_router.dart';
import 'package:fb_copy/blocs/AppBlocObserver.dart';

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
          create: (context) => PostBloc()
            ..add(AddPost(
                post: PostModel(
                    id: '123', author: 'userId', title: 'title', described: 'bodyda ', like: '0', comment: '0'))),
        ),
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
        ),
      ),
    );
  }
}

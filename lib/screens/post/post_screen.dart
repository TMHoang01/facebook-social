import 'package:cached_network_image/cached_network_image.dart';
import 'package:fb_copy/blocs/post/post_bloc.dart';
import 'package:fb_copy/constants.dart';
import 'package:fb_copy/models/post_model.dart';
import 'package:fb_copy/screens/loading_screen.dart';
import 'package:fb_copy/screens/post/components/create_feed_widget.dart';
import 'package:fb_copy/widgets/diverder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  // late List<PostModel> taskList;
  void _addPost(BuildContext context) {
    showModalBottomSheet(context: context, builder: (context) => SingleChildScrollView());
  }

  @override
  Widget build(BuildContext context) {
    final _loadingLogin = ValueNotifier<bool>(false);

    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(children: [
          CreateFeedWidget(),
          DivederApp(),
        ]),
      ),
    );
  }
}

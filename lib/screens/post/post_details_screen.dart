// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fb_copy/models/post_model.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PostDetails extends StatefulWidget {
  PostModel post;
  PostDetails({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

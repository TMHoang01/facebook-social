// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fb_copy/models/post_model.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PostDetailScreen extends StatefulWidget {
  PostModel post;
  PostDetailScreen({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

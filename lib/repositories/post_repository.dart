import 'dart:convert';
import 'dart:io';

import 'package:fb_copy/models/post_model.dart';

class PostRepository {
  Future<List<PostModel>> fetchPosts() async {
    // get post form post.txt
    // return List<PostModel>.generate(10, (index) => PostModel());
    List<PostModel> posts = [];

    return posts;
  }

  Future<List<PostModel>> readPosts() async {
    final file = File('posts.txt');
    String contents = await file.readAsString();
    final jsonResponse = json.decode(contents);
    return (jsonResponse as List).map((i) => PostModel.fromJson(i)).toList();
  }
}

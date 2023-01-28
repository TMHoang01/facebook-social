// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:fb_copy/models/comment_model.dart';
import 'package:fb_copy/untils/format_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:fb_copy/blocs/comment/comment_bloc.dart';
import 'package:fb_copy/blocs/post/post_bloc.dart';
import 'package:fb_copy/constants.dart';
import 'package:fb_copy/models/post_model.dart';
import 'package:fb_copy/repositories/comment_repository.dart';

class CommentScreen extends StatelessWidget {
  final PostModel post;

  CommentScreen({
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommentBloc(
        postModel: post,
        commentRepository: CommentRepository(),
      )..add(LoadCommentEvent()),
      child: Container(
        height: MediaQuery.of(context).size.height - 32.0,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: <Widget>[
            _CommentHeader(post: post),
            Divider(
              height: 1.0,
              color: Colors.grey[300],
            ),
            Expanded(
              child: _CommentList(),
            ),
            Divider(
              height: 1.0,
              color: Colors.grey[300],
            ),
            _CommentInput(),
          ],
        ),
      ),
    );
  }
}

class _CommentHeader extends StatelessWidget {
  late final PostModel post;
  _CommentHeader({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostModel post =
        context.select((PostBloc bloc) => bloc.state.listPosts.firstWhere((element) => element.id == this.post.id));
    PostBloc postBloc = context.read<PostBloc>();
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0, bottom: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(4.0),
                decoration: const BoxDecoration(
                  color: AppColor.kPrimaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.thumb_up,
                  size: 10.0,
                  color: Colors.white,
                ),
              ),
              Text(
                  ' ${(post.like == "1" && post.isLiked == "1") ? authUser!.username : (int.parse(post.like!) < 100 && post.isLiked == "1") ? "Bạn và ${int.parse(post.like!) - 1} người khác" : post.like}'),
            ],
          ),
          Row(
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    postBloc.add(LikePostEvent(post: post));
                  },
                  icon: post.isLiked == "1"
                      ? const Icon(
                          Icons.thumb_up,
                          color: AppColor.kPrimaryColor,
                          size: 24.0,
                        )
                      : const Icon(
                          MdiIcons.thumbUpOutline,
                          color: AppColor.kColorButton,
                          size: 24.0,
                        ))
            ],
          ),
        ],
      ),
    );
  }
}

class _CommentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        if (state is CommentLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CommentLoadedState) {
          List<CommentModel> listComments = state.listComments;
          if (listComments.isEmpty) {
            return Center(child: Text("Không có comment"));
          }
          return ListView.builder(
            itemCount: state.listComments.length,
            itemBuilder: (context, index) {
              CommentModel comment = listComments[index];
              return _ItemComment(comment: comment);
            },
          );
        } else {
          return Center(child: Text("Không có comment"));
        }
      },
    );
  }
}

class _ItemComment extends StatelessWidget {
  const _ItemComment({
    super.key,
    required this.comment,
  });

  final CommentModel comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0, bottom: 6.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  comment.poster!.avatar != null
                      ? CircleAvatar(
                          radius: 15,
                          backgroundImage: NetworkImage(comment.poster!.avatar!),
                        )
                      : CircleAvatar(
                          radius: 15,
                          backgroundImage: AssetImage("assets/images/avatar_default.png"),
                        ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          comment.poster!.username!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          comment.comment!,
                          style: TextStyle(
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              Text(
                FormatTimeApp().getCustomFormat(comment.created!),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CommentInput extends StatefulWidget {
  @override
  _CommentInputState createState() => _CommentInputState();
}

class _CommentInputState extends State<_CommentInput> {
  final _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
      // height: 54.0,
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                // height: 44.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: TextField(
                    minLines: 1,
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    textAlignVertical: TextAlignVertical.bottom,
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: "Viết bình luận...",
                      // contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),

                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                BlocProvider.of<CommentBloc>(context).add(AddCommentEvent(
                  comment: _commentController.text,
                ));
                _commentController.clear();
              },
            )
          ],
        ),
      ),
    );
  }
}

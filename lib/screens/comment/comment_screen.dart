// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shimmer/shimmer.dart';

import 'package:fb_copy/blocs/comment/comment_bloc.dart';
import 'package:fb_copy/blocs/post/post_bloc.dart';
import 'package:fb_copy/constants.dart';
import 'package:fb_copy/models/comment_model.dart';
import 'package:fb_copy/models/post_model.dart';
import 'package:fb_copy/repositories/comment_repository.dart';
import 'package:fb_copy/untils/format_time.dart';

class CommentScreen extends StatelessWidget {
  final PostModel post;
  ScrollController? scrollController;

  CommentScreen({
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    final _commentController = TextEditingController();

    PostModel post =
        context.select((PostBloc bloc) => bloc.state.listPosts.firstWhere((element) => element.id == this.post.id));
    PostBloc postBloc = context.read<PostBloc>();
    return BlocProvider(
      create: (context) => CommentBloc(
        postModel: post,
        commentRepository: CommentRepository(),
      )..add(LoadCommentEvent()),
      child: Builder(builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height - 32.0,
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: <Widget>[
              _CommentHeader(post: post),
              Divider(height: 1.0, color: Colors.grey[300]),
              Expanded(
                child: _CommentList(),
              ),
              Divider(height: 1.0, color: Colors.grey[300]),
              Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                        child: TextField(
                          minLines: 1,
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          textAlignVertical: TextAlignVertical.bottom,
                          controller: _commentController,
                          decoration: InputDecoration(
                            hintText: "Viết bình luận...",
                            contentPadding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0),
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide.none),
                            filled: true,
                            // fillColor: Colors.grey[200],
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, size: 24),
                      onPressed: () async {
                        BlocProvider.of<CommentBloc>(context).add(AddCommentEvent(
                          comment: _commentController.text,
                        ));
                        _commentController.clear();

                        // postBloc.add(GetPostByIdEvent(id: post.id!));
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }),
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
    CommentBloc commentBloc = context.read<CommentBloc>();
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

class _CommentList extends StatefulWidget {
  _CommentList({
    Key? key,
  }) : super(key: key);

  @override
  State<_CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<_CommentList> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        if (state is CommentInitialState) {
          return _LoadingListComment();
        } else if (state is CommentLoadedState || state is CommentLoadingState) {
          List<CommentModel> listComments = List.from(state.listComments);
          listComments.add(CommentModel());
          // print(listComments[0].comment);
          if (listComments.length <= 1) {
            return Center(child: Text("Hiện chưa có comment nào"));
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.separated(
                  controller: _scrollController,
                  itemCount: listComments.length,
                  itemBuilder: (context, index) {
                    CommentModel comment = listComments[index];
                    if (comment.poster != null) return _ItemComment(comment: comment);
                    // else
                    // return Text('Binh luận này đã bị xóa');
                  },
                  separatorBuilder: (context, index) {
                    if (index == listComments.length - 2 && state is CommentLoadedState && state.isNotComment == true) {
                      return TextButton(
                        onPressed: () {
                          // Code to load more comments
                          context.read<CommentBloc>().add(LoadMoreCommentEvent());
                        },
                        child: Text('Xem thêm bình luận', textAlign: TextAlign.start),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          );
        } else {
          return Center(child: Text("Không có comment"));
        }
      },
    );
  }
}

class _LoadingListComment extends StatelessWidget {
  const _LoadingListComment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 8,
            itemBuilder: (context, index) => _LoadingItemComment(),
          ),
        ),
      ],
    );
  }
}

class _LoadingItemComment extends StatelessWidget {
  const _LoadingItemComment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: CircleAvatar(
                      radius: 20,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: Random().nextDouble() * (80 - 30) + 30,
                            width: Random().nextDouble() * (240 - 50) + 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4.0),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
    if (comment.id == null) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 6.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  comment.poster!.avatar != null
                      ? CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(comment.poster!.avatar!),
                        )
                      : CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage("assets/images/avatar_default.png"),
                        ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
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
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            FormatTimeApp().getCustomFormat(comment.created!),
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class _CommentInput extends StatefulWidget {
//   _CommentInput({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _CommentInputState createState() => _CommentInputState();
// }

// class _CommentInputState extends State<_CommentInput> {
//   final _commentController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//       child: Row(
//         children: <Widget>[
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
//               child: TextField(
//                 minLines: 1,
//                 maxLines: 3,
//                 keyboardType: TextInputType.multiline,
//                 textAlignVertical: TextAlignVertical.bottom,
//                 controller: _commentController,
//                 decoration: InputDecoration(
//                   hintText: "Viết bình luận...",
//                   contentPadding: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0),
//                   hintStyle: TextStyle(color: Colors.grey[400]),
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide.none),
//                   filled: true,
//                   fillColor: Colors.grey[200],
//                 ),
//               ),
//             ),
//           ),
//           IconButton(
//             icon: Icon(
//               Icons.send,
//               size: 24,
//             ),
//             onPressed: () {
//               BlocProvider.of<CommentBloc>(context).add(AddCommentEvent(
//                 comment: _commentController.text,
//               ));
//               _commentController.clear();
//             },
//           )
//         ],
//       ),
//     );
//   }
// }

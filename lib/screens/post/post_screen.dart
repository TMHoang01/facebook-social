import 'package:cached_network_image/cached_network_image.dart';
import 'package:fb_copy/blocs/post/post_bloc.dart';
import 'package:fb_copy/constants.dart';
import 'package:fb_copy/models/post_model.dart';
import 'package:fb_copy/screens/loading_screen.dart';
import 'package:fb_copy/screens/post/components/create_feed_widget.dart';
import 'package:fb_copy/screens/post/components/post_widget.dart';
import 'package:fb_copy/widgets/diverder_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

// class _PostScreenState extends State<PostScreen> with AutomaticKeepAliveClientMixin {
//   @override
//   bool get wantKeepAlive => true;

//   // late List<PostModel> taskList;
//   void _addPost(BuildContext context) {
//     showModalBottomSheet(context: context, builder: (context) => SingleChildScrollView());
//   }
class _PostScreenState extends State<PostScreen> {
  late PostBloc _postBloc;
  @override
  void initState() {
    _postBloc = BlocProvider.of<PostBloc>(context)..add(LoadPostEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _postBloc.add(LoadPostEvent(isRefresh: true));
      },
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          List<PostModel> postList = state.listPosts;
          if (state is PostErrorState) {
            return Center(
              child: ElevatedButton(
                  onPressed: () {
                    _postBloc.add(LoadPostEvent());
                  },
                  child: Text('Error')),
            );
          }
          return postList.isEmpty
              ? LoadingScreen(text: 'Loading post...')
              : CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: CreateFeedWidget(),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          PostModel post = postList[index];

                          if (index == postList.length - 5 && state is PostLoadedState && state.isNotPost != true) {
                            _postBloc.add(LoadPostEvent());
                          }
                          return Column(
                            children: [
                              // Container(
                              //   height: 100,
                              //   child: Center(child: Text(index.toString() + '     ' + post.described.toString())),
                              // ),
                              PostWidget(post: post),
                              DivederApp(),
                            ],
                          );
                        },
                        childCount: postList.length,
                      ),
                    ),

                    (state is PostLoadedState && state.isNotPost == true)
                        ? SliverToBoxAdapter(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('No more post', style: TextStyle(color: Colors.grey, fontSize: 20)),
                              ),
                            ),
                          )
                        : SliverToBoxAdapter(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),

                    // state is PostErrorMoreState
                    //     ? SliverToBoxAdapter(
                    //         child: Center(
                    //           child: ElevatedButton(
                    //               onPressed: () {
                    //                 _postBloc.add(LoadPostEvent());
                    //               },
                    //               child: Text('Error')),
                    //         ),
                    //       )
                    //     : SliverToBoxAdapter(
                    //         child: Center(
                    //           child: CircularProgressIndicator(),
                    //         ),
                    //       ),
                  ],
                );
        },
      ),
    );
  }
}

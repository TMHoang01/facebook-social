import 'package:cached_network_image/cached_network_image.dart';
import 'package:fb_copy/models/auth_model.dart';
import 'package:fb_copy/widgets/profile_avatar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:logger/logger.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_rich_text/easy_rich_text.dart';

import 'package:fb_copy/blocs/internet/internet_bloc.dart';
import 'package:fb_copy/blocs/post/post_bloc.dart';
import 'package:fb_copy/constants.dart';
import 'package:fb_copy/models/post_model.dart';
import 'package:fb_copy/screens/comment/comment_screen.dart';
import 'package:fb_copy/screens/user/profile_screen.dart';
import 'package:fb_copy/screens/post/components/post_button.dart';
import 'package:fb_copy/screens/post/components/images_widget.dart';
import 'package:fb_copy/screens/post/edit_post_screen.dart';
import 'package:fb_copy/screens/post/post_details_screen.dart';
import 'package:fb_copy/widgets/bottomsheet_widget.dart';
import 'package:fb_copy/widgets/diaog_widget.dart';

class PostWidget extends StatelessWidget {
  final PostModel post;

  PostWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InternetBloc internetBloc = BlocProvider.of<InternetBloc>(context);
    PostBloc postBloc = BlocProvider.of<PostBloc>(context);
    if (postBloc.state.listPosts.firstWhere((element) => element.id == this.post!.id) == null) {
      PostModel post = context.select((PostBloc bloc) => bloc.state.listPosts.firstWhere(
            (element) => element.id == this.post!.id,
          ));
    }
    return Container(
      width: double.infinity,
      // height: 300.0,
      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      AuthModel user = AuthModel(
                        id: post.author?.id,
                        username: post.author?.username,
                        avatar: post.author?.avatar,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(user: user),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 20.0,
                      child: CachedNetworkImage(
                          imageUrl: post.author?.avatar ?? '',
                          imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
                                ),
                              ),
                          fit: BoxFit.fill,
                          placeholder: (context, url) => const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Image.asset('assets/images/avatar_default.png')),
                    ),
                  ),
                  // ProfileAvatar(avatar: post.author?.avatar),
                  // : const AssetImage('assets/images/avatar_default.png'),

                  const SizedBox(width: 7.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          print(
                              'id: ${post.id} author name: ${authUser!.id} author id: ${post.author?.id} avatar: ${post.author?.avatar}');
                          AuthModel user = AuthModel(
                            id: post.author?.id,
                            username: post.author?.username,
                            avatar: post.author?.avatar,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(user: user),
                            ),
                          );
                        },
                        child: Text('${post.author?.username ?? 'Người dùng Facebook'}',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0)),
                      ),
                      const SizedBox(height: 5.0),
                      Text(post.created ?? 'vừa mới đây')
                    ],
                  ),
                ],
              ),
              SettingPostIcon(post: post, internetBloc: internetBloc),
            ],
          ),
          const SizedBox(height: 20.0),
          // Text(post.described ?? '', style: TextStyle(fontSize: 15.0)),
          ContentPostView(post: post),
          const SizedBox(height: 10.0),
          ImagesPost(post: post),
          Row(
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
                    ' ${post.like != null && post.isLiked != null ? (post.like == "1" && post.isLiked == "1") ? (authUser?.username ?? "Bạn") : (int.parse(post.like!) < 100 && post.isLiked == "1") ? "Bạn và ${int.parse(post.like!) - 1} người khác" : post.like : ""}',
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('${post.comment ?? 0} bình luận'),
                ],
              ),
            ],
          ),
          const Divider(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            // textDirection: TextDirection.ltr,
            children: <Widget>[
              PostButton(
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
                      ),
                label: Text(
                  textAlign: TextAlign.center,
                  'Thích',
                  style: TextStyle(
                      color: post.isLiked == "1" ? AppColor.kPrimaryColor : AppColor.kColorTextNormal, fontSize: 16.0),
                ),
                onTap: () {
                  postBloc.add(LikePostEvent(post: post));
                },
              ),
              PostButton(
                  icon: const Icon(
                    MdiIcons.commentOutline,
                    color: AppColor.kColorButton,
                    size: 20.0,
                  ),
                  label: const Text('Bình luận'),
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) {
                    //   return CommentScreen(
                    //     post: post,
                    //   );
                    // }));
                    showModalFullSheet(
                      context,
                      [
                        WillPopScope(
                          onWillPop: () async {
                            postBloc.add(GetPostByIdEvent(id: post.id!));
                            return true;
                          },
                          child: CommentScreen(post: post),
                        ),
                      ],
                    );
                  }),
            ],
          )
        ],
      ),
    );
  }
}

class ContentPostView extends StatefulWidget {
  ContentPostView({
    super.key,
    required this.post,
    this.isShowMore,
  });

  final PostModel post;
  bool? isShowMore;

  @override
  State<ContentPostView> createState() => _ContentPostViewState();
}

class _ContentPostViewState extends State<ContentPostView> {
  bool isShowMore = false;
  GlobalKey sizedBoxKey = GlobalKey();

  PostModel? post;
  @override
  void initState() {
    super.initState();
    post = widget.post;
    isShowMore = widget.isShowMore ?? false;
  }

  @override
  Widget build(BuildContext context) {
    // check post in state.listPost is null
    PostBloc postBloc = BlocProvider.of<PostBloc>(context);

    if (postBloc.state.listPosts.firstWhere((element) => element.id == this.post!.id) == null) {
      PostModel post = context.select((PostBloc bloc) => bloc.state.listPosts.firstWhere(
            (element) => element.id == this.post!.id,
          ));
    }
    String text = post!.described ?? '';
    // text = text.split('\n').length.toString();
    // double height = sizedBoxKey.currentContext!.size!.height;

    if (text.length > 100) {
      if (isShowMore) {
        text = text;
      }
      // check text iss more 3 new line
      else {
        // Logger().i(text.split('\n').sublist(0, 3).join('\n'));
        if (text.split('\n').length > 3) text = text.split('\n').sublist(0, 3).join('\n');
        // text = text + ' ...' + ' Xem thêm';
        // Logger().i(text);
        text = text.substring(0, 100) + ' ...' + ' Xem thêm';
      }
    }
    return InkWell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            // height: isShowMore == true ? null : 75.0,
            key: sizedBoxKey,
            child: EasyRichText(
              '$text',
              defaultStyle: const TextStyle(
                fontSize: 16.0,
                color: AppColor.kColorTextNormal,
              ),
              // selectable: true,
              patternList: [
                EasyRichTextPattern(
                  targetString: EasyRegexPattern.webPattern,
                  urlType: 'web',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: AppColor.kPrimaryColor,
                  ),
                ),
                EasyRichTextPattern(
                  //kiểm tra 'Xem thêm' có ở cuối câu không

                  targetString: r"Xem thêm\b",
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: AppColor.kPrimaryColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      setState(
                        () {
                          isShowMore = !isShowMore;
                        },
                      );
                    },
                ),
              ],
            ),
          ),
          // Divider(
          //   thickness: 1,
          // ),
          // SizedBox(
          //   width: double.infinity,
          //   // height: isShowMore == true ? null : 75.0,
          //   key: sizedBoxKey,
          //   child: Linkify(
          //     onOpen: (link) async {
          //       try {
          //         if (await canLaunchUrl(Uri.parse(link.url))) {
          //           await launchUrl(Uri.parse(link.url));
          //         } else {
          //           throw 'Could not launch $link';
          //         }
          //       } catch (e) {
          //         ScaffoldMessenger.of(context).showSnackBar(
          //           const SnackBar(
          //             content: Text('Không thể mở liên kết này'),
          //             duration: Duration(seconds: 2),
          //           ),
          //         );
          //       }
          //     },
          //     text: (text),
          //     style: const TextStyle(fontSize: 18.0, color: Colors.black, height: 1.5),
          //     linkStyle: const TextStyle(color: Colors.blue),
          //   ),
          // ),
        ],
      ),
      onLongPress: () {
        Clipboard.setData(ClipboardData(text: widget.post.described));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Đã copy văn bản vào bộ nhớ tạm'),
            duration: Duration(seconds: 2),
          ),
        );
      },
      onTap: () {
        // double height = -1;
        // height = sizedBoxKey.currentContext!.size!.height;
        // Logger().i('height: $height');
        Logger().i('shơw more');
        // Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailScreen(post: widget.post)));
        setState(() {
          isShowMore = !isShowMore;
        });
      },
    );
  }
}

class SettingPostIcon extends StatelessWidget {
  const SettingPostIcon({
    super.key,
    required this.post,
    required this.internetBloc,
  });

  final PostModel post;
  final InternetBloc internetBloc;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.more_horiz),
      onPressed: () {
        // print('id: ${post.id} author name: ${authUser!.id} author id: ${post.author?.id}');
        showModal(
          context,
          (post.author != null && authUser!.id != null && authUser!.id == post.author?.id)
              ? [
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text('Sửa bài viết'),
                    onTap: () {
                      Navigator.of(context).pop();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPostScreen(
                            post: post,
                          ),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text('Xóa bài viết'),
                    onTap: () => {
                      Navigator.of(context).pop(),
                      dialogConfirmBuilder(
                        context,
                        'Xác nhận xóa bài viết',
                        'Bạn có chắc chắn muốn xóa bài viết này không?',
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              child: const Text('Hủy'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Xóa'),
                              onPressed: () {
                                BlocProvider.of<PostBloc>(context).add(DeletePost(post: post));

                                // check internetBloc state is connected
                                // if (internetBloc.state is ConnectInternetEvent) {
                                //   print('delete post internetBloc.state is ConnectInternetEvent');
                                //   // Gọi hàm xóa bài viết tại đây
                                //   Navigator.of(context).pop();
                                //   BlocProvider.of<PostBloc>(context).add(DeletePost(post: post));
                                // } else {
                                //   print('delete post internetBloc.state is NotConnectInternetEvent');

                                //   // Navigator.of(context).pop();
                                //   // snack
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     const SnackBar(
                                //       content: Text(
                                //           'Chúng tôi hiện không thể thực hiện thao tác này. Vui lòng kiểm tra lại kết nối mạng của bạn!'),
                                //       duration: Duration(seconds: 2),
                                //     ),
                                //   );
                                // }
                              },
                            ),
                          ],
                        ),
                        () {},
                      ),
                    },
                  ),
                ]
              : [
                  ListTile(
                    leading: const Icon(Icons.report),
                    title: const Text('Báo cáo bài viết'),
                    onTap: () => {
                      // showModalFullSheet(
                      //   context,
                      //   [
                      //     ListTile(
                      //       leading: Icon(Icons.delete),
                      //       title: Text('Xóa bài viết'),
                      //       onTap: () => print('xóa bài viết'),
                      //     ),
                      //   ],
                      // )
                    },
                  ),
                ],
        );
      },
    );
  }
}

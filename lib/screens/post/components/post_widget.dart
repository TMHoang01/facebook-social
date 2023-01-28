// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:fb_copy/blocs/internet/internet_bloc.dart';
import 'package:fb_copy/blocs/post/post_bloc.dart';
import 'package:fb_copy/constants.dart';
import 'package:fb_copy/models/post_model.dart';
import 'package:fb_copy/screens/comment/comment_screen.dart';
import 'package:fb_copy/screens/post/components/post_button.dart';
import 'package:fb_copy/screens/post/components/images_widget.dart';
import 'package:fb_copy/screens/post/edit_post_screen.dart';
import 'package:fb_copy/screens/post/post_details_screen.dart';
import 'package:fb_copy/screens/web_view.dart';
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
    return Container(
      width: double.infinity,
      // height: 300.0,
      padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: <Widget>[
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar_default.png'),
                    radius: 20.0,
                  ),
                  const SizedBox(width: 7.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${post.author?.username ?? 'Người dùng fb'}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0)),
                      const SizedBox(height: 5.0),
                      Text(post.created ?? 'vừa mới đây')
                    ],
                  ),
                ],
              ),
              IconButton(
                icon: Icon(Icons.more_horiz),
                onPressed: () {
                  print('id: ${post.id} author name: ${authUser!.id} author id: ${post.author?.id}');
                  showModal(
                    context,
                    authUser!.id == post.author?.id
                        ? [
                            ListTile(
                              leading: Icon(Icons.edit),
                              title: Text('Sửa bài viết'),
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
                              leading: Icon(Icons.delete),
                              title: Text('Xóa bài viết'),
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
                                        child: Text('Hủy'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text('Xóa'),
                                        onPressed: () {
                                          // check internetBloc state is connected
                                          if (internetBloc.state is ConnectInternetEvent) {
                                            print('delete post internetBloc.state is ConnectInternetEvent');
                                            // Gọi hàm xóa bài viết tại đây
                                            Navigator.of(context).pop();
                                            BlocProvider.of<PostBloc>(context).add(DeletePost(post: post));
                                          } else {
                                            print('delete post internetBloc.state is NotConnectInternetEvent');

                                            // Navigator.of(context).pop();
                                            // snack
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Chúng tôi hiện không thể thực hiện thao tác này. Vui lòng kiểm tra lại kết nối mạng của bạn!'),
                                                duration: Duration(seconds: 2),
                                              ),
                                            );
                                          }
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
                              leading: Icon(Icons.report),
                              title: Text('Báo cáo bài viết'),
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
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          // Text(post.described ?? '', style: TextStyle(fontSize: 15.0)),
          SizedBox(
            width: double.infinity,
            child: InkWell(
              // width: double.infinity,
              onLongPress: () {
                Clipboard.setData(ClipboardData(text: post.described));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Đã copy văn bản vào bộ nhớ tạm'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostDetailScreen(
                      post: post,
                    ),
                  ),
                );
              },
              child: Linkify(
                onOpen: (link) async {
                  try {
                    if (await canLaunchUrl(Uri.parse(link.url))) {
                      await launchUrl(Uri.parse(link.url));
                    } else {
                      throw 'Could not launch $link';
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Không thể mở liên kết này'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                text: (post.described ?? ''),
                style: const TextStyle(fontSize: 18.0, color: Colors.black, height: 1.5),
                linkStyle: const TextStyle(color: Colors.blue),
              ),
            ),
          ),
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
                      ' ${(post.like == "1" && post.isLiked == "1") ? authUser!.username : (int.parse(post.like!) < 100 && post.isLiked == "1") ? "Bạn và ${int.parse(post.like!) - 1} người khác" : post.like}'),
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

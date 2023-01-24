// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fb_copy/blocs/internet/internet_bloc.dart';
import 'package:fb_copy/blocs/post/post_bloc.dart';
import 'package:fb_copy/constants.dart';
import 'package:fb_copy/screens/post/edit_post_screen.dart';
import 'package:fb_copy/screens/web_view.dart';
import 'package:fb_copy/widgets/bottomsheet_widget.dart';
import 'package:fb_copy/widgets/diaog_widget.dart';
import 'package:flutter/material.dart';

import 'package:fb_copy/models/post_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class PostWidget extends StatelessWidget {
  final PostModel post;

  PostWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InternetBloc internetBloc = BlocProvider.of<InternetBloc>(context);
    return Container(
      width: double.infinity,
      // height: 300.0,
      padding: EdgeInsets.all(15.0),
      child: Column(
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
                  print('id: ${post.id} author name: ${post.author?.username}');
                  showModal(
                    context,
                    1 == 1
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
                                          // Gọi hàm xóa bài viết tại đây
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                  () {},
                                ),
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.report),
                              title: Text('Báo cáo bài viết'),
                              onTap: () => {
                                Navigator.of(context).pop(),
                                showModalFullSheet(
                                  context,
                                  [
                                    ListTile(
                                      leading: Icon(Icons.delete),
                                      title: Text('Xóa bài viết'),
                                      onTap: () => print('xóa bài viết'),
                                    ),
                                  ],
                                )
                              },
                            ),
                          ]
                        : [
                            ListTile(
                              leading: Icon(Icons.report),
                              title: Text('Báo cáo bài viết'),
                              onTap: () => {
                                showModalFullSheet(
                                  context,
                                  [
                                    ListTile(
                                      leading: Icon(Icons.delete),
                                      title: Text('Xóa bài viết'),
                                      onTap: () => print('xóa bài viết'),
                                    ),
                                  ],
                                )
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
          SelectableLinkify(
            onOpen: (link) async {
              try {
                if (await canLaunchUrl(Uri.parse(link.url))) {
                  await launchUrl(Uri.parse(link.url));
                } else {
                  throw 'Could not launch $link';
                }
              } catch (e) {}
            },
            text: post.described ?? '',
            style: const TextStyle(fontSize: 15.0),
            linkStyle: const TextStyle(color: Colors.blue),
          ),
          const SizedBox(height: 10.0),
          post.image?.isNotEmpty == true
              ? InkWell(
                  onTap: () => {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      child: CachedNetworkImage(
                        imageUrl: post.image![0].url.toString(),
                        height: 350,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => SizedBox(
                          child: Container(
                            color: AppColor.grayColor,
                            height: 40,
                            width: 40,
                          ),
                          // width: MediaQuery.of(context).size.width,
                          // height: 300,
                        ),
                        errorWidget: (context, url, error) => SizedBox(
                          child: Container(
                            child: Icon(
                              Icons.error,
                              size: 40,
                            ),
                            color: AppColor.grayColor,
                          ),
                          // width: MediaQuery.of(context).size.width,
                          // height: 300,
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Icon(Icons.thumb_up_alt_outlined, size: 15.0, color: Colors.blue),
                  Text(' ${post.like ?? 0}'),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('${post.comment ?? 0} bình luận'),
                ],
              ),
            ],
          ),
          const Divider(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: const <Widget>[
                  Icon(Icons.thumb_up_alt_outlined, size: 20.0),
                  SizedBox(width: 5.0),
                  Text('Like', style: TextStyle(fontSize: 14.0)),
                ],
              ),
              Row(
                children: const <Widget>[
                  Icon(Icons.message_rounded, size: 20.0),
                  SizedBox(width: 5.0),
                  Text('Comment', style: TextStyle(fontSize: 14.0)),
                ],
              ),
              Row(
                children: const <Widget>[
                  Icon(Icons.shape_line_outlined, size: 20.0),
                  SizedBox(width: 5.0),
                  Text('Share', style: TextStyle(fontSize: 14.0)),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

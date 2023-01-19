// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fb_copy/constants.dart';
import 'package:flutter/material.dart';

import 'package:fb_copy/models/post_model.dart';

class PostWidget extends StatelessWidget {
  final PostModel post;

  PostWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 300.0,
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatar_default.png'),
                radius: 20.0,
              ),
              SizedBox(width: 7.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${post.author ?? 'Người dùng'}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0)),
                  SizedBox(height: 5.0),
                  Text('${post.created}')
                ],
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Text(post.described ?? '', style: TextStyle(fontSize: 15.0)),
          const SizedBox(height: 10.0),
          post.image?.isNotEmpty == true && post.image![0] != null
              ? InkWell(
                  onTap: () => {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      child: CachedNetworkImage(
                        imageUrl: post.image![0].url.toString(),
                        maxHeightDiskCache: 300,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => SizedBox(
                          child: Container(
                            color: AppColor.grayColor,
                            height: 40,
                            width: 40,
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                        ),
                        errorWidget: (context, url, error) => SizedBox(
                          child: Container(
                            child: Icon(
                              Icons.error,
                              size: 40,
                            ),
                            color: AppColor.grayColor,
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: 300,
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
                  Icon(Icons.thumb_up_alt_outlined, size: 15.0, color: Colors.blue),
                  Text(' ${post.like}'),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('${post.comment} bình luận'),
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

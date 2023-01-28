// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fb_copy/screens/post/post_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/services/clipboard.dart';

import 'package:fb_copy/models/post_model.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class TextWithReadMore extends StatefulWidget {
  // final String text;
  final Widget textWidget;
  PostModel post;
  TextWithReadMore({
    Key? key,
    required this.textWidget,
    required this.post,
  }) : super(key: key);

  @override
  _TextWithReadMoreState createState() => _TextWithReadMoreState();
}

class _TextWithReadMoreState extends State<TextWithReadMore> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: InkWell(
            // width: double.infinity,
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostDetailScreen(
                    post: widget.post,
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
              text: (widget.post.described ?? ''),
              style: const TextStyle(fontSize: 18.0, color: Colors.black, height: 1.5),
              linkStyle: const TextStyle(color: Colors.blue),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fb_copy/constants.dart';
import 'package:fb_copy/screens/post/add_post_screen.dart';
import 'package:flutter/material.dart';

class CreateFeedWidget extends StatelessWidget {
  const CreateFeedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Container(
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Container(
              child: ClipOval(
                child: Container(
                  width: 40,
                  height: 40,
                  color: Colors.grey,
                  child: CachedNetworkImage(
                    imageUrl: "https://store.donanimhaber.com/2a/71/96/2a7196fa4e85b977760a7f33586ee603.jpg",
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        CircularProgressIndicator(value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // navigate to create feed screen
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPostScreen()));
                },
                child: Container(
                  height: 36,
                  margin: EdgeInsets.only(left: 5),
                  padding: EdgeInsets.only(left: 20, right: 4),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  child: Text(
                    "Bạn đang nghĩ gì?",
                    style: TextStyle(color: AppColor.grayColor, fontSize: 16, height: 1.2),
                  ),
                ),
              ),
            ),
            Container(
              width: 28,
              height: 28,
              margin: EdgeInsets.all(8),
              child: Icon(
                Icons.image,
                color: AppColor.greenColor,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:fb_copy/constants.dart';
import 'package:fb_copy/screens/post/add_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:fb_copy/widgets/user_avatar_widget.dart';

class CreateFeedWidget extends StatelessWidget {
  const CreateFeedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: <Widget>[
            UserAvatarWidget(user: authUser!),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // navigate to create feed screen
                  // Logger().d(authUser.toString());
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPostScreen()));
                },
                child: Container(
                  height: 36,
                  margin: const EdgeInsets.only(left: 5),
                  padding: const EdgeInsets.only(left: 20, right: 4),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  child: const Text(
                    "Bạn đang nghĩ gì?",
                    style: TextStyle(color: AppColor.grayColor, fontSize: 16, height: 1.2),
                  ),
                ),
              ),
            ),
            Container(
              width: 28,
              height: 28,
              margin: const EdgeInsets.all(8),
              child: const Icon(
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

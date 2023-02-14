import 'package:cached_network_image/cached_network_image.dart';
import 'package:fb_copy/screens/user/profile_screen.dart';
import 'package:flutter/material.dart';

import 'package:fb_copy/constants.dart';
import 'package:fb_copy/models/auth_model.dart';

// ignore: must_be_immutable
class UserAvatarWidget extends StatelessWidget {
  AuthModel user;
  double? size;
  UserAvatarWidget({
    Key? key,
    required this.user,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => ProfileScreen(
      //         user: user,
      //       ),
      //     ),
      //   );
      // },
      child: ClipOval(
        child: Container(
          width: size ?? 40,
          height: size ?? 40,
          color: Colors.grey,
          child: CircleAvatar(
            radius: 20.0,
            child: CachedNetworkImage(
              imageUrl: user.avatar ?? "",
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
                ),
              ),
              fit: BoxFit.fill,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => Image.asset('assets/images/avatar_default.png'),
            ),
          ),
          // child: CachedNetworkImage(
          //   imageUrl: authUser!.avatar ?? "",
          //   fit: BoxFit.cover,
          //   progressIndicatorBuilder: (context, url, downloadProgress) =>
          //       CircularProgressIndicator(value: downloadProgress.progress),
          //   errorWidget: (context, url, error) => Icon(Icons.error),
          // ),
        ),
      ),
    );
  }
}

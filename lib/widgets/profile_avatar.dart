import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fb_copy/constants.dart';

class ProfileAvatar extends StatelessWidget {
  String? avatar;
  double? radius;
  bool? isActive;
  bool? hasBorder;

  ProfileAvatar({
    Key? key,
    required this.avatar,
    this.radius,
    this.isActive,
    this.hasBorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String avatarDefault =
        'https://firebasestorage.googleapis.com/v0/b/savvy-celerity-368016.appspot.com/o/avatar_default.png?alt=media';
    return Stack(
      children: [
        CircleAvatar(
          radius: radius ?? 20.0,
          backgroundColor: AppColor.kPrimaryColor,
          child: CircleAvatar(
              radius: hasBorder ?? false ? radius! - 2 : radius,
              backgroundColor: Colors.grey[200],
              backgroundImage: CachedNetworkImageProvider(
                avatar ?? avatarDefault,
              )),
        ),
        isActive ?? false
            ? Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Container(
                  height: 15.0,
                  width: 15.0,
                  decoration: BoxDecoration(
                    color: AppColor.kPrimaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}

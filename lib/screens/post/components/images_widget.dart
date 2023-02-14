import 'package:cached_network_image/cached_network_image.dart';
import 'package:fb_copy/app_router.dart';
import 'package:fb_copy/constants.dart';
import 'package:fb_copy/models/post_model.dart';
import 'package:fb_copy/screens/post/components/photo_view_zoom.dart';
import 'package:flutter/material.dart';

class ImagesPost extends StatelessWidget {
  final PostModel post;
  const ImagesPost({
    Key? key,
    required this.post,
  }) : super(key: key);
  void onViewImage(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryPhotoViewWrapper(
          listImages: post.image!,
          initialIndex: index,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int lengthIamge = 0;
    if (post.image != null) {
      lengthIamge = post.image!.length;
    }
    if (lengthIamge == 0) {
      return const SizedBox.shrink();
    }
    if (lengthIamge == 1) {
      return InkWell(
        onTap: () => {
          print('click image 0'),
          onViewImage(context, 0),
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: CachedNetworkImage(
            imageUrl: post.image![0].url.toString(),
            width: MediaQuery.of(context).size.width,
            height: 300.0,
            fit: BoxFit.cover,
            placeholder: (context, url) => SizedBox(
              child: Container(
                color: AppColor.grayColor,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      );
    }
    if (lengthIamge == 2) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          height: 300,
          child: Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: () => {
                    print('click image 0'),
                    onViewImage(context, 0),
                  },
                  child: CachedNetworkImage(
                    imageUrl: post.image![0].url.toString(),
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => SizedBox(
                      child: Container(
                        color: AppColor.grayColor,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(width: 4.0),
              Expanded(
                child: InkWell(
                  onTap: () => {
                    print('click image 1'),
                    onViewImage(context, 1),
                  },
                  child: CachedNetworkImage(
                    imageUrl: post.image![1].url.toString(),
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => SizedBox(
                      child: Container(
                        color: AppColor.grayColor,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    if (lengthIamge == 3) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SizedBox(
          height: 350,
          child: Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: () => {
                    print('click image 0'),
                    onViewImage(context, 0),
                  },
                  child: CachedNetworkImage(
                    imageUrl: post.image![0].url.toString(),
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => SizedBox(
                      child: Container(
                        color: AppColor.grayColor,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () => {
                          print('click image 1'),
                          onViewImage(context, 1),
                        },
                        child: CachedNetworkImage(
                          imageUrl: post.image![1].url.toString(),
                          height: MediaQuery.of(context).size.height / 2,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => SizedBox(
                            child: Container(
                              color: AppColor.grayColor,
                            ),
                          ),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: InkWell(
                        onTap: () => {
                          print('click image 2'),
                          onViewImage(context, 2),
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: CachedNetworkImage(
                            imageUrl: post.image![2].url.toString(),
                            height: MediaQuery.of(context).size.height / 2,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => SizedBox(
                              child: Container(
                                color: AppColor.grayColor,
                              ),
                            ),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (lengthIamge == 4) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SizedBox(
          height: 350,
          child: Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: () => {
                    print('click image 0'),
                    onViewImage(context, 0),
                  },
                  child: CachedNetworkImage(
                    imageUrl: post.image![0].url.toString(),
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => SizedBox(
                      child: Container(
                        color: AppColor.grayColor,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        onTap: () => {
                          print('click image 1'),
                          onViewImage(context, 1),
                        },
                        child: CachedNetworkImage(
                          imageUrl: post.image![1].url.toString(),
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => SizedBox(
                            child: Container(
                              color: AppColor.grayColor,
                            ),
                          ),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: InkWell(
                        onTap: () => {
                          print('click image 2'),
                          onViewImage(context, 2),
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: CachedNetworkImage(
                            imageUrl: post.image![2].url.toString(),
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => SizedBox(
                              child: Container(
                                color: AppColor.grayColor,
                              ),
                            ),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: InkWell(
                        onTap: () => {
                          print('click image 3'),
                          onViewImage(context, 3),
                        },
                        child: CachedNetworkImage(
                          imageUrl: post.image![3].url.toString(),
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => SizedBox(
                            child: Container(
                              color: AppColor.grayColor,
                            ),
                          ),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container();
  }
}

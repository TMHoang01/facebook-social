// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import 'package:fb_copy/blocs/picker_image/picker_image_bloc.dart';
import 'package:fb_copy/blocs/post/post_bloc.dart';
import 'package:fb_copy/constants.dart';
import 'package:fb_copy/models/post_model.dart';
import 'package:fb_copy/screens/post/components/input_field_widget.dart';
import 'package:fb_copy/widgets/diaog_widget.dart';

class EditPostScreen extends StatefulWidget {
  PostModel post;
  EditPostScreen({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final _textController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  late final PostModel post;
  late PickerImageBloc _pickerBloc = PickerImageBloc(_picker);
  List<XFile>? images;
  List<ImageModel>? oldImages;
  List<ImageModel>? imagesDelete;

  XFile? video;
  VideoModel? oldVideo;

  @override
  void initState() {
    // TODO: implement initState
    post = widget.post;
    _pickerBloc = BlocProvider.of<PickerImageBloc>(context)..add(PickerImageEditPostEvent(post));
    // oldImages = List.from(post.image as Iterable);

    oldImages = post.image;
    oldVideo = post.video;
    _textController.text = post.described!;
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();

    super.dispose();
  }

  bool checkChangePost() {
    bool isChange = false;
    if (images != null) {
      print('change images != null');
      isChange = true;
    }
    if (video != null) {
      print('change video != null');
      isChange = true;
    }
    if (post.image != null) {
      if (!listEquals(post.image, oldImages)) {
        print('listEquals oldImages: $oldImages');
        print('listEquals post.image: ${post.image}');

        imagesDelete = post.image!.where((element) => !oldImages!.contains(element)).toList();
        print('listEquals imagesDelete: $imagesDelete');
        print('change listEquals(post.image, oldImages)');
        isChange = true;
      }
    }
    if (post.video != oldVideo) {
      print('change post.video != oldVideo');
      isChange = true;
    }
    if (_textController.text != post.described) {
      print('change _textController.text != post.described');
      isChange = true;
    }
    // check oldImage with post.image

    return isChange;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final paddingBottom = mediaQuery.viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        leading: IconButton(
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (!checkChangePost()) {
              Navigator.pop(context);
            } else {
              dialogConfirmBuilder(
                context,
                "Thông báo",
                "Bạn có muốn thóa ra? Bài viết của bạn sẽ không được lưu lại",
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text('Chỉnh sửa tiếp', style: TextStyle(color: Colors.black, fontSize: 18.0)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Bỏ', style: TextStyle(color: Colors.blue, fontSize: 18.0)),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                () {},
              );
            }
          },
        ),
        title: Text('Tạo bài viết', style: TextStyle(color: Colors.black)),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: TextButton(
              // enabled: checkChangePost(),
              onPressed: () {
                if (checkChangePost()) {
                  final postBloc = BlocProvider.of<PostBloc>(context);
                  print('edit post listImageIdDelete: $imagesDelete');
                  postBloc.add(
                    EditPost(
                      post: post,
                      imageDelete: imagesDelete,
                      images: images,
                      video: video,
                      described: _textController.text,
                    ),
                  );
                  Navigator.pop(context);
                  print('edit post change click Lưu');
                } else {
                  print('edit post not change click Lưu');
                }
              },
              child: Text('Lưu', style: TextStyle(color: Colors.blue)),
              // style: ElevatedButton.styleFrom(
              //   // enableFeedback: checkChangePost(),
              //   disabledBackgroundColor: AppColor.grayColor,

              //   // primary: Colors.blue,
              //   backgroundColor: null,
              //   onPrimary: Colors.white,
              // ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.only(bottom: paddingBottom),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.photo_library, color: Colors.green),
                onPressed: () async {
                  _pickerBloc.add(onSelectMultipleImageEvent());
                },
              ),
              IconButton(
                icon: Icon(Icons.photo_camera, color: Colors.green),
                onPressed: () async {
                  _pickerBloc.add(onTakeImageEvent());
                },
              ),
              IconButton(
                icon: Icon(Icons.video_call, color: Colors.red),
                onPressed: () async {
                  _pickerBloc.add(onSelevtVideoEvent());
                },
              ),
              IconButton(
                icon: Icon(Icons.tag_faces, color: Colors.yellow),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/fb.png'),
                    radius: 24.0,
                  ),
                  SizedBox(width: 6.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${post.author!.username ?? 'Người dùng FB'}',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0)),
                      SizedBox(height: 5.0),
                      Text('${post.status ?? ''}')
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20.0),

              EmojiTextField(textController: _textController),
              const SizedBox(height: 10.0),

              // Container(height: 300, color: Colors.amber),
              BlocConsumer<PickerImageBloc, PickerImageState>(
                listener: (context, state) => {
                  if (state.message != null)
                    {ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message!)))}
                },
                builder: (context, state) {
                  images = state.images;

                  video = state.video;
                  oldImages = state.oldImages;
                  oldVideo = state.oldVideo;

                  // print('images: ${oldImages?.map((e) => e.url)}');
                  // print('oldImages: ${post.image?.map((e) => e.url)}');
                  return Column(
                    children: [
                      if (oldImages != null)
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: oldImages!
                              .map(
                                (image) => Padding(
                                  padding: const EdgeInsets.only(bottom: 6.0),
                                  child: Stack(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: image.url.toString(),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 300,
                                      ),
                                      Positioned(
                                        right: 10,
                                        top: 10,
                                        child: InkWell(
                                          onTap: () {
                                            Logger().i('remove image old');
                                            _pickerBloc.add(onRemoveImageEvent(oldImage: image));
                                          },
                                          child: const Icon(Icons.close, color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      const SizedBox(height: 6),
                      if (images != null)
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: images!
                              .map(
                                (image) => Padding(
                                  padding: const EdgeInsets.only(bottom: 6.0),
                                  child: Stack(
                                    children: [
                                      Image.file(
                                        File(image.path),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 300,
                                      ),
                                      Positioned(
                                        right: 10,
                                        top: 10,
                                        child: InkWell(
                                          onTap: () {
                                            Logger().i('remove new image');
                                            _pickerBloc.add(onRemoveImageEvent(image: image));
                                          },
                                          child: const Icon(Icons.close, color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      if (video != null)
                        Stack(
                          children: [
                            Image.file(
                              File(video!.path),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 300,
                            ),
                            Positioned(
                              right: 10,
                              top: 10,
                              child: InkWell(
                                  onTap: () {
                                    Logger().i('remove video');
                                    _pickerBloc.add(onRemoveVideoEvent());
                                  },
                                  child: const Icon(Icons.close, color: Colors.white)),
                            ),
                          ],
                        )
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

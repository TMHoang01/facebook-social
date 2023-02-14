import 'dart:io';

import 'package:fb_copy/blocs/picker_image/picker_image_bloc.dart';
import 'package:fb_copy/blocs/post/post_bloc.dart';
import 'package:fb_copy/constants.dart';
import 'package:fb_copy/screens/post/components/input_field_widget.dart';
import 'package:fb_copy/widgets/bottomsheet_widget.dart';
import 'package:fb_copy/widgets/diaog_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final _textController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  double _fontSize = 26.0;
  late PickerImageBloc _pickerBloc = PickerImageBloc(_picker);
  List<XFile>? images;
  XFile? video;

  @override
  void initState() {
    // TODO: implement initState

    _pickerBloc = BlocProvider.of<PickerImageBloc>(context)..add(PickerImageInitEvent());
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();

    super.dispose();
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
            print(
                ' back: text controoler is Empty ${_textController.text.isEmpty} \n back: images is Empty ${images == null} \n back: video is Empty ${video == null}');
            if (_textController.text.isEmpty && video == null && images == null) {
              Navigator.pop(context);
            } else {
              // show dialog comfirm
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text('Bạn có muốn hủy bài viết?'),
                        content: const Text('Nội dung bài viết sẽ không được lưu lại'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text('Đồng ý')),
                        ],
                      ));
              // showModal(
              //   context,
              //   [
              //     TextButton(onPressed: () => Navigator.pop(context), child: Text('Hủy')),
              //     TextButton(onPressed: () => Navigator.pop(context), child: Text('Đồng ý')),
              //   ],
              // );
            }
          },
        ),
        title: Text('Tạo bài viết', style: TextStyle(color: Colors.black)),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: ElevatedButton(
                onPressed: () {
                  print('add post: ');
                  final postBloc = BlocProvider.of<PostBloc>(context);
                  postBloc.add(AddPost(described: _textController.text.toString(), images: images, video: video));
                  Navigator.pop(context);
                },
                child: Text('Đăng'),
                style: ElevatedButton.styleFrom(
                  disabledBackgroundColor: AppColor.grayColor,
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                )),
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
                  CircleAvatar(
                    backgroundImage: NetworkImage(authUser!.avatar ??
                        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                    radius: 24.0,
                  ),
                  SizedBox(width: 6.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${authUser!.username ?? "Người dùng Facebook"}',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0)),
                      SizedBox(height: 5.0),
                      // Text('post.time')
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              EmojiTextField(
                textController: _textController,
                // fontSize: _fontSize,
                // onEmojiSelected: (emoji) {
                //   print(emoji);
                // },
              ),
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
                    return images != null
                        ? Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: images!
                                .map((image) => Container(
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
                                                Logger().i('remove image');
                                                _pickerBloc.add(
                                                  onRemoveImageEvent(image: image),
                                                );
                                              },
                                              child: Icon(Icons.close, color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          )
                        : video != null
                            ? Container(
                                child: Stack(
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
                                          child: Icon(Icons.close, color: Colors.white)),
                                    ),
                                  ],
                                ),
                              )
                            : Container();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

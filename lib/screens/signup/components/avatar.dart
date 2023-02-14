// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:fb_copy/blocs/signup/signup_bloc.dart';
import 'package:fb_copy/constants.dart';
import 'package:fb_copy/screens/signup/components/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AvatarSignUp extends StatefulWidget {
  final String name;
  const AvatarSignUp({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  State<AvatarSignUp> createState() => _AvatarSignUpState();
}

class _AvatarSignUpState extends State<AvatarSignUp> {
  final ImagePicker _picker = ImagePicker();
  late SignupBloc _signupBloc;
  XFile? pickedImage;
  @override
  void initState() {
    _signupBloc = BlocProvider.of<SignupBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupChangeInfoFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
        if (state is SignupChangeInfoSuccessState) {
          Navigator.pushNamed(context, '/signup_info');
        } else if (state is SignupChangeInfoLoadingState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.blue,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 10),
              content: Row(
                children: const [
                  CircularProgressIndicator(
                    strokeWidth: 1.0,
                    // value: 20,
                  ),
                  SizedBox(width: 10),
                  Text('Đang cập nhập thông tin vui lòng chờ'),
                ],
              ),
            ),
          );
        }
      },
      child: Background(
        text: Text(
          "Ảnh đại diện",
          style: TextStyle(color: AppColor.kColorTextNormal, fontSize: 17),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: Container(), flex: 1),
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.indigo, width: 3),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
                    child: ClipOval(
                      child: pickedImage != null
                          ? Image.file(
                              File(pickedImage!.path),
                              width: 170,
                              height: 170,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/avatar_default.png',
                              width: 170,
                              height: 170,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 5,
                    child: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => Container(
                            height: 200,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.camera),
                                  title: const Text('Chụp ảnh'),
                                  onTap: () async {
                                    // pickImage(ImageSource.camera);
                                    Navigator.pop(context);

                                    pickedImage = await _picker.pickImage(source: ImageSource.camera);

                                    setState(() {
                                      pickedImage = pickedImage;
                                    });
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.image),
                                  title: const Text('Ảnh từ thu viện'),
                                  onTap: () async {
                                    // pickImage(ImageSource.gallery);
                                    Navigator.pop(context);
                                    pickedImage = await _picker.pickImage(source: ImageSource.gallery);

                                    setState(() {
                                      pickedImage = pickedImage;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.add_a_photo_outlined,
                        color: Colors.blue,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  _signupBloc.add(ChangeInfoAfterSignup(
                    username: widget.name,
                    avatar: pickedImage,
                  ));
                },
                child: const Text('Xác nhận'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  _signupBloc.add(ChangeInfoAfterSignup(
                    username: widget.name,
                    avatar: pickedImage,
                  ));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
                child: const Text(
                  'Bỏ qua',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Expanded(child: Container(), flex: 2),
          ],
        ),
      ),
    );
  }
}

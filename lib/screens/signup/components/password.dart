// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fb_copy/blocs/signup/signup_bloc.dart';
import 'package:fb_copy/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:fb_copy/constants.dart';
import 'package:fb_copy/screens/signup/components/background.dart';
import 'package:fb_copy/screens/signup/components/confirm.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordSignup extends StatefulWidget {
  String phoneNumber;
  PasswordSignup({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<PasswordSignup> createState() => _PasswordSignupState();
}

class _PasswordSignupState extends State<PasswordSignup> {
  final FocusNode _passwordFocusNode = FocusNode();
  TextEditingController _passwordController = new TextEditingController();
  bool isShowValidate = false;
  bool nextNavigate = false;
  String? messageValidate;
  @override
  void initState() {
    super.initState();
    _passwordFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  validatePhoneNumber(String value) {
    // if (isSubmit == false) return '';
    nextNavigate = false;
    messageValidate = '';
    isShowValidate = false;

    if (value.isEmpty) {
      isShowValidate = true;
      print('isShowValidate: $isShowValidate ');

      messageValidate = 'Vui lòng nhập mật khẩu';
    } else if (value.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      isShowValidate = true;
      messageValidate = 'Mật khẩu không được chứa kí tự đặc biệt';
    } else if (value.length < 6 || value.length > 10) {
      isShowValidate = true;
      messageValidate = 'Mật khẩu phải từ 6 - 10 kí tự';
    } else if (value == widget.phoneNumber) {
      isShowValidate = true;
      messageValidate = 'Mật khẩu không được trùng số điện thoại';
    } else {
      nextNavigate = true;
      print('Mật khẩu  hợp lệ isShowValidate: $isShowValidate nextNavigate: $nextNavigate');
      // setState(() {});
      if (messageValidate != '') {
        // nextNavigate = false;
        return messageValidate;
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    // TextEditingController phoneNumber = new TextEditingController();
    bool nextNavigate = false;
    Size size = MediaQuery.of(context).size;
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccessState) {
          // delay 1s
          Future.delayed(const Duration(seconds: 1), () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConfirmSignup(),
              ),
            );
          });
        } else if (state is SignupVerifyCodeState) {
        } else if (state is SignupLoadingState) {
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
                  Text('Đang tạo tài khoản...'),
                ],
              ),
            ),
          );
        } else if (state is SignupFailureState) {
          Future.delayed(const Duration(seconds: 1), () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Đăng ký thất bại'),
                content: Text(state.message),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (state.failurePhone != null && state.failurePhone == true) {
                        Navigator.of(context).pop();
                      }
                      // Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          });
        } else {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }
      },
      child: Background(
        text: const Text(
          "Mật Khẩu",
          style: TextStyle(color: AppColor.kColorTextNormal, fontSize: 17),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.02),
              const Text(
                "Chọn mật khẩu",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: size.height * 0.02),
              const Text(
                "Tạo mật khẩu gồm tối thiểu 6 ký tự.Đó phải là mật khẩu mà người khác không thể đoán được.",
                style: TextStyle(color: AppColor.grayColor, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size.height * 0.04),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: TextFormField(
                        autofocus: true,
                        keyboardType: TextInputType.text,
                        focusNode: _passwordFocusNode,
                        controller: _passwordController,
                        onChanged: (value) {
                          setState(() {
                            validatePhoneNumber(value);
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Mật khẩu',
                          suffixIcon: _passwordController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.clear,
                                    // color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordController.clear();
                                    });
                                  },
                                )
                              : null,
                        ),
                        validator: (value) {
                          // validatePhoneNumber(value!);
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              (isShowValidate)
                  ? Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                messageValidate!,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(height: size.height * 0.05),
              ButtonTheme(
                minWidth: double.infinity,
                height: 42,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: MaterialButton(
                  onPressed: () {
                    print('nextNavigate click: $nextNavigate, isShowValidate: $isShowValidate');
                    // bỏ focus
                    _passwordFocusNode.unfocus();
                    if (isShowValidate != true && _passwordController.text.isNotEmpty) {
                      BlocProvider.of<SignupBloc>(context).add(
                        SignupUserEvent(
                          phone: widget.phoneNumber,
                          password: _passwordController.text,
                        ),
                      );
                    }
                  },
                  child: Text('Xác nhận'),
                  color: AppColor.kPrimaryColor,
                  textColor: AppColor.backgroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

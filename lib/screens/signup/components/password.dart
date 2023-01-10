import 'package:fb_copy/constants.dart';
import 'package:fb_copy/screens/home/home_screen.dart';
import 'package:fb_copy/screens/signup/components/background.dart';
import 'package:fb_copy/screens/signup/components/confirm.dart';
import 'package:flutter/material.dart';

class PasswordSignup extends StatefulWidget {
  const PasswordSignup({super.key});

  @override
  State<PasswordSignup> createState() => _PasswordSignupState();
}

class _PasswordSignupState extends State<PasswordSignup> {
  final FocusNode _phoneNumberFocusNode = FocusNode();
  TextEditingController _passwordController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    _phoneNumberFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _phoneNumberFocusNode.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TextEditingController phoneNumber = new TextEditingController();

    Size size = MediaQuery.of(context).size;
    return Background(
      text: Text(
        "Mật Khẩu",
        style: TextStyle(color: AppColor.kColorTextNormal, fontSize: 17),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.02),
            Text(
              "Chọn mật khẩu",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),

            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      // focusNode: _phoneNumberFocusNode,
                      controller: _passwordController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: 'Dien so dien thoa dang ky',
                        suffixIcon: _passwordController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(
                                  Icons.clear,
                                  // color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    // _passwordController.clear();
                                  });
                                },
                              )
                            : null,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Vui lòng điền đầy đủ thông tin!';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            // RoundedPasswordField(
            //   onChanged: (value) {
            //     user.password = value;
            //   },
            // ),
            SizedBox(height: size.height * 0.05),
            btnThemeSignUp(navigatorScreen: ConfirmSignup(), text: 'Xác nhận'),
          ],
        ),
      ),
    );
  }
}

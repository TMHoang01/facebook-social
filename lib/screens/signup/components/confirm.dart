import 'package:fb_copy/constants.dart';
import 'package:fb_copy/screens/signup/components/background.dart';
import 'package:fb_copy/screens/signup/components/name_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

class ConfirmSignup extends StatefulWidget {
  const ConfirmSignup({Key? key}) : super(key: key);

  @override
  State<ConfirmSignup> createState() => _ConfirmSignupState();
}

class _ConfirmSignupState extends State<ConfirmSignup> {
  bool _onEditing = true;
  String? _code;
  @override
  Widget build(BuildContext context) {
    TextEditingController firstName = new TextEditingController();
    TextEditingController lastName = new TextEditingController();
    // firstName.text = user.firstName;
    // lastName.text= user.lastName;
    Size size = MediaQuery.of(context).size;
    return Background(
      text: Text(
        "Xác nhận tài khoản ",
        style: TextStyle(color: AppColor.kColorTextNormal, fontSize: 17),
      ),
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.02),
            // Text(
            //   "Hoàn tất đăng ký",
            //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            // ),
            SizedBox(height: size.height * 0.05),
            Text(
              "Chúng tôi đã gửi SMS kèm mã xác nhận tới ",
            ),
            Text(
              "Nhập mã gồm 4 chữ số từ SMS của bạn ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "FB - ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                VerificationCode(
                  itemSize: 40,
                  length: 4,
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.number,
                  onCompleted: (String value) {
                    print(value);
                  },
                  onEditing: (bool value) {
                    setState(() {
                      _onEditing = value;
                    });
                    if (!_onEditing) FocusScope.of(context).unfocus();
                  },
                  // clearAll: Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16),
                  //   child: Text(
                  //     'clear all',
                  //     style: TextStyle(fontSize: 14.0, decoration: TextDecoration.underline, color: Colors.blue[700]),
                  //   ),
                  // ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.05),
            btnThemeSignUp(navigatorScreen: NameSignup(), text: 'Xác nhận'),
            // ButtonTheme(
            //   minWidth: double.infinity,
            //   child: MaterialButton(
            //     onPressed: () {
            //       Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            //     },
            //     child: Text('Tiếp'),
            //     color: AppColor.kPrimaryColor,
            //     textColor: AppColor.backgroundColor,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

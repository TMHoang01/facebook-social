import 'package:fb_copy/constants.dart';
import 'package:fb_copy/screens/home/home_screen.dart';
import 'package:fb_copy/screens/signup/components/background.dart';
import 'package:fb_copy/screens/signup/components/password.dart';
import 'package:flutter/material.dart';

class PhoneSignup extends StatefulWidget {
  PhoneSignup({Key? key}) : super(key: key);

  @override
  State<PhoneSignup> createState() => _PhoneSignupState();
}

class _PhoneSignupState extends State<PhoneSignup> {
  final FocusNode _phoneNumberFocusNode = FocusNode();
  TextEditingController _phoneNumberController = new TextEditingController();
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
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TextEditingController phoneNumber = new TextEditingController();

    Size size = MediaQuery.of(context).size;
    return Background(
      text: Text(
        "Số di động",
        style: TextStyle(color: AppColor.kColorTextNormal, fontSize: 20),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.06),
            Text(
              "Nhập số điện thoại của bạn",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            ),
            SizedBox(height: size.height * 0.02),

            Text(
              "Nhập số di động của bạn. Bạn có thể ẩn thông tin này trên trang cá nhân của bạn.",
              style: TextStyle(color: AppColor.grayColor, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.04),

            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0),
                    child: TextFormField(
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      // focusNode: _phoneNumberFocusNode,
                      controller: _phoneNumberController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: 'Dien so dien thoa dang ky',
                        suffixIcon: _phoneNumberController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(
                                  Icons.clear,
                                  // color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _phoneNumberController.clear();
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
            btnThemeSignUp(navigatorScreen: PasswordSignup(), text: 'Tiếp'),
          ],
        ),
      ),
    );
  }
}

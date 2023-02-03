import 'package:fb_copy/constants.dart';
import 'package:fb_copy/screens/login/login_screen.dart';
import 'package:fb_copy/screens/signup/components/background.dart';
import 'package:fb_copy/screens/signup/components/phonenumber.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  PageController _pageController = PageController();
  String _nextPage = 'Next';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size * 0.9;
    return Background(
      text: const Text(
        "Tạo tài khoản",
        style: TextStyle(color: AppColor.kColorTextNormal, fontSize: 17),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            const Text(
              "Tham gia Facebook",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Text(
              "Chúng tôi sẽ giúp bạn tạo tài khoản mới sau vài bước dễ dàng",
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.05),
            BtnThemeSignUp(navigatorScreen: PhoneSignup(), text: 'Tiếp', check: true),
            SizedBox(height: size.height * 0.3),
            Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                child: const Text(
                  "Bạn đã có tài khoản?",
                  style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.kPrimaryColorText),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NameForm extends StatefulWidget {
  const NameForm({super.key});

  @override
  State<NameForm> createState() => _NameFormState();
}

class _NameFormState extends State<NameForm> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
// NameForm() {}

// BirthdayForm() {}
// GenderForm() {}

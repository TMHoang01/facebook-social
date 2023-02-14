import 'package:fb_copy/constants.dart';
import 'package:fb_copy/screens/home/home_screen.dart';
import 'package:fb_copy/screens/signup/components/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrivacySignup extends StatelessWidget {
  PrivacySignup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      text: const Text(
        "Điều khoản và quyền riêng tư",
        style: TextStyle(color: AppColor.kColorTextNormal, fontSize: 17),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.02),
            const Text(
              "Hoàn tất đăng ký",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: size.height * 0.05),
            ButtonTheme(
              minWidth: double.infinity,
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomeScreen();
                  }));
                },
                child: Text('Tiếp'),
                color: AppColor.kPrimaryColor,
                textColor: AppColor.backgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

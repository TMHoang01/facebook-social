import 'package:fb_copy/screens/home/home_screen.dart';
import 'package:fb_copy/screens/signup/components/background.dart';
import 'package:fb_copy/screens/signup/components/birthday_signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fb_copy/constants.dart';

class NameSignup extends StatelessWidget {
  NameSignup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController first = new TextEditingController();
    TextEditingController last = new TextEditingController();

    Size size = MediaQuery.of(context).size;
    return Background(
      text: Text(
        "Tên",
        style: TextStyle(color: AppColor.kColorTextNormal, fontSize: 17),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.08),
            Text(
              "Tên bạn tên gì?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: size.height * 0.02),
            Text(
              "Nhập tên bạn sử dụng trong đời thực.",
              style: TextStyle(color: AppColor.grayColor, fontSize: 16),
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
                      controller: first,
                      keyboardType: TextInputType.text,
                      onFieldSubmitted: (value) => FocusScope.of(context).nextFocus(),
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        labelText: "Họ",
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
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0),
                    child: TextFormField(
                      autofocus: true,
                      onFieldSubmitted: (value) => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BirthdaySignup(),
                            ))
                      },
                      controller: last,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        labelText: "Tên",
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

            SizedBox(height: size.height * 0.07),
            BtnThemeSignUp(navigatorScreen: BirthdaySignup(), text: "Tiếp tục"),
            // ButtonTheme(
            //   minWidth: double.infinity,
            //   child: MaterialButton(
            //     onPressed: () {
            //       // Navigator.push(
            //       //     context,
            //       //     MaterialPageRoute(
            //       //       builder: (context) => BirthdaySignup(
            //       //         user: user,
            //       //       ),
            //       //     ));
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

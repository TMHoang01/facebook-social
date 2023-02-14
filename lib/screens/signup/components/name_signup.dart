import 'package:fb_copy/screens/home/home_screen.dart';
import 'package:fb_copy/screens/signup/components/background.dart';
import 'package:fb_copy/screens/signup/components/birthday_signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fb_copy/constants.dart';

class NameSignup extends StatefulWidget {
  NameSignup({Key? key}) : super(key: key);

  @override
  State<NameSignup> createState() => _NameSignupState();
}

class _NameSignupState extends State<NameSignup> {
  TextEditingController first = new TextEditingController();
  TextEditingController last = new TextEditingController();
  final _keyForm = GlobalKey<FormState>();
  bool isShowValidate = false;
  bool nextNavigate = false;
  String? messageValidate;
  validateUserName(String firtName, String lastName) {
    // if (isSubmit == false) return '';
    nextNavigate = false;
    messageValidate = '';
    isShowValidate = false;
    int lengthName = firtName.length + lastName.length + 1;
    if (firtName.isEmpty || lastName.isEmpty) {
      messageValidate = 'Vui lòng điền đầy đủ thông tin!';
      isShowValidate = true;
      messageValidate;
    } else if (lengthName < 4) {
      messageValidate = 'Tên của bạn quá ngắn!';
      isShowValidate = true;
      messageValidate;
    } else if (lengthName >= 30) {
      messageValidate = 'Tên không được quá 30 ký tự!';
      isShowValidate = true;
      messageValidate;
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
    Size size = MediaQuery.of(context).size;

    return Background(
      text: const Text(
        "Tên",
        style: TextStyle(color: AppColor.kColorTextNormal, fontSize: 17),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _keyForm,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.08),
              const Text(
                "Tên bạn tên gì?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: size.height * 0.02),
              const Text(
                "Nhập tên bạn sử dụng trong đời thực.",
                style: TextStyle(color: AppColor.grayColor, fontSize: 16),
              ),
              SizedBox(height: size.height * 0.04),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        autofocus: true,
                        controller: first,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 16, textBaseline: TextBaseline.alphabetic),
                        onFieldSubmitted: (value) => FocusScope.of(context).nextFocus(),
                        onChanged: (value) {
                          setState(() {
                            if (last.text.isNotEmpty) validateUserName(first.text, last.text);
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Họ",
                          suffixIcon: first.text.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 14.0),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.clear,
                                      // color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        first.clear();
                                      });
                                    },
                                  ),
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
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: TextFormField(
                        // autofocus: true,
                        onFieldSubmitted: (value) => {
                          if (nextNavigate == true)
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BirthdaySignup(
                                          userName: first.text + ' ' + last.text,
                                        ))),
                        },
                        controller: last,
                        onChanged: (value) {
                          setState(() {
                            validateUserName(first.text, last.text);
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Tên",
                          suffixIcon: last.text.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 14.0),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.clear,
                                      // color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        last.clear();
                                      });
                                    },
                                  ),
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
              SizedBox(height: size.height * 0.01),

              (isShowValidate)
                  ? Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                messageValidate!,
                                // textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(height: size.height * 0.03),
              // SizedBox(height: size.height * 0.07),
              BtnThemeSignUp(
                navigatorScreen: BirthdaySignup(userName: first.text + ' ' + last.text),
                text: "Tiếp tục",
                check: nextNavigate,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

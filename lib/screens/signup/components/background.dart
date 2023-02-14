// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:fb_copy/constants.dart';

class Background extends StatelessWidget {
  final Widget child;
  final Text text;
  const Background({
    Key? key,
    required this.child,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            _showDialog(context);
          },
        ),
        title: text,
        backgroundColor: AppColor.backgroundColor,
        iconTheme: IconThemeData(color: AppColor.kColorTextNormal),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: child,
      ),
    );
  }
}

void _showDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text("Bạn có muốn dừng tao tài khoản không?"),
            content: const Text(
              "Nếu dừng bây giờ bạn sẽ mất mọi tiến trình mình đã thực hiện",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            actions: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Tiếp tục tạo tài khoản",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
                    },
                    child: const Text("Dừng tạo tài khoản"),
                  ),
                ],
              )
            ],
          ));
}

class BtnThemeSignUp extends StatelessWidget {
  Widget navigatorScreen;
  String text;
  bool? check = false;
  BtnThemeSignUp({
    Key? key,
    required this.navigatorScreen,
    required this.text,
    this.check,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: double.infinity,
      height: 42,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: MaterialButton(
        onPressed: () {
          if (check == true) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return navigatorScreen;
            }));
          }
        },
        child: Text('${text}'),
        color: AppColor.kPrimaryColor,
        textColor: AppColor.backgroundColor,
      ),
    );
  }
}

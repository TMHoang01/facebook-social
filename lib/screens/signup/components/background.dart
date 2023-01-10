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
      appBar: AppBar(
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

class btnThemeSignUp extends StatelessWidget {
  Widget navigatorScreen;
  String text;
  btnThemeSignUp({
    Key? key,
    required this.navigatorScreen,
    required this.text,
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
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return navigatorScreen;
          }));
        },
        child: Text('${text}'),
        color: AppColor.kPrimaryColor,
        textColor: AppColor.backgroundColor,
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:date_time_picker/date_time_picker.dart';
import 'package:fb_copy/screens/signup/components/avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import 'package:fb_copy/constants.dart';
import 'package:fb_copy/screens/home/home_screen.dart';
import 'package:fb_copy/screens/signup/components/background.dart';

class BirthdaySignup extends StatefulWidget {
  String userName;

  BirthdaySignup({
    Key? key,
    required this.userName,
  }) : super(key: key);

  @override
  State<BirthdaySignup> createState() => _BirthdaySignupState();
}

class _BirthdaySignupState extends State<BirthdaySignup> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      text: const Text(
        "Ngày sinh",
        style: TextStyle(color: AppColor.kColorTextNormal, fontSize: 17),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.02),
            const Text(
              "Sinh nhật của bạn khi nào?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: size.height * 0.02),
            const Text(
              "Chọn ngày sinh của bạn. Ban có thể đặt thông tin này ở chế độ riêng tư.",
              style: TextStyle(color: AppColor.grayColor, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              width: size.width * 0.6,
              height: 250,
              child: ScrollDatePicker(
                maximumDate: DateTime.now(),
                minimumDate: DateTime(1970),
                options: const DatePickerOptions(
                  itemExtent: 50,
                ),
                selectedDate: _selectedDate,
                locale: Locale('vi', 'VN'),
                onDateTimeChanged: (DateTime value) {
                  setState(() {
                    _selectedDate = value;
                  });
                },
              ),
            ),
            SizedBox(height: size.height * 0.1),
            // ElevatedButton(
            //     onPressed: () {
            //       Logger().i(_selectedDate);
            //     },
            //     child: Text('Tiếp')),
            BtnThemeSignUp(navigatorScreen: AvatarSignUp(name: widget.userName), text: 'Tiếp', check: true),
          ],
        ),
      ),
    );
  }
}

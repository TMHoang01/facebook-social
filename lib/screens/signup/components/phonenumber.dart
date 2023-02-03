import 'package:date_format/date_format.dart';
import 'package:fb_copy/constants.dart';
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
  GlobalKey _formKey = GlobalKey<FormState>();
  bool isShowValidate = false;
  bool nextNavigate = false;
  String? messageValidate;

  @override
  void initState() {
    super.initState();
    // _phoneNumberFocusNode.addListener(() {
    //   setState(() {});
    // });
    // _phoneNumberController.text = '01234567890';
  }

  @override
  void dispose() {
    _phoneNumberFocusNode.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  validatePhoneNumber(String value) {
    // if (isSubmit == false) return '';
    nextNavigate = false;
    messageValidate = '';
    isShowValidate = false;

    if (value.isEmpty) {
      isShowValidate = true;
      print('isShowValidate: $isShowValidate ');

      messageValidate = 'Vui lòng nhập số điện thoại';
    }
    // value bắt đầu là  0
    if (!value.startsWith('0')) {
      isShowValidate = true;
      print('sđt không hợp lệ (bắt đầu bằng 0) isShowValidate: $isShowValidate');
      messageValidate = 'Số điện thoại không hợp lệ (bắt đầu bằng 0)';
    }

    if (value.length < 10 || value.length > 11) {
      print('sđt không hợp lệ (10-11 số) isShowValidate: $isShowValidate');
      isShowValidate = true;
      messageValidate = 'Số điện thoại không hợp lệ (10-11 số)';
    }
    print('sđt hợp lệ isShowValidate: $isShowValidate');
    nextNavigate = true;
    setState(() {});
    if (messageValidate != '') return messageValidate;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // TextEditingController phoneNumber = new TextEditingController();

    Size size = MediaQuery.of(context).size;
    return Background(
      text: const Text(
        "Số di động",
        style: TextStyle(color: AppColor.kColorTextNormal, fontSize: 20),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.06),
              const Text(
                "Nhập số điện thoại của bạn",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
              ),
              SizedBox(height: size.height * 0.02),
              const Text(
                "Nhập số di động của bạn. Bạn có thể ẩn thông tin này trên trang cá nhân của bạn sau.",
                style: TextStyle(color: AppColor.grayColor, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size.height * 0.04),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: TextFormField(
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        // focusNode: _phoneNumberFocusNode,
                        controller: _phoneNumberController,
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          hintText: 'Số di động',
                          labelText: 'Số di động',
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
                          validatePhoneNumber(value!);
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),

              // thông báo số điện thoại không hợp lệ ở đây khung đỏ, chữ đen

              (isShowValidate)
                  ? Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                messageValidate!,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),

              SizedBox(height: size.height * 0.05),
              BtnThemeSignUp(
                navigatorScreen: PasswordSignup(phoneNumber: _phoneNumberController.text),
                text: 'Tiếp',
                check: nextNavigate,
              ),
              ButtonTheme(
                minWidth: double.infinity,
                height: 42,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: MaterialButton(
                  onPressed: () {
                    if (validatePhoneNumber(_phoneNumberController.text) == null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return PasswordSignup(phoneNumber: _phoneNumberController.text);
                          },
                        ),
                      );
                    }
                  },
                  child: Text('Tiếp'),
                  color: AppColor.kPrimaryColor,
                  textColor: AppColor.backgroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

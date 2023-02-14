import 'package:fb_copy/blocs/signup/signup_bloc.dart';
import 'package:fb_copy/constants.dart';
import 'package:fb_copy/screens/signup/components/background.dart';
import 'package:fb_copy/screens/signup/components/name_signup.dart';
import 'package:fb_copy/widgets/diaog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:logger/logger.dart';

class ConfirmSignup extends StatefulWidget {
  const ConfirmSignup({Key? key}) : super(key: key);

  @override
  State<ConfirmSignup> createState() => _ConfirmSignupState();
}

class _ConfirmSignupState extends State<ConfirmSignup> {
  bool _onEditing = true;
  String? _code;
  String? _codeUser;
  String? _phoneNumber;
  @override
  Widget build(BuildContext context) {
    TextEditingController firstName = new TextEditingController();
    TextEditingController lastName = new TextEditingController();
    // firstName.text = user.firstName;
    // lastName.text= user.lastName;
    Size size = MediaQuery.of(context).size;
    return Background(
      text: const Text(
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
            const Text(
              "Chúng tôi đã gửi SMS kèm mã xác nhận tới ",
            ),

            const Text(
              "Nhập mã gồm 4 chữ số từ SMS của bạn ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.01),

            BlocConsumer<SignupBloc, SignupState>(
              listener: (context, state) {
                if (state is SignupVerifyFailureState) {
                  dialogAlterBuilder(context, 'Thông báo', state.message);
                } else {
                  if (state is SignupVerifySuccessState) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NameSignup()));
                  }
                }
              },
              builder: (context, state) {
                if (state is SignupVerifyCodeState) {
                  _code = state.code;
                  _phoneNumber = state.phone;
                  return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            print('Gửi lại mã xác nhận $_phoneNumber');
                            BlocProvider.of<SignupBloc>(context).add(SignupGetCodeVerifyEvent(phone: _phoneNumber!));
                          },
                          child: const Text('Gửi lại mã'),
                        ),
                        Text(_code!),
                      ],
                    ),
                  );
                } else if (state is AwaitVerifyState) {
                  int endTime = DateTime.now().millisecondsSinceEpoch + 120000;
                  return Center(
                    child: CountdownTimer(
                      endTime: endTime,
                      widgetBuilder: (_, CurrentRemainingTime? time) {
                        // Logger().i(time);
                        if (time == null) {
                          return TextButton(
                            onPressed: () {
                              BlocProvider.of<SignupBloc>(context).add(SignupGetCodeVerifyEvent(phone: _phoneNumber!));
                            },
                            child: const Text('Gửi lại mã'),
                          );
                        }
                        // seconds = min * 60 + sec
                        int second = (time.sec ?? 0) + (time.min ?? 0) * 60;
                        return RichText(
                          text: TextSpan(
                            text: 'Vui lòng đợi để gửi lại mã xác nhận: ',
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(text: '${second} s', style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is SignupSuccessState) {
                  return const Text('Đăng ký thành công');
                } else if (state is SignupVerifyFailureState) {
                  return Center(
                    child: TextButton(
                      onPressed: () {
                        // print('Gửi lại mã xác nhận $_phoneNumber');
                        BlocProvider.of<SignupBloc>(context).add(SignupGetCodeVerifyEvent(phone: _phoneNumber!));
                      },
                      child: const Text('Gửi lại mã'),
                    ),
                  );
                }
                // Loading icon
                return const CircularProgressIndicator();
              },
            ),

            SizedBox(height: size.height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "FB - ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                VerificationCode(
                  // controller: TextEditingController(),
                  autofocus: true,
                  itemSize: 38.0,
                  length: 4,
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.number,
                  // clearAll: IconButton(
                  //   icon: const Icon(Icons.clear),
                  //   onPressed: () {},
                  // ),

                  onCompleted: (String value) {
                    print(value);
                    _codeUser = value;
                  },
                  onEditing: (bool value) {
                    setState(() {
                      _onEditing = value;
                    });
                    if (!_onEditing) FocusScope.of(context).unfocus();
                  },
                ),
              ],
            ),
            SizedBox(height: size.height * 0.05),
            // Center(
            //   child: CountdownTimer(
            //     endTime: DateTime.now().millisecondsSinceEpoch + 120000,
            //   ),
            // ),

            ButtonTheme(
              minWidth: double.infinity,
              height: 42,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              child: MaterialButton(
                onPressed: () {
                  print('code: $_codeUser, phone: $_phoneNumber');
                  if (_codeUser != null && _codeUser!.length == 4 && _phoneNumber != null) {
                    BlocProvider.of<SignupBloc>(context).add(VerifyCodeEvent(code: _codeUser!, phone: _phoneNumber!));
                    _codeUser = null;
                  }
                  // print('nextNavigate click: $nextNavigate');
                  // if (nextNavigate) {}
                },
                child: Text('Xác nhận'),
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

// class Otp extends StatelessWidget {
//   const Otp({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 40,
//       height: 40,
//       child: TextFormField(
//         keyboardType: TextInputType.number,
//         style: Theme.of(context).textTheme.headline6,
//         textAlign: TextAlign.center,
//         inputFormatters: [LengthLimitingTextInputFormatter(1), FilteringTextInputFormatter.digitsOnly],
//         onChanged: (value) {
//           if (value.length == 1) {
//             FocusScope.of(context).nextFocus();
//           }
//           if (value.isEmpty) {
//             FocusScope.of(context).previousFocus();
//           }
//         },
//         // decoration: const InputDecoration(
//         //   hintText: ('0'),
//         // ),
//         onSaved: (value) {},
//       ),
//     );
//   }
// }

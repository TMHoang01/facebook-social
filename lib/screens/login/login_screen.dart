import 'package:fb_copy/blocs/login/login_bloc.dart';
import 'package:fb_copy/constants.dart';
import 'package:fb_copy/screens/home/home_screen.dart';
import 'package:fb_copy/screens/signup/signup_screen.dart';
import 'package:fb_copy/widgets/diaog_widget.dart';
import 'package:fb_copy/screens/loading_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController? phoneNumberController;
  TextEditingController? passwordControler;

  late bool passwordVisibility;
  late bool isIconVisiblePass;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late LoginBloc loginBloc;
  ValueNotifier _loadingLogin = ValueNotifier(false);
  @override
  void initState() {
    super.initState();
    phoneNumberController = TextEditingController(text: '0987654321');
    passwordControler = TextEditingController(text: '1234567890');
    passwordVisibility = false;
    isIconVisiblePass = false;
    loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  void dispose() {
    _loadingLogin.dispose();
    phoneNumberController?.dispose();
    passwordControler?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          _loadingLogin.value = true;
        } else if (state is LoginSuccessState) {
          _loadingLogin.value = false;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
        } else {
          if (state is LoginErrorState) {
            Logger().i(state.message);
            //check 'phonenumber' in  state.message
            if (state.message.contains('phonenumber')) {
              // dialogAlterBuilder(context, 'Thông báo', 'Số điện thoại không tồn tại.Vui lòng thửu lại');
              print('so dien thoai khong ton tai');
              dialogAlterBuilder(context, 'Thông báo', 'Số điện thoại không tồn tại.Vui lòng thửu lại');
            }
            if (state.message.contains('password')) {
              dialogAlterBuilder(context, 'Sai mật khẩu', 'Mật khẩu không bạn nhập không đúng.Vui lòng thử lại.');
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
            // reset password
            passwordControler?.text = '';
          } else if (state is LoginFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
          _loadingLogin.value = false;
        }
      },
      builder: (context, state) {
        return ValueListenableBuilder(
          valueListenable: _loadingLogin,
          builder: (BuildContext context, loading, Widget? child) {
            if (loading) {
              return LoadingScreen(text: 'Đang đăng nhập...');
            }
            return child!;
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // backgroung_login image
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/facebook_logo/background_login.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // padding
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 60, 24, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _formLogin(),
                      SizedBox(height: 20),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Quên mật khẩu?'),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 1,
                            ),
                          ),
                          Text(
                            '   Hoặc   ',
                            style: TextStyle(color: AppColor.grayColor),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return SignupScreen();
                              },
                            ));
                          },
                          child: Text("Đăng ký"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.greenColor,
                            primary: AppColor.greenColor,
                            minimumSize: Size(double.infinity, 35),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _formLogin() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: phoneNumberController,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              // labelText: 'Phone Number',
              hintText: 'Nhập số điên thoại',
              focusColor: AppColor.primaryColor,
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(90.0),
              // ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Vui lòng nhập số điện thoại';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: passwordControler,
            keyboardType: TextInputType.visiblePassword,
            obscureText: !passwordVisibility,
            textInputAction: TextInputAction.done,
            onChanged: (value) => {
              // setState(() {
              //   isIconVisiblePass = !value.isNotEmpty;
              // })
            },
            decoration: InputDecoration(
              hintText: 'Nhập mật khẩu',
              suffixIcon: passwordControler!.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        passwordVisibility ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          passwordVisibility = !passwordVisibility;
                        });
                      },
                    )
                  : null,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Vui lòng nhập mật khẩu';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // xử lý login
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LoginLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // max size parent
                  backgroundColor: AppColor.primaryColor,
                  minimumSize: const Size(double.infinity, 45),
                ),
                onPressed: () {
                  // BlocProvider.of<LoginBloc>(context)
                  //     .add(LoginButtonPress(
                  //   phone: phoneNumberController.toString(),
                  //   password: passwordControler.toString(),
                  // ));
                  // _loadingLogin = ValueNotifier(true);
                  loginBloc
                      .add(LoginButtonPress(phone: phoneNumberController!.text, password: passwordControler!.text));
                },
                child: const Text('Đăng nhập'),
              );
            },
          ),
        ],
      ),
    );
  }
}

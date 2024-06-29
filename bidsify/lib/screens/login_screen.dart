import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/services/auth_service.dart';
import 'package:notes/widgets/toast.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool checkBoxState = false;
  late AuthService _authService;
  String? email, password;
  late FToast fToast;
  @override
  void initState() {
    super.initState();
    _authService = GetIt.instance.get<AuthService>();
    fToast = FToast();
    fToast.init(context);
  }

  _showToast(String message, bool isValid) {
    Widget toast = CustomToaster(
      message: message,
      isValid: isValid,
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }

  _login() async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      bool res = await _authService.login(email!, password!);
      if (res) {
        _showToast("Login successful", true);
        Navigator.popAndPushNamed(context, '/home_screen');
      } else {
        _showToast("Failed to Login", false);
      }
    } else {
      _showToast("Invalid Credentials", false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimateGradient(
          primaryBeginGeometry: const AlignmentDirectional(0, 1),
          primaryEndGeometry: const AlignmentDirectional(0, 2),
          secondaryBeginGeometry: const AlignmentDirectional(2, 0),
          secondaryEndGeometry: const AlignmentDirectional(0, -0.8),
          textDirectionForGeometry: TextDirection.rtl,
          primaryColors: kPrimaryGradientColors,
          secondaryColors: kSecondaryGradientColors,
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Login',
                          style: kHeadingTextStyle.copyWith(fontSize: 55),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            email = value;
                          },
                          style: kInputTextFieldStyle,
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your email',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            // email = value;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            password = value;
                          },
                          style: kInputTextFieldStyle,
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your password',
                          ),
                          obscureText: true,
                          onChanged: (value) {
                            // email = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FittedBox(
                      child: Row(
                        children: [
                          const SizedBox(width: 2),
                          Checkbox(
                              value: checkBoxState,
                              onChanged: (value) {
                                setState(() {
                                  checkBoxState = !checkBoxState;
                                });
                              }),
                          const Text(
                            'Remember Me',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 18.0),
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(color: kSecondaryColor),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: myButton(
                      height: 50,
                      width: double.infinity,
                      text: 'Continue',
                      onClick: _login),
                ),
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.popAndPushNamed(context, '/registration');
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(color: kSecondaryColor),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          )),
    );
  }
}

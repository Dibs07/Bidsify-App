import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/services/auth_service.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  
  bool checkBoxState = false;
  String? _name, _email, _password, _confirmPassword;
  final GetIt getIt = GetIt.instance;
  late AuthService _authService;
  @override
  void initState() {
    super.initState();
    _authService = getIt.get<AuthService>();
  }
   
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text('Sign Up',
                          style: kHeadingTextStyle.copyWith(
                            fontSize: 55
                          ),
                        ),
                      ),
                   const SizedBox(height: 20),
                  
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          validator: (val) => val!.length<6 ? 'Enter a valid name' : null,
                          onSaved: (val) => _name = val!,
                          style: kInputTextFieldStyle,
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your username',
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
                          validator: (val) => val!.isEmpty ? 'Enter a valid email' : null,
                          onSaved: (val) => _email = val!,
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
                          validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                          onSaved: (val) => _password = val!,
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
                  
                      const SizedBox(height: 20),
                  
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          validator: (val) => val!.length<6? 'Password should match' : null,
                          onSaved: (val) => _confirmPassword = val!,
                          style: kInputTextFieldStyle,
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Confirm password',
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
                          Checkbox(value: checkBoxState, onChanged: (value) {
                            setState(() {
                              checkBoxState = !checkBoxState;
                            });
                          }),

                          const Text('Remember Me',
                            style: TextStyle(
                              color: Colors.white
                            ),
                          )
                        ],
                      ),
                    ), 
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: myButton(height: 50, width: double.infinity, text: 'Continue', onClick: _signUp),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          
                         Navigator.popAndPushNamed(context, '/login');
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: kSecondaryColor
                          ),
                        ),
                      ),
                    ],
                  )
                ) 
              ],
            ),
          )),
    );
  }
 
_signUp() async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      if(_password != _confirmPassword) {
        print("Password does not match");
        return;
      }
      bool res = await _authService.register(_email!, _password!);
      if (res) {
        Navigator.popAndPushNamed(context, '/home_screen');
      } else {
        print("Failed");
      }
    } else {
      print("Invalid");
    }
  }
  //   _createAccount() {
  //   var contractLinking = Provider.of<ContractLinking>(context, listen: false);
  //   contractLinking.createAccount(_name, _password, _email);
  // }
}



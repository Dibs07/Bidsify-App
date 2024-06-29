import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/contract_link/contract_linking.dart';
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
  late String _name, _email, _password;

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
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: myButton(height: 50, width: double.infinity, text: 'Continue', onClick: (){},),
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
                          _signUp();
                         // Navigator.popAndPushNamed(context, '/login');
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
  _signUp() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      print("Username: $_name , Email: $_email , Password: $_password");
      _createAccount();
    } else {
      print("Invalid");
    }
  }

    _createAccount() {
    var contractLinking = Provider.of<ContractLinking>(context, listen: false);
    contractLinking.createAccount(_name, _password, _email);
  }
}



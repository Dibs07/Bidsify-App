import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/services/auth_service.dart';
import 'package:provider/provider.dart';

class UserDetailsScreen extends StatefulWidget {
  static const String id = 'userDetails_screen';
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  bool checkBoxState = false;
  int? _phoneNo, _pincode;
  String? _location;
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
                      child: Text(
                        'Additional Details',
                        style: kHeadingTextStyle.copyWith(fontSize: 55),
                      ),
                    ),
                    CircleAvatar(
                       radius: MediaQuery.sizeOf(context).width * 0.15,
                       backgroundImage: AssetImage("assets/default-profile.png"),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        validator: (val) =>
                            val!.length > 10 ? 'Enter a valid mobile no' : null,
                        onSaved: (val) => _phoneNo = int.parse(val!),
                        style: kInputTextFieldStyle,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your mobile no',
                        ),
                        keyboardType: TextInputType.phone,
                        onChanged: (value) {
                          // email = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        validator: (val) =>
                            val!.isEmpty ? 'Enter a valid location' : null,
                        onSaved: (val) => _location = val!,
                        style: kInputTextFieldStyle,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your location',
                        ),
                        keyboardType: TextInputType.multiline,
                        onChanged: (value) {
                          // email = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        validator: (val) =>
                            val!.length != 6 ? 'Enter a valid pincode' : null,
                        onSaved: (val) => _pincode = int.parse(val!),
                        style: kInputTextFieldStyle,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your pincode',
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
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: myButton(
                  height: 50,
                  width: double.infinity,
                  text: 'Continue',
                  onClick: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //   _createAccount() {
  //   var contractLinking = Provider.of<ContractLinking>(context, listen: false);
  //   contractLinking.createAccount(_name, _password, _email);
  // }
}

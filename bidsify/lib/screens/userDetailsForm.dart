import 'dart:io';

import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/model/user_model.dart';
import 'package:notes/services/auth_service.dart';
import 'package:notes/services/data_service.dart';
import 'package:notes/services/media_service.dart';
import 'package:notes/services/storage_service.dart';

class UserDetailsScreen extends StatefulWidget {
  static const String id = 'userDetails_screen';
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  bool checkBoxState = false;
  String? _phoneNo;
  String? _location, _name;
  final GetIt getIt = GetIt.instance;
  late AuthService _authService;
  late MediaService _mediaService;
  late StorageService _storageService;
  late DataService _dataService;
  File? pfp;

  @override
  void initState() {
    super.initState();
    _authService = getIt.get<AuthService>();
    _mediaService = getIt.get<MediaService>();
    _storageService = getIt.get<StorageService>();
    _dataService = getIt.get<DataService>();
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
                    Center(
                      child: GestureDetector(
                        onTap: () async {
                          File? pf = await _mediaService.getImage();
                          if (pf != null) {
                            setState(() {
                              pfp = pf;
                            });
                          }
                        },
                        child: CircleAvatar(
                          radius: MediaQuery.sizeOf(context).width * 0.15,
                          backgroundImage: pfp != null
                              ? FileImage(pfp!)
                              : NetworkImage('https://t3.ftcdn.net/jpg/05/16/27/58/360_F_516275801_f3Fsp17x6HQK0xQgDQEELoTuERO4SsWV.jpg')
                                  as ImageProvider,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        validator: (val) =>
                            val!.length < 6 ? 'Enter a valid name' : null,
                        onSaved: (val) => _name = val,
                        style: kInputTextFieldStyle,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your username',
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        validator: (val) =>
                            val!.length != 10 ? 'Enter a valid mobile no' : null,
                        onSaved: (val) => _phoneNo = val,
                        style: kInputTextFieldStyle,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your mobile no',
                        ),
                        keyboardType: TextInputType.phone,
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
                  onClick: () async {
                    try {
                      final form = _formKey.currentState;
                      if (form!.validate()) {
                        form.save();
                        if (pfp == null) {
                          await _dataService.addUser(
                            userProfile: UserModel(
                              uid: _authService.user!.uid,
                              name: _name,
                              email: _authService.user!.email,
                              phoneNumber: _phoneNo,
                              profilePic: 'https://t3.ftcdn.net/jpg/05/16/27/58/360_F_516275801_f3Fsp17x6HQK0xQgDQEELoTuERO4SsWV.jpg',
                            ),
                          );
                          Navigator.pushNamed(context, '/home_screen');
                        }
                        if (_authService.user == null) {
                          throw Exception("User is not authenticated");
                        }

                        String? url = await _storageService.uploadFile(
                          file: pfp!,
                          uid: _authService.user!.uid,
                        );

                        if (url != null) {
                          await _dataService.addUser(
                            userProfile: UserModel(
                              uid: _authService.user!.uid,
                              name: _name,
                              email: _authService.user!.email,
                              phoneNumber: _phoneNo,
                              profilePic: url,
                            ),
                          );
                          Navigator.pushNamed(context, '/home_screen');
                        } else {
                          throw Exception("Failed to upload user profile image");
                        }
                      } else {
                        throw Exception("Failed to register user");
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

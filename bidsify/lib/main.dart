import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:notes/constants/constants.dart';
import 'package:notes/screens/home_screen.dart';
import 'package:notes/screens/login_screen.dart';
import 'package:notes/screens/registration_screen.dart';
import 'package:notes/screens/onboarding_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notes/services/auth_service.dart';
import 'package:notes/utils.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await setup();
  runApp(const ProviderScope(child: MyApp()));
}
Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupFirebase();
  await registerService();
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AuthService _authService;

  @override
  void initState() {
    super.initState();
    _authService = GetIt.instance.get<AuthService>();
    
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
          splashColor: Colors.transparent, // Set splash color to transparent
          highlightColor:
              Colors.transparent, // Set highlight color to transparent
          splashFactory: NoSplash.splashFactory, // Custom splash factory
          scaffoldBackgroundColor: kMobileBackgroundColor),
      // initialRoute: _user != null ? OnboardingScreen.id : HomeScreen.id,
      initialRoute: _authService.user != null ? '/home_screen' : '/',
      routes: {
        '/': (context) => OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/registration': (context) => const RegistrationScreen(),
        '/home_screen': (context) => MyHomePage(),
      },
    );
  }
}

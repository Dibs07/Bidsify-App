import 'package:flutter/material.dart';
import 'package:notes/screens/home_screen.dart';
import 'package:notes/screens/login_screen.dart';
import 'package:notes/screens/registration_screen.dart';
import 'package:notes/screens/onboarding_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
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
        // scaffoldBackgroundColor: kMobileBackgroundColor
      ),
      // initialRoute: _user != null ? OnboardingScreen.id : HomeScreen.id,
      initialRoute: '/home_screen',
      routes: {
        '/': (context) => OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/registration': (context) => const RegistrationScreen(),
        '/home_screen': (context) => MyHomePage()
      },
    );
  }
}

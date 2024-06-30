import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animate_gradient/animate_gradient.dart';
import 'package:notes/constants/constants.dart';

class OnboardingScreen extends StatefulWidget {
  static const String id = 'onboarding_screen';

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 3, end: 13).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
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
              SvgPicture.asset(
                'assets/Work time-rafiki.svg',
                height: 400.0,
              ),
              
              const SizedBox(height: 10,),
          
              const Text('Welcome to Bidsify',
                style: kHeadingTextStyle
              ),
          
              const SizedBox(height: 30,),
          
              SizedBox(
                width: 178,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(    
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    backgroundColor: kSecondaryColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    )
                  ),
                  child: Row(
                    children: [
                      const Text(
                        'Get Started',
                        style: kButtonTextStyle
                      ),
                      AnimatedBuilder(
                        animation: _animation!,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(_animation!.value, 0),
                            child: const Icon(
                              Icons.arrow_forward,
                              size: 40,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ],
                  ) 
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}

import 'package:flutter/material.dart';

const kMobileBackgroundColor = Color(0xFF0A0B1D);
const kPrimaryGradientColors = [
  Color(0xFF0A0B1D),
  Color(0xFF1d0a1c),
  Color(0xFF1d0a14)
];
const kSecondaryGradientColors = [
  Color(0xFF1d0a14),
  Color(0xFF1d0a1c),
  Color(0xFF0A0B1D),
];
const kButtonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 18
);
const kHeadingTextStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.white
);
const kSecondaryColor = Color(0xFFAA33B5);
const kTextFieldDecoration = InputDecoration(
  border: OutlineInputBorder(),
  hintText: 'Enter a search term',
  // filled: true,
);

const kInputTextFieldStyle = TextStyle(
  color: Colors.white
);

class myButton extends StatelessWidget {
  final double height;
  final double width;
  final String text;

  const myButton({super.key, required this.width, required this.height, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push;
        },
        style: ElevatedButton.styleFrom(    
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          backgroundColor: kSecondaryColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
          )
        ),
        child: Text(
          text,
          style: kButtonTextStyle
        ),
      )
    );
  }
}

class OptionsCard extends StatelessWidget {

  final String title;
  final Icon? icon;
  final double height;
  final double width;

  const OptionsCard({
    super.key,
    required this.title,
    this.icon,
    required this.height,
    required this.width
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color(0x663348B5),
      ),
    
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon ?? Container(),
          const SizedBox(width: 12,),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16
            ),
          )
    
        ],
      ),
    
    );
  }
}

class SmallButtons extends StatelessWidget {
  const SmallButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextButton(
        onPressed: () {},
        child: const Text(
          'Hello',
          style: TextStyle(
            color: Color(0xFF3348B5),
            fontSize: 16
          ),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size.zero,
          padding: const EdgeInsets.fromLTRB(24, 6, 24, 6),
          backgroundColor: Color(0x663348B5),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          )
        ),
      ),
    );
  }
}

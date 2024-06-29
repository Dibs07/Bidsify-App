import 'package:flutter/material.dart';
import 'package:notes/constants/constants.dart';
import 'package:neon_widgets/neon_widgets.dart';

class UserPreferences extends StatefulWidget {
  const UserPreferences({super.key});

  @override
  State<UserPreferences> createState() => _UserPreferencesState();
}

class _UserPreferencesState extends State<UserPreferences> {
  final List<String> buttonNames = ['Button1', 'Button2', 'Button3', 'Button4', 'Button5', 'Button6'];
  final Set<String> selectedButtons = Set<String>();

  void _toggleSelection(String buttonName) {
    setState(() {
      if (selectedButtons.contains(buttonName)) {
        selectedButtons.remove(buttonName);
      } else {
        selectedButtons.add(buttonName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Center(
              child: NeonContainer(
                spreadColor: kSecondaryColor,
                child: Container(
                  height: 160,
                  child: Image.asset('assets/image (1).png'),
                ),
                  borderRadius: BorderRadius.circular(1400),
                  lightBlurRadius: 150,
                  lightSpreadRadius: 60,
                  borderColor: Colors.transparent,
              )
            )
          ),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              'Choose your interests',
              style: kHeadingTextStyle.copyWith(
                fontSize: 44
              )
            ),
          ),
          SizedBox(height: 10),
          Expanded(      
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Wrap(
                direction: Axis.horizontal,
                children: buttonNames.map((buttonName) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
                    child: SizedBox(
                      width: 92,
                      height: 40,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              return selectedButtons.contains(buttonName) ? Color(0x663348B5) : Color(0x663348B5);
                            },
                          ),
                          side: MaterialStateProperty.resolveWith<BorderSide>(
                              (Set<MaterialState> states) {
                                return BorderSide(
                                  width: selectedButtons.contains(buttonName) ? 4.0 : 0,
                                  color:Color(0x663348B5)
                                );
                              },
                          ),
                        ),
                        child: Text(
                          buttonName,
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                        onPressed: () => _toggleSelection(buttonName),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Align(alignment: Alignment.centerRight,child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 30, 10, 10),
            child: myButton(width: 200, height: 50, text: 'Continue', onClick: (){
              Navigator.popAndPushNamed(context, '/home_screen');
            }),
          ))
        ],
      ),
    );
  }
}

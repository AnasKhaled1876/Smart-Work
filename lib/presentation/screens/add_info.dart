import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_work/config/main_theme.dart';
import 'package:smart_work/presentation/assets/color_manager.dart';
import 'package:smart_work/presentation/screens/home_screen.dart';

import '../../utils/constants/labels.dart';

class AddInfoScreen extends StatefulWidget {
  const AddInfoScreen({super.key});
  static const routeName = '/add_info';

  @override
  State<AddInfoScreen> createState() => _AddInfoScreenState();
}

class _AddInfoScreenState extends State<AddInfoScreen> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Stack(
        children: [
          Positioned(
            left: width * -99,
            top: height * -92,
            child: Container(
              width: width * 273,
              height: height * 277,
              decoration: const ShapeDecoration(
                color: Color(0xFFF7F5FF),
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            left: width * 73,
            top: height * -199,
            child: Container(
              width: width * 325,
              height: height * 330,
              decoration: const ShapeDecoration(
                color: Color(0x49C1B2FF),
                shape: OvalBorder(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 40,
              vertical: height * 40,
            ),
            child: Column(
              children: [
                Text(
                  'Set Your Personal \nInformation',
                  style: TextStyle(
                    color: const Color(0xFF242041),
                    fontSize: textSize * 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: height * 107,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Write Your Name',
                    hintStyle: TextStyle(
                      color: const Color(0xFFAEACB9),
                      fontSize: textSize * 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 70,
                ),
                CheckboxListTile(
                  activeColor: primaryColor,
                  controlAffinity: ListTileControlAffinity.trailing,
                  checkboxShape: const CircleBorder(),
                  title: Text(
                    'Male',
                    style: TextStyle(
                      color: const Color(0xFF242041),
                      fontSize: textSize * 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  value: value,
                  onChanged: (check) {
                    setState(() {
                      value = check!;
                    });
                  },
                ),
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.trailing,
                  checkboxShape: const CircleBorder(),
                  title: Text(
                    'Female',
                    style: TextStyle(
                      color: const Color(0xFF242041),
                      fontSize: textSize * 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  activeColor: primaryColor,
                  value: !value,
                  onChanged: (check) {
                    setState(() {
                      value = !check!;
                    });
                  },
                ),
                const Spacer(),
                ElevatedButton(
                  style: mainButtonTheme.style,
                  onPressed: () {
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Get Started',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: textSize * 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                        "assets/icons/arrow_right.svg",
                        width: width * 24,
                        height: height * 24,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

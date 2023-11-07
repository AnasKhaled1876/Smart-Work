import 'package:flutter/material.dart';
import '../../../utils/constants/labels.dart';
import '../../assets/color_manager.dart';

class PersonalSettingsScreen extends StatefulWidget {
  const PersonalSettingsScreen({super.key});
  static const routeName = '/personal-settings';

  @override
  State<PersonalSettingsScreen> createState() => _PersonalSettingsScreenState();
}

class _PersonalSettingsScreenState extends State<PersonalSettingsScreen> {
  TextEditingController nameController = TextEditingController();
  bool value = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 32,
            vertical: width * 47,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.only(
                        left: width * 13,
                        right: width * 8,
                        top: width * 10,
                        bottom: width * 10,
                      ),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(width * 4),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x26000000),
                            blurRadius: 20,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: primaryColor,
                        size: width * 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 10,
                  ),
                  Expanded(
                    child: Text(
                      'Personal Settings',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: textSize * 22,
                        fontFamily: 'SFPro',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(width * 10),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(width * 4),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x26000000),
                            blurRadius: 20,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Icon(
                        Icons.check,
                        color: primaryColor,
                        size: width * 24,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height * 40,
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: 'Your Name',
                  labelStyle: TextStyle(
                    color: primaryColor,
                    fontSize: textSize * 15,
                    fontWeight: FontWeight.w400,
                  ),
                  contentPadding: EdgeInsets.zero,
                  enabledBorder: const UnderlineInputBorder(),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: width * 1,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 20,
              ),
              //TODO: expand radius of checkbox
              CheckboxListTile(
                checkColor: secondaryColor,
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
                checkColor: secondaryColor,
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
            ],
          ),
        ),
      ),
    );
  }
}

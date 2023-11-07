import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_work/utils/constants/routes.dart';
import '../../../utils/constants/labels.dart';
import '../../assets/color_manager.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  static const routeName = '/settings';

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
                  Expanded(
                    child: Text(
                      'Settings',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: textSize * 22,
                        fontFamily: 'SFPro',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
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
                        Icons.close,
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
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => SettingsTile(
                    additionalInfo: index == 2
                        ? Row(
                            children: [
                              Text(
                                'English',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: textSize * 13.47,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                width: width * 6,
                              ),
                              SvgPicture.asset(
                                "assets/icons/globe.svg",
                                width: width * 15,
                                height: width * 15,
                              ),
                            ],
                          )
                        : null,
                    title: settingsTitles[index],
                    onTap: () {
                      if (index == 2) {
                        // Navigator.pushNamed(context, LanguageScreen.routeName);
                      } else {
                        Navigator.pushNamed(
                          context,
                          settingsRoutes[index],
                        );
                      }
                    },
                  ),
                  itemCount: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  const SettingsTile(
      {super.key,
      this.additionalInfo,
      required this.title,
      required this.onTap});
  final Widget? additionalInfo;
  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        margin: EdgeInsets.only(
          bottom: width * 30,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: textSize * 17,
                  fontFamily: 'SFPro',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (additionalInfo != null) ...[
              SizedBox(
                width: width * 4,
              ),
              additionalInfo!,
              SizedBox(
                width: width * 4,
              )
            ],
            Icon(
              Icons.arrow_forward_ios,
              color: primaryColor,
              size: width * 16,
            )
          ],
        ),
      ),
    );
  }
}

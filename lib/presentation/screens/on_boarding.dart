import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_work/config/main_theme.dart';
import 'package:smart_work/presentation/assets/color_manager.dart';
import 'package:smart_work/presentation/screens/sign_up.dart';
import 'package:smart_work/utils/constants/images.dart';
import 'package:smart_work/utils/constants/labels.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});
  static const routeName = '/on_boarding';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarOpacity: 0.0,
        toolbarHeight: 0,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: width * 40,
            right: width * 40,
            bottom: height * 32,
            top: height * 40,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AddInfoScreen.routeName);
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: const Color(0xFFAEACB9),
                        fontSize: textSize * 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'English',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF242041),
                      fontSize: textSize * 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: width * 8,
                  ),
                  SvgPicture.asset(
                    "assets/icons/globe.svg",
                    width: width * 16,
                    height: height * 16,
                  ),
                ],
              ),
              SizedBox(
                height: height * 50,
              ),
              Image.asset(
                onBoardingImages[index],
                height: height * 295,
                width: width * 281,
              ),
              SizedBox(
                height: height * 25,
              ),
              Text(
                'Pomodoro Timer',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF242041),
                  fontSize: textSize * 24,
                  fontFamily: 'SFPro',
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: height * 24,
              ),
              Text(
                'Add multiple pomodoro timers and set\nthe long and short break time.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFFAEACB9),
                  fontSize: textSize * 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: height * 50,
              ),
              AnimatedSmoothIndicator(
                activeIndex: index,
                count: 3,
                effect: WormEffect(
                  dotHeight: width * 9,
                  dotWidth: width * 9,
                  dotColor: const Color(0xFFAEACB9),
                  activeDotColor: primaryColor,
                ),
              ),
              SizedBox(
                height: height * 40,
              ),
              ElevatedButton(
                style: mainButtonTheme.style,
                onPressed: () {
                  if (index == 2) {
                    Navigator.pushNamed(context, AddInfoScreen.routeName);
                  } else {
                    setState(() {
                      index++;
                    });
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Next',
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

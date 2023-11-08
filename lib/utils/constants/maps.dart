import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_work/presentation/assets/color_manager.dart';
import 'package:smart_work/utils/constants/labels.dart';

Map<int, Widget> sideButton = {
  0: SvgPicture.asset(
    'assets/icons/bell.svg',
    colorFilter: const ColorFilter.mode(
      primaryColor,
      BlendMode.srcIn,
    ),
    height: height * 20,
    width: width * 20,
  ),
  1: Row(
    children: [
      Text(
        'March 2023',
        style: TextStyle(
          color: primaryColor,
          fontSize: textSize * 14,
          fontFamily: 'SFPro',
          fontWeight: FontWeight.w400,
          letterSpacing: 0.50,
        ),
      ),
      SizedBox(
        width: width * 4,
      ),
      SvgPicture.asset(
        'assets/icons/calendar.svg',
        colorFilter: const ColorFilter.mode(
          primaryColor,
          BlendMode.srcIn,
        ),
        height: height * 18,
        width: width * 18,
      ),
    ],
  ),
  3: SvgPicture.asset(
    'assets/icons/add.svg',
    colorFilter: const ColorFilter.mode(
      primaryColor,
      BlendMode.srcIn,
    ),
    height: height * 20,
    width: width * 20,
  ),
  4: SvgPicture.asset(
    'assets/icons/add.svg',
    colorFilter: const ColorFilter.mode(
      primaryColor,
      BlendMode.srcIn,
    ),
    height: height * 20,
    width: width * 20,
  ),
};

Map<int, String> selectedModeImage = {
  0: "assets/images/timer_selected.png",
  1: "assets/images/pomodoro_selected.png",
  2: "assets/images/stopwatch_selected.png",
};

Map<int, String> settingsTileOnTap = {
  0: "assets/images/timer_selected.png",
  1: "assets/images/pomodoro_selected.png",
  2: "assets/images/stopwatch_selected.png",
};

Map<String, String> notificationTypes = {
  "a": "assets/icons/pomodoro.svg",
  "stopwatch": "assets/icons/sand_clock.svg",
  "": "assets/icons/stopwatch.svg",
};

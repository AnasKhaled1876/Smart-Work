import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_work/presentation/assets/color_manager.dart';
import 'package:smart_work/presentation/widgets/pomodoro/timer.dart';

import '../../utils/constants/labels.dart';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});
  static const routeName = '/pomodoro';

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: primaryColor,
          statusBarIconBrightness:
              Platform.isIOS ? Brightness.dark : Brightness.light,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: primaryColor,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/pomodoro_circles.png',
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: width * 70,
                left: width * 20,
                right: width * 20,
              ),
              child: Column(
                children: [
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ModeTile(
                        //TODO: Replace with sand clock
                        icon: 'assets/icons/pomodoro.svg',
                        title: 'Timer',
                        isSelected: true,
                      ),
                      ModeTile(
                        icon: 'assets/icons/pomodoro.svg',
                        title: 'Pomodoro',
                        isSelected: false,
                      ),
                      ModeTile(
                        icon: 'assets/icons/stopwatch.svg',
                        title: 'Stop Watch',
                        isSelected: false,
                      )
                    ],
                  ),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: TimerWidget(),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ModeTile extends StatelessWidget {
  const ModeTile({
    super.key,
    required this.icon,
    required this.title,
    required this.isSelected,
  });

  final String icon, title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          icon,
          height: width * 40,
          colorFilter: ColorFilter.mode(
            isSelected ? const Color(0xFFC1B2FF) : Colors.white,
            BlendMode.srcIn,
          ),
        ),
        SizedBox(
          height: width * 10,
        ),
        Text(
          title,
          style: TextStyle(
            color: isSelected ? const Color(0xFFC1B2FF) : Colors.white,
            fontSize: textSize * 12,
            fontFamily: 'SFPro',
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}

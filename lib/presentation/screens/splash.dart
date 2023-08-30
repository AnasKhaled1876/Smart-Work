import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:smart_work/presentation/assets/color_manager.dart';
import 'package:smart_work/presentation/screens/on_boarding.dart';

import '../../utils/constants/labels.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 1),
      () {
        Navigator.pushNamed(context, OnBoardingScreen.routeName);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: primaryColor,
        ),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: width * -202,
              top: height * 804,
              child: Container(
                width: width * 448,
                height: height * 448,
                decoration: const ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0, 90),
                    end: Alignment(0, -1),
                    colors: [secondaryColor, primaryColor],
                  ),
                  shape: OvalBorder(),
                  shadows: [
                    BoxShadow(
                      color: primaryColor,
                      blurRadius: 20,
                      offset: Offset(0, -20),
                      spreadRadius: 0,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: width * 174,
              top: height * 87,
              child: Container(
                width: width * 448,
                height: height * 448,
                decoration: const ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0, 27),
                    end: Alignment(0, -1),
                    colors: [secondaryColor, primaryColor],
                  ),
                  shape: OvalBorder(),
                  shadows: [
                    BoxShadow(
                      color: primaryColor,
                      blurRadius: 20,
                      offset: Offset(0, -20),
                      spreadRadius: 0,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: width * -202,
              top: height * 760,
              child: Container(
                width: width * 448,
                height: height * 448,
                decoration: const ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0, 27),
                    end: Alignment(0, -1),
                    colors: [secondaryColor, primaryColor],
                  ),
                  shape: OvalBorder(),
                  shadows: [
                    BoxShadow(
                      color: primaryColor,
                      blurRadius: 20,
                      offset: Offset(0, -20),
                      spreadRadius: 0,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: width * 174,
              top: height * 131,
              child: Container(
                width: width * 448,
                height: height * 448,
                decoration: const ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0, 27),
                    end: Alignment(0, -1),
                    colors: [secondaryColor, primaryColor],
                  ),
                  shape: OvalBorder(),
                  shadows: [
                    BoxShadow(
                      color: primaryColor,
                      blurRadius: 20,
                      offset: Offset(0, -20),
                      spreadRadius: 0,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: width * -202,
              top: height * 713,
              child: Container(
                width: width * 448,
                height: height * 448,
                decoration: const ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0, 27),
                    end: Alignment(0, -1),
                    colors: [secondaryColor, primaryColor],
                  ),
                  shape: OvalBorder(),
                  shadows: [
                    BoxShadow(
                      color: primaryColor,
                      blurRadius: 20,
                      offset: Offset(0, -20),
                      spreadRadius: 0,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: width * 174,
              top: height * 178,
              child: Container(
                width: width * 448,
                height: height * 448,
                decoration: const ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0, 27),
                    end: Alignment(0, -1),
                    colors: [secondaryColor, primaryColor],
                  ),
                  shape: OvalBorder(),
                  shadows: [
                    BoxShadow(
                      color: primaryColor,
                      blurRadius: 20,
                      offset: Offset(0, -20),
                      spreadRadius: 0,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              right: width * -202,
              bottom: height * 804,
              child: Container(
                width: width * 448,
                height: height * 448,
                decoration: const ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0, 90),
                    end: Alignment(0, -1),
                    colors: [secondaryColor, primaryColor],
                  ),
                  shape: OvalBorder(),
                  shadows: [
                    BoxShadow(
                      color: primaryColor,
                      blurRadius: 20,
                      offset: Offset(0, -20),
                      spreadRadius: 0,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              right: width * 174,
              bottom: height * 87,
              child: Container(
                width: width * 448,
                height: height * 448,
                decoration: const ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0, 90),
                    end: Alignment(0, -1),
                    colors: [secondaryColor, primaryColor],
                  ),
                  shape: OvalBorder(),
                  shadows: [
                    BoxShadow(
                      color: primaryColor,
                      blurRadius: 20,
                      offset: Offset(0, -20),
                      spreadRadius: 0,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              right: width * -202,
              bottom: height * 760,
              child: Container(
                width: width * 448,
                height: height * 448,
                decoration: const ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0, 90),
                    end: Alignment(0, -1),
                    colors: [secondaryColor, primaryColor],
                  ),
                  shape: OvalBorder(),
                  shadows: [
                    BoxShadow(
                      color: primaryColor,
                      blurRadius: 20,
                      offset: Offset(0, -20),
                      spreadRadius: 0,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              right: width * 174,
              bottom: height * 131,
              child: Container(
                width: width * 448,
                height: height * 448,
                decoration: const ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0, 90),
                    end: Alignment(0, -1),
                    colors: [secondaryColor, primaryColor],
                  ),
                  shape: OvalBorder(),
                  shadows: [
                    BoxShadow(
                      color: primaryColor,
                      blurRadius: 20,
                      offset: Offset(0, -20),
                      spreadRadius: 0,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              right: width * -202,
              bottom: height * 713,
              child: Container(
                width: width * 448,
                height: height * 448,
                decoration: const ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0, 90),
                    end: Alignment(0, -1),
                    colors: [secondaryColor, primaryColor],
                  ),
                  shape: OvalBorder(),
                  shadows: [
                    BoxShadow(
                      color: primaryColor,
                      blurRadius: 20,
                      offset: Offset(0, -20),
                      spreadRadius: 0,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              right: width * 174,
              bottom: height * 178,
              child: Container(
                width: width * 448,
                height: height * 448,
                decoration: const ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0, 90),
                    end: Alignment(0, -1),
                    colors: [secondaryColor, primaryColor],
                  ),
                  shape: OvalBorder(),
                  shadows: [
                    BoxShadow(
                      color: primaryColor,
                      blurRadius: 20,
                      offset: Offset(0, -20),
                      spreadRadius: 0,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              right: width * 80,
              bottom: height * 270,
              child: SizedBox(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      width: width * 234,
                      height: height * 55,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      height: height * 10,
                    ),
                    Text(
                      'MORE SMART MORE ACHIEVEMENT',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: textSize * 13.57,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.56,
                      ),
                    ),
                    SizedBox(
                      height: height * 20,
                    ),
                    SizedBox(
                      width: width * 50,
                      height: height * 30.25,
                      child: const LoadingIndicator(
                        indicatorType: Indicator.ballPulse,
                        colors: [secondaryColor, Colors.white],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:smart_work/cubits/cubit/app_cubit.dart';
import 'package:smart_work/injection.dart';
import 'package:smart_work/presentation/assets/color_manager.dart';
import 'package:smart_work/presentation/screens/home.dart';
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
    //check if there is username and password in flutter secure storage
    //if there is, login user
    //else navigate to onboarding screen

    Future.delayed(
      const Duration(seconds: 1),
      () async {
        String? email =
            await locator<FlutterSecureStorage>().read(key: "email");
        String? password =
            await locator<FlutterSecureStorage>().read(key: "password");
        if (![email, password].contains(null)) {
          AppCubit.get(context).loginUser(email: email!, password: password!);
        } else {
          Navigator.pushNamed(context, OnBoardingScreen.routeName);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          Navigator.pushNamed(context, HomeScreen.routeName);
        }
        if (state is LoginErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
          Navigator.pushNamed(context, OnBoardingScreen.routeName);
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: primaryColor,
          appBar: AppBar(
            toolbarHeight: 0.0,
            toolbarOpacity: 0.0,
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
                  right: width * 30,
                  bottom: height * 330,
                  child: SizedBox(
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/logo.png",
                          height: height * 80,
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
      },
    );
  }
}

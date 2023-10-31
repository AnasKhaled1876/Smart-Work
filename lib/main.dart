import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_work/cubits/cubit/app_cubit.dart';
import 'package:smart_work/injection.dart';
import 'package:smart_work/presentation/assets/color_manager.dart';
import 'package:smart_work/presentation/screens/sign_up.dart';
import 'package:smart_work/presentation/screens/home.dart';
import 'package:smart_work/presentation/screens/on_boarding.dart';
import 'package:smart_work/presentation/screens/splash.dart';
import 'package:smart_work/config/main_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'utils/constants/labels.dart';

void main() async {
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 393;
    double fem = MediaQuery.sizeOf(context).width / baseWidth;
    double ffem = fem * 0.97;
    textSize = ffem;
    height = fem;
    width = fem;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: primaryColor,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: primaryColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: mainTheme,
        routes: {
          '/splash': (context) => const SplashScreen(),
          OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
          AddInfoScreen.routeName: (context) => const AddInfoScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
        },
        initialRoute: '/splash',
      ),
    );
  }
}

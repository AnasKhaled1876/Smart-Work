import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_work/config/main_theme.dart';
import 'package:smart_work/presentation/assets/color_manager.dart';
import 'package:smart_work/presentation/screens/add_info.dart';
import 'package:smart_work/presentation/screens/home_screen.dart';
import 'package:smart_work/presentation/screens/on_boarding.dart';
import 'package:smart_work/presentation/screens/splash.dart';
import 'utils/constants/labels.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
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
        statusBarColor: tertiaryColor,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: mainTheme,
      routes: {
        '/splash': (context) => const SplashScreen(),
        OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
        AddInfoScreen.routeName: (context) => const AddInfoScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
      initialRoute: '/splash',
    );
  }
}

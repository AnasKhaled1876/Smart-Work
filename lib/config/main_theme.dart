import 'package:flutter/material.dart';
import 'package:smart_work/presentation/assets/color_manager.dart';
import 'package:smart_work/utils/constants/labels.dart';

ThemeData mainTheme = ThemeData(
  fontFamily: "SFPro",
  // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  useMaterial3: true,
);

ElevatedButtonThemeData mainButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(width * 30),
    ),
    padding: EdgeInsets.symmetric(
      horizontal: width * 24,
      vertical: height * 17,
    ),
  ),
);

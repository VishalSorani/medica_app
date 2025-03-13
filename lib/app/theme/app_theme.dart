import 'package:flutter/material.dart';
import 'package:medica_app/app/utils/colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryColor,
      onPrimary: Colors.white,
      secondary: AppColors.sliderBackground,
      onSecondary: Colors.white,
      error: AppColors.red,
      onError: Colors.white,
      surface: Colors.white,
      onSurface: AppColors.black,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.black),
      bodyMedium: TextStyle(color: AppColors.lightTextColor),
      headlineLarge:
          TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold),
      titleLarge:
          TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: Colors.black,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primaryColor,
      onPrimary: Colors.white,
      secondary: AppColors.sliderBackground,
      onSecondary: Colors.white,
      error: AppColors.red,
      onError: Colors.white,
      surface: Colors.grey[900]!,
      onSurface: Colors.white,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: AppColors.lightTextColor),
      headlineLarge:
          TextStyle(color: AppColors.starColor, fontWeight: FontWeight.bold),
      titleLarge:
          TextStyle(color: AppColors.starColor, fontWeight: FontWeight.bold),
    ),
  );
}

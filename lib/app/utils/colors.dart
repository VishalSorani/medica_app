import 'package:flutter/material.dart';

class AppColors extends ColorScheme {
  static const Color primaryColor = Color(0xFF0B8FAC);
  static const Color lightTextColor = Color(0xFF858585);
  static const Color borderColor = Color.fromARGB(255, 185, 185, 185);
  static const Color black = Color(0xFF000000);
  static const Color sliderBackground = Color(0xFF7BC1B7);
  static const Color greenColor = Color(0xFF129820);
  static const Color red = Color(0xFFF30000);
  static const Color starColor = Color(0xFFF89603);
  static const Color transparentColor = Color(0x00000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color textFieldColor = Color.fromARGB(255, 241, 241, 241);
  static const Color textFieldBorderColor = Color.fromARGB(255, 163, 55, 55);

  const AppColors(
      {required super.brightness,
      required super.primary,
      required super.onPrimary,
      required super.secondary,
      required super.onSecondary,
      required super.error,
      required super.onError,
      required super.surface,
      required super.onSurface});
}

import 'package:flutter/material.dart';
import 'package:medica_app/app/utils/fonts.dart'; // Custom text styles
import 'package:medica_app/app/utils/colors.dart'; // Custom colors

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double paddingVertical;
  final double paddingHorizontal;
  final double fontSize;

  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.primaryColor,
    this.paddingVertical = 12,
    this.paddingHorizontal = 0,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
            vertical: paddingVertical, horizontal: paddingHorizontal),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        foregroundColor: color,
      ),
      child: Text(
        text,
        style: FMPTextTheme.instance.displaySmall?.copyWith(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:medica_app/app/utils/fonts.dart';
import 'package:medica_app/app/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  final Color color;
  final Color textColor;
  final double paddingVertical;
  final double paddingHorizontal;
  final double fontSize;
  final Widget? child; // Add child parameter

  const CustomButton({
    super.key,
    this.text, // Make text nullable
    required this.onPressed,
    this.color = AppColors.primaryColor,
    this.textColor = AppColors.white,
    this.paddingVertical = 12,
    this.paddingHorizontal = 0,
    this.fontSize = 14,
    this.child, // Allow custom child (like loader)
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(
          vertical: paddingVertical,
          horizontal: paddingHorizontal,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: child ?? // If child is provided, use it; otherwise, show text
          Text(
            text ?? '',
            style: FMPTextTheme.instance.displaySmall?.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
          ),
    );
  }
}

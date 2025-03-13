import 'package:flutter/material.dart';
import 'package:medica_app/app/utils/colors.dart';
import 'package:medica_app/app/utils/fonts.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon; // Added prefixIcon
  final bool obscureText;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.labelText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.prefixIcon, // Initialize prefixIcon
    this.obscureText = false,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: FMPTextTheme.instance.displayExtraSmall?.copyWith(
            fontSize: 16,
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle:
                FMPTextTheme.instance.displayExtraSmall?.copyWith(fontSize: 13),
            filled: true,
            fillColor: AppColors.textFieldColor,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            prefixIcon: prefixIcon, // Added this line
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

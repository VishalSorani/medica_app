import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medica_app/app/utils/colors.dart';

class FMPTextTheme extends TextTheme {
  static const FMPTextTheme instance = FMPTextTheme._();

  //create a singleton
  const FMPTextTheme._();

  @override
  TextStyle? get displayLarge {
    return GoogleFonts.lexend(
      color: AppColors.primaryColor,
      fontSize: 70,
      fontWeight: FontWeight.w600,
    );
  }

  @override
  TextStyle? get displayMedium {
    return GoogleFonts.openSans(
      color: AppColors.primaryColor,
      fontSize: 24,
      fontWeight: FontWeight.w700,
    );
  }

  @override
  TextStyle? get displaySmall {
    return GoogleFonts.openSans(
      color: AppColors.black,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle? get displayExtraSmall {
    return GoogleFonts.openSans(
      color: AppColors.lightTextColor,
      fontSize: 10,
      fontWeight: FontWeight.w400,
    );
  }
}

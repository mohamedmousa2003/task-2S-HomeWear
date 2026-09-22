import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';


abstract class AppTextStyles {

  static TextStyle get primaryEnglishFont => GoogleFonts.poppins();
  static TextStyle get primaryArabicFont => GoogleFonts.cairo();


  static TextStyle font24BoldPrimary({Color? color}) {
    return GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: color ?? AppColors.primary,
    );
  }


  static TextStyle font20SemiBoldWhite = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static TextStyle font16BoldDark = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: const Color(0xFF212121),
  );



  static TextStyle font14MediumDark = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: const Color(0xFF424242),
  );

  static TextStyle font12RegularGrey = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF757575),
  );


  /// (TextField Text / Hint )
  static TextStyle font14RegularHint = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textFormFile,
  );

  static TextStyle font16SemiBoldWhite = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  /// Error Message
  static TextStyle font12MediumRed = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.error,
  );

  static TextTheme getTextTheme(BuildContext context) {
    return GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
  }
}
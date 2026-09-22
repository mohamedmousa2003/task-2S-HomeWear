import 'package:flutter/material.dart';
import '../helpers/my_responsive.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';
import '../utils/app_text_styles.dart';

class AppTheme {
  static ThemeData appTheme(BuildContext context) {
    return ThemeData(
      fontFamily: AppConstants.fontFamily,
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.white,
      // ///? Input Decoration

      textTheme: TextTheme(
        bodyMedium: AppTextStyles.font14MediumDark.copyWith(
          color: AppColors.black,
        ),
        bodyLarge: AppTextStyles.font14MediumDark.copyWith(
          color: AppColors.black,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(

        floatingLabelBehavior: FloatingLabelBehavior.always,
        errorMaxLines: 2,

        labelStyle: WidgetStateTextStyle.resolveWith((states) {
          if (states.contains(WidgetState.error)) {
            return AppTextStyles.font12RegularGrey.copyWith(color: AppColors.error);
          }
          return AppTextStyles.font12RegularGrey.copyWith(color: AppColors.primary);
        }),

        floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
          if (states.contains(WidgetState.error)) {
            return AppTextStyles.font12RegularGrey.copyWith(color: AppColors.error);
          }
          return AppTextStyles.font14MediumDark.copyWith(color: AppColors.black);
        }),

        filled: true,
        fillColor: AppColors.textFormFile,

        errorStyle: AppTextStyles.font12RegularGrey.copyWith(color: AppColors.error),

        hintStyle: AppTextStyles.font14RegularHint.copyWith(
          color: AppColors.black,
        ),

        contentPadding: EdgeInsets.symmetric(
          horizontal: MyResponsive.width(value: 8),
          vertical: MyResponsive.height(value: 12),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(MyResponsive.radius(value: 4)),
          borderSide: const BorderSide(color: AppColors.textFormFile),
        ),


        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(MyResponsive.radius(value: 4)),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),


        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(MyResponsive.radius(value: 4)),
          borderSide: const BorderSide(color: AppColors.error),
        ),


        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(MyResponsive.radius(value: 4)),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),


        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(MyResponsive.radius(value: 4)),
          borderSide: const BorderSide(color: AppColors.textFormFile),
        ),
      ),

      // ///?  Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          disabledForegroundColor: AppColors.white,
          minimumSize: Size(double.infinity, MyResponsive.height(value: 48)),
          textStyle: AppTextStyles.font16SemiBoldWhite,
          foregroundColor: AppColors.white,
          backgroundColor: AppColors.error,
          disabledBackgroundColor: AppColors.textFormFile,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MyResponsive.radius(value: 8)),
          ),
        ),
      ),

      // ///?  AppBar
      appBarTheme: AppBarTheme(
        titleSpacing: 0,
        centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: AppTextStyles.font20SemiBoldWhite,
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      //
      // ///?  Progress Indicator
      // progressIndicatorTheme: const ProgressIndicatorThemeData(
      //   color: AppColors.main,
      // ),
      //
      // ///?  Navigation Bar
      // navigationBarTheme: NavigationBarThemeData(
      //   backgroundColor: AppColors.white,
      //
      //   elevation: 1,
      //
      //   labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      //
      //   indicatorColor: Colors.transparent,
      //
      //   overlayColor: WidgetStateProperty.all(
      //     AppColors.main.withValues(alpha: 0.2),
      //   ),
      //
      //   labelTextStyle: WidgetStateProperty.resolveWith((states) {
      //     return AppTextStyles.regular12(
      //       context,
      //     ).copyWith(color: AppColors.main);
      //   }),
      // ),
    );
  }
}

import 'package:flutter/material.dart';
import '../helpers/my_responsive.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.radiusValue = 100,
    this.isLoading = false,
    this.height,
    this.width,
  });

  final String title;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? radiusValue;
  final bool isLoading;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null || isLoading;

    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primary,
        foregroundColor: foregroundColor ?? AppColors.white,
        disabledBackgroundColor: AppColors.grey,

        minimumSize: Size(
          width ?? double.infinity,
          height ?? MyResponsive.height(value: 50),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            MyResponsive.radius(value: radiusValue ?? 100),
          ),
          side: BorderSide(
            color: isDisabled ? AppColors.grey : (backgroundColor ?? AppColors.primary),
            width: MyResponsive.width(value: 1),
          ),
        ),
      ),
      child: isLoading
          ? SizedBox(
        height: MyResponsive.height(value: 22),
        width: MyResponsive.width(value: 22),
        child: CircularProgressIndicator(
          color: foregroundColor ?? AppColors.white,
          strokeWidth: MyResponsive.width(value: 2),
        ),
      )
          : Text(
        title,
        style: isDisabled
            ? AppTextStyles.font16BoldDark.copyWith(
          color: AppColors.textFormFile,
        )
            : AppTextStyles.font16SemiBoldWhite,
      ),
    );
  }
}
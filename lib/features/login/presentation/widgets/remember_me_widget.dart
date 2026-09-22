import 'package:flutter/material.dart';
import 'package:task2shomewear/core/utils/app_colors.dart';
import 'package:task2shomewear/core/utils/app_text_styles.dart';
import 'package:task2shomewear/core/values/app_strings.dart';

class RememberMeAndForgetWidget extends StatelessWidget {
  const RememberMeAndForgetWidget({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          activeColor: AppColors.primary,
          onChanged: onChanged,
        ),
        Text(
          AppStrings.rememberMe,
          style: AppTextStyles.font16BoldDark.copyWith(
            color: AppColors.black,
          ),
        ),
      ],
    );
  }
}
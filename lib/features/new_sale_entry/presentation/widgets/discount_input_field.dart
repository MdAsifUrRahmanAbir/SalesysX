import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';

/// Labeled discount amount text field. Plain `TextField` rather than the
/// core `PrimaryInputField` — see assumptions note.
class DiscountInputField extends StatelessWidget {
  const DiscountInputField({
    super.key,
    required this.controller,
    this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppStrings.discountLabel(1),
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: AppSizes.fontXs,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: AppSizes.xs),
        SizedBox(
          height: AppSizes.inputHeight - 8,
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            keyboardType:
            const TextInputType.numberWithOptions(decimal: true),
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: AppSizes.fontSm,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              prefixText: '৳',
              contentPadding: EdgeInsets.symmetric(horizontal: AppSizes.sm),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                borderSide: BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                borderSide: BorderSide(color: AppColors.primary),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                borderSide: BorderSide(color: AppColors.border),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
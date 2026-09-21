import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';

/// Search field for outlets/owner names. Plain `TextField` rather than
/// the core `SearchField` — see assumptions note.
class OutletSearchField extends StatelessWidget {
  const OutletSearchField({
    super.key,
    required this.controller,
    this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: TextStyle(
        color: AppColors.textPrimary,
        fontSize: AppSizes.fontSm,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: AppStrings.searchOutletsPlaceholder,
        hintStyle: TextStyle(
          color: AppColors.textHint,
          fontSize: AppSizes.fontSm,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: Icon(
          Icons.search_rounded,
          size: AppSizes.iconSm,
          color: AppColors.textHint,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.sm,
          vertical: AppSizes.sm,
        ),
        filled: true,
        fillColor: AppColors.surface,
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
    );
  }
}
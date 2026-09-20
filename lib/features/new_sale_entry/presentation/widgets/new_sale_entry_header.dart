import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';

/// Page header for the New Sale Entry screen: back button, title, and a
/// trailing help icon. Plain row rather than a core app-bar widget — see
/// assumptions note; promote to `AppHeaderBar`/`CustomAppBar` once its
/// real signature is confirmed.
class NewSaleEntryHeader extends StatelessWidget {
  const NewSaleEntryHeader({
    super.key,
    required this.onBack,
    this.onHelpTap,
  });

  final VoidCallback onBack;
  final VoidCallback? onHelpTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.md,
        vertical: AppSizes.sm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                onTap: onBack,
                borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                child: Padding(
                  padding: EdgeInsets.all(AppSizes.xs),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.textPrimary,
                    size: AppSizes.iconMd,
                  ),
                ),
              ),
              SizedBox(width: AppSizes.xs),
              Text(
                AppStrings.newSaleEntryTitle,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: AppSizes.fontXl,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: onHelpTap,
            borderRadius: BorderRadius.circular(AppSizes.radiusFull),
            child: Padding(
              padding: EdgeInsets.all(AppSizes.xs),
              child: Icon(
                Icons.help_outline_rounded,
                color: AppColors.textSecondary,
                size: AppSizes.iconMd,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
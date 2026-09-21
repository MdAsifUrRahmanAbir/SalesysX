import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';

/// Page header: "Outlets & Customers" title plus a circular add-outlet
/// button. Plain row rather than a core app-bar widget — see repeated
/// assumptions note across other screens in this feature set.
class OutletsCustomersHeader extends StatelessWidget {
  const OutletsCustomersHeader({super.key, this.onAddTap});

  final VoidCallback? onAddTap;

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
          Text(
            AppStrings.outletsAndCustomersTitle,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: AppSizes.fontXl,
              fontWeight: FontWeight.w700,
            ),
          ),
          InkWell(
            onTap: onAddTap,
            borderRadius: BorderRadius.circular(AppSizes.radiusFull),
            child: Container(
              width: AppSizes.xl,
              height: AppSizes.xl,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add_rounded,
                size: AppSizes.iconMd,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
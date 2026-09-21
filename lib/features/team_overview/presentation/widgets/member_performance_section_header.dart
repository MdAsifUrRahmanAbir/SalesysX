import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_color_scheme.dart';

/// "Member Performance" title with a "View All Reports" link.
class MemberPerformanceSectionHeader extends StatelessWidget {
  const MemberPerformanceSectionHeader({super.key, this.onViewAllTap});

  final VoidCallback? onViewAllTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.memberPerformanceTitle,
          style: TextStyle(
            color: context.appColors.textPrimary,
            fontSize: AppSizes.fontMd,
            fontWeight: FontWeight.w700,
          ),
        ),
        InkWell(
          onTap: onViewAllTap,
          child: Text(
            AppStrings.viewAllReports,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: AppSizes.fontXs,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
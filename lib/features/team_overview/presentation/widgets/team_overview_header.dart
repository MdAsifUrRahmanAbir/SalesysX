import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/app_color_scheme.dart';

/// Page header: a teal accent bar + team name, plus a trailing icon
/// button. Uses `context.appColors.*` for theme-adaptive surface/text
/// colors, per the real theming pattern confirmed in main_shell files.
class TeamOverviewHeader extends StatelessWidget {
  const TeamOverviewHeader({
    super.key,
    required this.teamName,
    this.onTrailingTap,
  });

  final String teamName;
  final VoidCallback? onTrailingTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.appColors.surface,
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.md,
        vertical: AppSizes.sm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 18,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppSizes.xs),
                ),
              ),
              SizedBox(width: AppSizes.xs),
              Text(
                teamName,
                style: TextStyle(
                  color: context.appColors.textPrimary,
                  fontSize: AppSizes.fontXl,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: onTrailingTap,
            borderRadius: BorderRadius.circular(AppSizes.radiusFull),
            child: Container(
              width: AppSizes.xxl,
              height: AppSizes.xxl,
              decoration: BoxDecoration(
                color: context.appColors.surface,
                shape: BoxShape.circle,
                border: Border.all(color: context.appColors.border),
              ),
              child: Icon(
                Icons.notifications_none_rounded,
                size: AppSizes.iconMd,
                color: context.appColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/app_color_scheme.dart';
import 'package:salesysx/core/locale/app_localizations_x.dart';

/// Page header: a teal accent bar + "Team Sales" title — same shape as
/// [TeamOverviewHeader] for visual consistency across the Team Head's tabs.
class TeamSalesListHeader extends StatelessWidget {
  const TeamSalesListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.appColors.surface,
      padding: EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.sm),
      child: Row(
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
            context.l10n.teamSalesTitle,
            style: TextStyle(
              color: context.appColors.textPrimary,
              fontSize: AppSizes.fontXl,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

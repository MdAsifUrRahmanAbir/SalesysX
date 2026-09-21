import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import 'profile_stat_card.dart';

/// Row of three [ProfileStatCard]s: this month's sales, active outlet
/// count, and today's completed sales.
class ProfileStatsRow extends StatelessWidget {
  const ProfileStatsRow({
    super.key,
    required this.monthlyAchievedShortLabel,
    required this.monthlyTargetShortLabel,
    required this.activeOutletCount,
    required this.salesTodayCompleted,
  });

  final String monthlyAchievedShortLabel;
  final String monthlyTargetShortLabel;
  final int activeOutletCount;
  final int salesTodayCompleted;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ProfileStatCard(
            label: AppStrings.thisMonthLabel,
            value: monthlyAchievedShortLabel,
            valueColor: AppColors.primary,
            subtitle: '${AppStrings.targetShort} $monthlyTargetShortLabel',
          ),
        ),
        SizedBox(width: AppSizes.sm),
        Expanded(
          child: ProfileStatCard(
            label: AppStrings.customersLabel,
            value: '$activeOutletCount',
            valueColor: AppColors.success,
            subtitle: AppStrings.activeOutlets,
          ),
        ),
        SizedBox(width: AppSizes.sm),
        Expanded(
          child: ProfileStatCard(
            label: AppStrings.salesTodayLabel,
            value: '$salesTodayCompleted',
            valueColor: AppColors.info,
            subtitle: AppStrings.completed,
          ),
        ),
      ],
    );
  }
}
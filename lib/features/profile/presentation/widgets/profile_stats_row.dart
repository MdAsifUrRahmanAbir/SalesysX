import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import 'profile_stat_card.dart';
import 'package:salesysx/core/locale/app_localizations_x.dart';

/// Row of three [ProfileStatCard]s: this month's sales, active outlet
/// count, and today's completed sales.
class ProfileStatsRow extends StatelessWidget {
  const ProfileStatsRow({
    super.key,
    required this.monthlyAchievedShortLabel,
    required this.monthlyTargetShortLabel,
    required this.activeOutletCount,
    required this.salesTodayCompleted,
    this.middleLabel,
    this.middleSubtitle,
  });

  final String monthlyAchievedShortLabel;
  final String monthlyTargetShortLabel;
  final int activeOutletCount;
  final int salesTodayCompleted;
  final String? middleLabel;
  final String? middleSubtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ProfileStatCard(
            label: context.l10n.thisMonthLabel,
            value: monthlyAchievedShortLabel,
            valueColor: AppColors.primary,
            subtitle: '${context.l10n.targetShort} $monthlyTargetShortLabel',
          ),
        ),
        SizedBox(width: AppSizes.sm),
        Expanded(
          child: ProfileStatCard(
            label: middleLabel ?? context.l10n.customersLabel,
            value: '$activeOutletCount',
            valueColor: AppColors.success,
            subtitle: middleSubtitle ?? context.l10n.activeOutlets,
          ),
        ),
        SizedBox(width: AppSizes.sm),
        Expanded(
          child: ProfileStatCard(
            label: context.l10n.salesTodayLabel,
            value: '$salesTodayCompleted',
            valueColor: AppColors.info,
            subtitle: context.l10n.completed,
          ),
        ),
      ],
    );
  }
}
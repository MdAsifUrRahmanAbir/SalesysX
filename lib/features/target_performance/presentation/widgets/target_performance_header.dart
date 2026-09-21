import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/core_widgets.dart';
import '../states/target_performance_state.dart';

/// Page header: "Target Performance" title plus an at-risk/on-track
/// status badge.
class TargetPerformanceHeader extends StatelessWidget {
  const TargetPerformanceHeader({super.key, required this.riskStatus});

  final TargetRiskStatus riskStatus;

  @override
  Widget build(BuildContext context) {
    final isAtRisk = riskStatus == TargetRiskStatus.atRisk;

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
            AppStrings.targetPerformanceTitle,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: AppSizes.fontXl,
              fontWeight: FontWeight.w700,
            ),
          ),
          StatusBadge(
            text: isAtRisk ? AppStrings.statusAtRisk : AppStrings.statusOnTrack,
            type: isAtRisk ? StatusBadgeType.warning : StatusBadgeType.success,
            shape: StatusBadgeShape.square,
            compact: true,
          ),
        ],
      ),
    );
  }
}
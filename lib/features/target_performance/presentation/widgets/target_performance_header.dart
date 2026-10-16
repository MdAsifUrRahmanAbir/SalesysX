import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/core_widgets.dart';
import '../states/target_performance_state.dart';
import 'package:salesysx/core/locale/app_localizations_x.dart';

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
            context.l10n.targetPerformanceTitle,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: AppSizes.fontXl,
              fontWeight: FontWeight.w700,
            ),
          ),
          StatusBadge(
            text: isAtRisk ? context.l10n.statusAtRisk : context.l10n.statusOnTrack,
            type: isAtRisk ? StatusBadgeType.warning : StatusBadgeType.success,
            shape: StatusBadgeShape.square,
            compact: true,
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_color_scheme.dart';
import '../../../../core/widgets/common/custom_card.dart';
import '../../../../core/widgets/utility/donut_chart.dart';

/// Monthly-target summary — a two-segment [DonutChart] showing percent
/// achieved (reused rather than a bespoke progress-ring painter), plus
/// the target figure and an achieved/remaining breakdown.
class TeamMemberTargetCard extends StatelessWidget {
  final double achievedPercent;
  final String monthlyTarget;
  final String achievedAmount;
  final String remainingAmount;

  const TeamMemberTargetCard({
    super.key,
    required this.achievedPercent,
    required this.monthlyTarget,
    required this.achievedAmount,
    required this.remainingAmount,
  });

  @override
  Widget build(BuildContext context) {
    final remainingPercent = (100 - achievedPercent).clamp(0, 100).toDouble();

    return CustomCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DonutChart(
            size: AppSizes.xxl * 2 - AppSizes.xs,
            strokeWidth: AppSizes.sm,
            segments: [
              DonutSegment(value: achievedPercent, color: AppColors.accent),
              DonutSegment(value: remainingPercent, color: AppColors.accentLight),
            ],
            centerValue: '${achievedPercent.toStringAsFixed(0)}%',
            centerLabel: AppStrings.achievedBadge,
          ),
          const SizedBox(width: AppSizes.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.monthlyTargetLabel,
                  style: TextStyle(fontSize: AppSizes.fontXs, fontWeight: FontWeight.w600, color: context.appColors.textHint, letterSpacing: 0.4),
                ),
                const SizedBox(height: AppSizes.xs / 2),
                Text(
                  monthlyTarget,
                  style: TextStyle(fontSize: AppSizes.fontXxl - AppSizes.xs / 2, fontWeight: FontWeight.w800, color: context.appColors.textPrimary),
                ),
                const SizedBox(height: AppSizes.sm),
                Row(
                  children: [
                    Expanded(child: _MiniStat(label: AppStrings.achievedLabel, value: achievedAmount, color: AppColors.success)),
                    const SizedBox(width: AppSizes.sm + AppSizes.xs),
                    Expanded(child: _MiniStat(label: AppStrings.remainingLabel, value: remainingAmount, color: AppColors.error)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _MiniStat({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: AppSizes.fontXs, color: context.appColors.textHint)),
        Text(value, style: TextStyle(fontSize: AppSizes.fontSm, fontWeight: FontWeight.w700, color: color)),
      ],
    );
  }
}
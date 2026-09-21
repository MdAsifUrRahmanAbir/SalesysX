import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/core_widgets.dart';

/// Benchmark comparisons card: period progress / expected achievement /
/// required daily sales rows, a divider, and a working-days-left warning
/// line.
class BenchmarkComparisonsCard extends StatelessWidget {
  const BenchmarkComparisonsCard({
    super.key,
    required this.periodProgressPercent,
    required this.expectedAchievementPercent,
    required this.requiredDailySales,
    required this.workingDaysLeft,
  });

  final double periodProgressPercent;
  final double expectedAchievementPercent;
  final double requiredDailySales;
  final int workingDaysLeft;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: EdgeInsets.all(AppSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.benchmarkComparisons,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: AppSizes.fontSm,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: AppSizes.sm),
          _BenchmarkRow(
            label: AppStrings.periodProgress,
            value: '${periodProgressPercent.round()}%',
            valueColor: AppColors.textPrimary,
          ),
          SizedBox(height: AppSizes.xs),
          _BenchmarkRow(
            label: AppStrings.expectedAchievement,
            value: '${expectedAchievementPercent.round()}%',
            valueColor: AppColors.warning,
          ),
          SizedBox(height: AppSizes.xs),
          _BenchmarkRow(
            label: AppStrings.requiredDailySales,
            value: CurrencyFormatter.format(requiredDailySales),
            valueColor: AppColors.error,
          ),
          SizedBox(height: AppSizes.sm),
          Divider(height: 1, color: AppColors.border),
          SizedBox(height: AppSizes.sm),
          Text(
            AppStrings.workingDaysLeftWarning(workingDaysLeft),
            style: TextStyle(
              color: AppColors.warning,
              fontSize: AppSizes.fontXs,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _BenchmarkRow extends StatelessWidget {
  const _BenchmarkRow({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: AppSizes.fontSm,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: AppSizes.fontSm,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/core_widgets.dart';

/// Monthly target ring card: achieved-percentage ring next to target /
/// achieved / remaining figures.
///
/// NOTE: near-duplicate of `salesman_home/monthly_target_card.dart` —
/// see assumptions note re: promoting a shared `CircularTargetCard` to
/// core/widgets/common once its canonical prop shape is agreed.
class TargetProgressRingCard extends StatelessWidget {
  const TargetProgressRingCard({
    super.key,
    required this.target,
    required this.achieved,
    required this.remaining,
    required this.achievedPercent,
  });

  final double target;
  final double achieved;
  final double remaining;
  final double achievedPercent; // 0..1

  static const double _ringSize = 90;
  static const double _ringStroke = 8;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: EdgeInsets.all(AppSizes.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: _ringSize,
            height: _ringSize,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox.expand(
                  child: CircularProgressIndicator(
                    value: achievedPercent,
                    strokeWidth: _ringStroke,
                    backgroundColor: AppColors.primaryLight,
                    valueColor:
                    const AlwaysStoppedAnimation(AppColors.primary),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${(achievedPercent * 100).round()}%',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: AppSizes.fontLg,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      AppStrings.achievedLabel,
                      style: TextStyle(
                        color: AppColors.textHint,
                        fontSize: AppSizes.fontXs,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: AppSizes.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.monthlyTarget,
                  style: TextStyle(
                    color: AppColors.textHint,
                    fontSize: AppSizes.fontXs,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  CurrencyFormatter.format(target),
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: AppSizes.fontXl,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: AppSizes.xs),
                Row(
                  children: [
                    _FigureColumn(
                      label: AppStrings.achieved,
                      value: CurrencyFormatter.format(achieved),
                      valueColor: AppColors.success,
                    ),
                    SizedBox(width: AppSizes.sm),
                    _FigureColumn(
                      label: AppStrings.remaining,
                      value: CurrencyFormatter.format(remaining),
                      valueColor: AppColors.error,
                    ),
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

class _FigureColumn extends StatelessWidget {
  const _FigureColumn({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.textHint,
            fontSize: AppSizes.fontXs,
            fontWeight: FontWeight.w500,
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
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/core_widgets.dart';
import '../states/target_performance_state.dart';

/// Weekly daily-sales bar chart: 7 bars, each with an amount label above
/// and a day-initial label below. Highlighted bars (per data point) are
/// filled teal; others are neutral grey. Bar heights are scaled
/// proportionally to the highest value in [points] — see assumptions
/// note re: this vs. the mockup's hand-tuned pixel heights.
class DailyTrendBarChart extends StatelessWidget {
  const DailyTrendBarChart({
    super.key,
    required this.title,
    required this.dailyTargetLabel,
    required this.points,
  });

  final String title;
  final String dailyTargetLabel;
  final List<DailyTrendPoint> points;

  static const double _maxBarHeight = 75;
  static const double _barWidth = 14;

  @override
  Widget build(BuildContext context) {
    final maxValue = points.isEmpty
        ? 1.0
        : points.map((p) => p.amount).reduce((a, b) => a > b ? a : b);

    return CustomCard(
      padding: EdgeInsets.all(AppSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: AppSizes.fontSm,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                AppStrings.dailyTargetLabel(dailyTargetLabel),
                style: TextStyle(
                  color: AppColors.textHint,
                  fontSize: AppSizes.fontXs,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.sm),
          SizedBox(
            height: _maxBarHeight + 40,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final point in points)
                  Expanded(
                    child: _TrendBar(
                      point: point,
                      barHeight: maxValue <= 0
                          ? 0
                          : (point.amount / maxValue) * _maxBarHeight,
                      barWidth: _barWidth,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TrendBar extends StatelessWidget {
  const _TrendBar({
    required this.point,
    required this.barHeight,
    required this.barWidth,
  });

  final DailyTrendPoint point;
  final double barHeight;
  final double barWidth;

  @override
  Widget build(BuildContext context) {
    final barColor =
    point.isHighlighted ? AppColors.primary : AppColors.border;
    final labelColor =
    point.isHighlighted ? AppColors.primary : AppColors.textHint;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          point.amountLabel,
          style: TextStyle(
            color: labelColor,
            fontSize: AppSizes.fontXs - 1,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: AppSizes.xs),
        Container(
          width: barWidth,
          height: barHeight,
          decoration: BoxDecoration(
            color: barColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSizes.xs),
              topRight: Radius.circular(AppSizes.xs),
            ),
          ),
        ),
        SizedBox(height: AppSizes.xs),
        Text(
          point.dayLabel,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: AppSizes.fontXs,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
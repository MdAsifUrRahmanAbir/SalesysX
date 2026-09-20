import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/core_widgets.dart';

/// Daily run-rate breakdown card: header with a "days left" badge, target
/// vs. current run-rate rows, and an on-track/off-track footer line.
class DailyRunRateCard extends StatelessWidget {
  const DailyRunRateCard({
    super.key,
    required this.daysLeft,
    required this.targetRunRate,
    required this.currentRunRate,
    required this.isOnTrack,
  });

  final int daysLeft;
  final double targetRunRate;
  final double currentRunRate;
  final bool isOnTrack;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: EdgeInsets.all(AppSizes.sm + AppSizes.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: AppSizes.iconLg,
                    height: AppSizes.iconLg,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                    ),
                    child: Icon(
                      Icons.bar_chart_rounded,
                      size: AppSizes.iconSm,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(width: AppSizes.xs),
                  Text(
                    AppStrings.dailyRunRate,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: AppSizes.fontSm,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              StatusBadge(
                text: AppStrings.daysLeft(daysLeft),
                type: StatusBadgeType.primary,
                shape: StatusBadgeShape.pill,
                compact: true,
              ),
            ],
          ),
          SizedBox(height: AppSizes.sm),
          _RunRateRow(
            label: AppStrings.targetRunRateRequired,
            value:
            '${CurrencyFormatter.format(targetRunRate)}${AppStrings.perDaySuffix}',
            valueColor: AppColors.textPrimary,
          ),
          SizedBox(height: AppSizes.xs),
          _RunRateRow(
            label: AppStrings.currentAvgRunRate,
            value:
            '${CurrencyFormatter.format(currentRunRate)}${AppStrings.perDaySuffix}',
            valueColor: AppColors.success,
          ),
          SizedBox(height: AppSizes.sm),
          Divider(height: 1, color: AppColors.border),
          SizedBox(height: AppSizes.sm),
          Row(
            children: [
              Icon(
                isOnTrack ? Icons.check_circle_rounded : Icons.error_rounded,
                size: AppSizes.iconSm,
                color: isOnTrack ? AppColors.success : AppColors.error,
              ),
              SizedBox(width: AppSizes.xs),
              Expanded(
                child: Text(
                  isOnTrack
                      ? AppStrings.onTrackToAchieveTarget
                      : AppStrings.offTrackForTarget,
                  style: TextStyle(
                    color: isOnTrack ? AppColors.success : AppColors.error,
                    fontSize: AppSizes.fontXs,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RunRateRow extends StatelessWidget {
  const _RunRateRow({
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
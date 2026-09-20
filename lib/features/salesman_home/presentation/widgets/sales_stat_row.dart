import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/core_widgets.dart';

/// Two-up row of stat cards: "Today's Sales" (with a trend) and
/// "Remaining" (neutral) for the salesman dashboard.
///
/// NOTE: `SummaryCard` referenced in the earlier draft does not exist in
/// this codebase (compile error confirmed it). Built as a local
/// `_StatTile` for now — if no equivalent exists anywhere in
/// core/widgets/common, this is a reasonable candidate to promote there
/// (icon + label + value + optional trend is a generic dashboard pattern).
class SalesStatRow extends StatelessWidget {
  const SalesStatRow({
    super.key,
    required this.todaysSales,
    required this.todaysSalesChangePercent,
    required this.remaining,
  });

  final double todaysSales;
  final double todaysSalesChangePercent;
  final double remaining;

  @override
  Widget build(BuildContext context) {
    final changeSign = todaysSalesChangePercent >= 0 ? '+' : '';
    final trendLabel =
        '$changeSign${todaysSalesChangePercent.toStringAsFixed(0)}% '
        '${AppStrings.fromYesterdaySuffix}';

    return Row(
      children: [
        Expanded(
          child: _StatTile(
            icon: Icons.bolt_rounded,
            iconBackgroundColor: AppColors.primaryLight,
            iconColor: AppColors.primary,
            label: AppStrings.todaysSales,
            value: CurrencyFormatter.format(todaysSales),
            footer: trendLabel,
            footerColor: todaysSalesChangePercent >= 0
                ? AppColors.success
                : AppColors.error,
          ),
        ),
        SizedBox(width: AppSizes.sm),
        Expanded(
          child: _StatTile(
            icon: Icons.schedule_rounded,
            iconBackgroundColor: AppColors.warning.withValues(alpha: 0.12),
            iconColor: AppColors.warning,
            label: AppStrings.remaining,
            value: CurrencyFormatter.format(remaining),
            footer: AppStrings.toReachTarget,
            footerColor: AppColors.textHint,
          ),
        ),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.footer,
    required this.footerColor,
  });

  final IconData icon;
  final Color iconBackgroundColor;
  final Color iconColor;
  final String label;
  final String value;
  final String footer;
  final Color footerColor;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: EdgeInsets.all(AppSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: AppSizes.iconLg,
                height: AppSizes.iconLg,
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                ),
                child: Icon(icon, size: AppSizes.iconSm, color: iconColor),
              ),
              SizedBox(width: AppSizes.xs),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: AppSizes.fontXs,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.sm),
          Text(
            value,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: AppSizes.fontXl,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: AppSizes.xs),
          Text(
            footer,
            style: TextStyle(
              color: footerColor,
              fontSize: AppSizes.fontXs,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
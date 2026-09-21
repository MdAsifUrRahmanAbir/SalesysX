import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/core_widgets.dart';
import '../states/outlets_customers_state.dart';

/// Outlet/customer summary card: status dot + name + status badge,
/// divider, then owner / area / last-visit / last-order-amount rows.
class OutletCard extends StatelessWidget {
  const OutletCard({super.key, required this.outlet, this.onTap});

  final OutletCustomer outlet;
  final VoidCallback? onTap;

  StatusBadgeType get _badgeType => switch (outlet.status) {
    OutletCustomerStatus.active => StatusBadgeType.success,
    OutletCustomerStatus.newCustomer => StatusBadgeType.info,
    OutletCustomerStatus.potential => StatusBadgeType.warning,
  };

  Color get _dotColor => switch (outlet.status) {
    OutletCustomerStatus.active => AppColors.success,
    OutletCustomerStatus.newCustomer => AppColors.info,
    OutletCustomerStatus.potential => AppColors.warning,
  };

  String get _badgeText => switch (outlet.status) {
    OutletCustomerStatus.active => AppStrings.filterActive,
    OutletCustomerStatus.newCustomer => AppStrings.filterNew,
    OutletCustomerStatus.potential => AppStrings.filterPotential,
  };

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      child: CustomCard(
        padding: EdgeInsets.all(AppSizes.md),
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
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: _dotColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: AppSizes.xs),
                    Text(
                      outlet.name,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: AppSizes.fontMd,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                StatusBadge(
                  text: _badgeText,
                  type: _badgeType,
                  shape: StatusBadgeShape.square,
                  compact: true,
                ),
              ],
            ),
            SizedBox(height: AppSizes.sm),
            Divider(height: 1, color: AppColors.border),
            SizedBox(height: AppSizes.sm),
            _DetailRow(label: AppStrings.ownerLabel, value: outlet.owner),
            SizedBox(height: AppSizes.xs),
            _DetailRow(
              label: AppStrings.areaRouteLabel,
              value: outlet.areaRoute,
            ),
            SizedBox(height: AppSizes.xs),
            _DetailRow(
              label: AppStrings.lastVisitLabel,
              value: outlet.lastVisit,
              valueColor: AppColors.textSecondary,
            ),
            SizedBox(height: AppSizes.xs),
            _DetailRow(
              label: AppStrings.lastOrderAmountLabel,
              value: CurrencyFormatter.format(outlet.lastOrderAmount),
              valueColor: AppColors.primary,
              valueWeight: FontWeight.w700,
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.valueWeight = FontWeight.w600,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final FontWeight valueWeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.textHint,
            fontSize: AppSizes.fontXs,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? AppColors.textPrimary,
            fontSize: AppSizes.fontXs,
            fontWeight: valueWeight,
          ),
        ),
      ],
    );
  }
}
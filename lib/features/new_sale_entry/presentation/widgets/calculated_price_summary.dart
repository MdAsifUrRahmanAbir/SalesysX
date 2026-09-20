import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/currency_formatter.dart';

/// Teal-tinted calculated-price summary: label, a plain-language
/// breakdown ("N Units × price - discount"), and the resulting total.
class CalculatedPriceSummary extends StatelessWidget {
  const CalculatedPriceSummary({
    super.key,
    required this.quantity,
    required this.unitPrice,
    required this.discount,
    required this.total,
  });

  final int quantity;
  final double unitPrice;
  final double discount;
  final double total;

  @override
  Widget build(BuildContext context) {
    final breakdown = AppStrings.calculatedPriceBreakdown(
      quantity,
      CurrencyFormatter.format(unitPrice),
      CurrencyFormatter.format(discount),
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.sm + AppSizes.xs),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        border: Border.all(color: AppColors.primary),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.calculatedPriceLabel,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: AppSizes.fontXs,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  breakdown,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: AppSizes.fontXs,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Text(
            CurrencyFormatter.format(total),
            style: TextStyle(
              color: AppColors.primaryDark,
              fontSize: AppSizes.fontXl,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
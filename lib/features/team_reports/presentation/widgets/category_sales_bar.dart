import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/app_color_scheme.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../states/team_reports_state.dart';

class CategorySalesBar extends StatelessWidget {
  const CategorySalesBar({super.key, required this.row});

  final CategorySalesRow row;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                row.category,
                style: TextStyle(fontSize: AppSizes.fontSm, fontWeight: FontWeight.w600, color: context.appColors.textPrimary),
              ),
              Text(
                CurrencyFormatter.format(row.amount),
                style: TextStyle(fontSize: AppSizes.fontSm, fontWeight: FontWeight.w700, color: context.appColors.textPrimary),
              ),
            ],
          ),
          SizedBox(height: AppSizes.xs),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.xs),
            child: LinearProgressIndicator(
              value: row.shareOfMax.clamp(0, 1),
              minHeight: 8,
              backgroundColor: context.appColors.border,
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}

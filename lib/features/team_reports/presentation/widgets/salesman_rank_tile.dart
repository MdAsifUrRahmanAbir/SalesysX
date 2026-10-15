import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/app_color_scheme.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/common/custom_card.dart';
import '../states/team_reports_state.dart';

class SalesmanRankTile extends StatelessWidget {
  const SalesmanRankTile({super.key, required this.rank, required this.row});

  final int rank;
  final SalesmanRankRow row;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.sm),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: rank <= 1 ? AppColors.primaryLight : context.appColors.background,
              shape: BoxShape.circle,
              border: Border.all(color: rank <= 1 ? AppColors.primary : context.appColors.border),
            ),
            child: Text(
              '$rank',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: rank <= 1 ? AppColors.primary : context.appColors.textSecondary,
              ),
            ),
          ),
          SizedBox(width: AppSizes.sm),
          Expanded(
            child: Text(
              row.name,
              style: TextStyle(fontSize: AppSizes.fontSm, fontWeight: FontWeight.w700, color: context.appColors.textPrimary),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            CurrencyFormatter.format(row.achieved),
            style: TextStyle(fontSize: AppSizes.fontSm, fontWeight: FontWeight.w600, color: context.appColors.textSecondary),
          ),
          SizedBox(width: AppSizes.sm),
          SizedBox(
            width: 48,
            child: Text(
              '${row.achievedPercent}%',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: AppSizes.fontSm, fontWeight: FontWeight.w800, color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}

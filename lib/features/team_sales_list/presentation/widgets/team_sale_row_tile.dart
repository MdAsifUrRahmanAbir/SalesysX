import 'package:flutter/material.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/app_color_scheme.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/widgets/common/custom_card.dart';
import '../states/team_sales_list_state.dart';

/// Read-only row: salesman + outlet/product, date, amount.
class TeamSaleRowTile extends StatelessWidget {
  const TeamSaleRowTile({super.key, required this.row});

  final TeamSaleRow row;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: EdgeInsets.all(AppSizes.sm + AppSizes.xs),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  row.salesmanName,
                  style: TextStyle(fontSize: AppSizes.fontSm, fontWeight: FontWeight.w700, color: context.appColors.textPrimary),
                ),
                const SizedBox(height: 2),
                Text(
                  '${row.outletName} • ${row.productName}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: AppSizes.fontXs, color: context.appColors.textSecondary),
                ),
                const SizedBox(height: 2),
                Text(
                  '${DateFormatter.shortDate(row.date)}, ${DateFormatter.time(row.date)}',
                  style: TextStyle(fontSize: AppSizes.fontXs, color: context.appColors.textHint),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSizes.sm),
          Text(
            CurrencyFormatter.format(row.amount),
            style: TextStyle(fontSize: AppSizes.fontMd, fontWeight: FontWeight.w800, color: context.appColors.textPrimary),
          ),
        ],
      ),
    );
  }
}

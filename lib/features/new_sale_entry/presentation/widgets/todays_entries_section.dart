import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../states/new_sale_entry_state.dart';

/// "Today's Entries" list section: a title followed by one tile per
/// completed sale entry.
class TodaysEntriesSection extends StatelessWidget {
  const TodaysEntriesSection({super.key, required this.entries});

  final List<TodaysSaleEntry> entries;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppStrings.todaysEntries,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: AppSizes.fontSm,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: AppSizes.sm),
        ...entries.map(
              (entry) => Padding(
            padding: EdgeInsets.only(bottom: AppSizes.sm),
            child: _TodaysEntryTile(entry: entry),
          ),
        ),
      ],
    );
  }
}

class _TodaysEntryTile extends StatelessWidget {
  const _TodaysEntryTile({required this.entry});

  final TodaysSaleEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.check_rounded,
                    size: AppSizes.iconSm,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(width: AppSizes.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        entry.outletName,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: AppSizes.fontSm,
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        AppStrings.entryMetaLine(
                          entry.location,
                          entry.itemCount,
                          entry.time,
                        ),
                        style: TextStyle(
                          color: AppColors.textHint,
                          fontSize: AppSizes.fontXs,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(
            CurrencyFormatter.format(entry.amount),
            style: TextStyle(
              color: AppColors.primaryDark,
              fontSize: AppSizes.fontSm,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
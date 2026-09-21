import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';

/// Single-select horizontal status filter row ("All", "Active", "New",
/// "Potential"). Near-duplicate of `new_sale_entry`'s category chips —
/// see assumptions note re: promoting a shared chip-group core widget.
class OutletStatusFilterChips extends StatelessWidget {
  const OutletStatusFilterChips({
    super.key,
    required this.options,
    required this.selected,
    required this.onSelected,
  });

  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: options.length,
        separatorBuilder: (_, __) => SizedBox(width: AppSizes.xs),
        itemBuilder: (context, index) {
          final option = options[index];
          final isSelected = option == selected;
          return InkWell(
            onTap: () => onSelected(option),
            borderRadius: BorderRadius.circular(AppSizes.radiusFull),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.sm + AppSizes.xs,
                vertical: AppSizes.xs,
              ),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.surface,
                borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                border:
                isSelected ? null : Border.all(color: AppColors.border),
              ),
              alignment: Alignment.center,
              child: Text(
                option,
                style: TextStyle(
                  color: isSelected
                      ? AppColors.textWhite
                      : AppColors.textSecondary,
                  fontSize: AppSizes.fontSm,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
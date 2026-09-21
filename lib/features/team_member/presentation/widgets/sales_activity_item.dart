import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/app_color_scheme.dart';
import '../../../../core/widgets/common/custom_card.dart';
import '../../../../core/widgets/common/square_icon_tile.dart';

/// Single row in the member's recent-sales list — a tinted store
/// icon, outlet name + line item/time, and the sale amount. Composes
/// entirely from existing core widgets ([CustomCard], [SquareIconTile]).
class SalesActivityItem extends StatelessWidget {
  final String outletName;
  final String detailLine;
  final String amount;
  final VoidCallback? onTap;

  const SalesActivityItem({
    super.key,
    required this.outletName,
    required this.detailLine,
    required this.amount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppSizes.sm + AppSizes.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SquareIconTile(icon: Icons.storefront_outlined, color: AppColors.accent),
          const SizedBox(width: AppSizes.sm + AppSizes.xs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  outletName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: AppSizes.fontMd, fontWeight: FontWeight.w700, color: context.appColors.textPrimary),
                ),
                const SizedBox(height: AppSizes.xs / 2),
                Text(
                  detailLine,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: AppSizes.fontXs, color: context.appColors.textHint),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSizes.sm),
          Text(
            amount,
            style: TextStyle(fontSize: AppSizes.fontMd, fontWeight: FontWeight.w800, color: AppColors.accent),
          ),
        ],
      ),
    );
  }
}
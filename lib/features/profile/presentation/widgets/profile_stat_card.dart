import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/core_widgets.dart';

/// Single stat tile: caps label, large colored figure, small subtitle.
/// Distinct shape from the icon-based stat tile used in
/// `new_sale_entry` — see assumptions note re: unifying stat-card shapes.
class ProfileStatCard extends StatelessWidget {
  const ProfileStatCard({
    super.key,
    required this.label,
    required this.value,
    required this.valueColor,
    required this.subtitle,
  });

  final String label;
  final String value;
  final Color valueColor;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: EdgeInsets.all(AppSizes.sm + AppSizes.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.textHint,
              fontSize: AppSizes.fontXs,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppSizes.xs),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: AppSizes.fontLg,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: AppSizes.fontXs - 1,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
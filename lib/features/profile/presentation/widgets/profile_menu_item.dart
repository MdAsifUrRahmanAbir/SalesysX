import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/widgets/core_widgets.dart';

/// Icon-tile + title + subtitle + chevron menu row.
///
/// NOTE: this is a strong candidate for your documented `SettingsTile`
/// (icon/title/subtitle/chevron via `SettingsTileTrailing`) — built local
/// for now since that widget's exact constructor is unconfirmed. Paste
/// its source and this becomes a thin wrapper or gets removed entirely.
class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.isDestructive = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final iconBackground =
    isDestructive ? AppColors.error.withValues(alpha: 0.12) : AppColors.primaryLight;
    final iconColor = isDestructive ? AppColors.error : AppColors.primary;
    final titleColor = isDestructive ? AppColors.error : AppColors.textPrimary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      child: CustomCard(
        padding: EdgeInsets.all(AppSizes.md),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: AppSizes.iconLg + AppSizes.xs,
                    height: AppSizes.iconLg + AppSizes.xs,
                    decoration: BoxDecoration(
                      color: iconBackground,
                      borderRadius: BorderRadius.circular(AppSizes.radiusSm),
                    ),
                    alignment: Alignment.center,
                    child: Icon(icon, size: AppSizes.iconMd, color: iconColor),
                  ),
                  SizedBox(width: AppSizes.sm + AppSizes.xs),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: titleColor,
                            fontSize: AppSizes.fontSm,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          subtitle,
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
            Icon(
              Icons.chevron_right_rounded,
              size: AppSizes.iconSm,
              color: AppColors.textHint,
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';

/// Top greeting row for the salesman home dashboard: avatar with initials,
/// a two-line "Assalamu Alaikum, <Name>" greeting, and a notification bell.
///
/// NOTE: uses a plain [CircleAvatar] rather than the core `AppAvatar`
/// widget — its real constructor doesn't take `initials`/`borderColor`/
/// `size` as guessed earlier. Swap this back to `AppAvatar` once its
/// actual signature is confirmed.
class SalesmanGreetingHeader extends StatelessWidget {
  const SalesmanGreetingHeader({
    super.key,
    required this.name,
    required this.avatarInitials,
    this.onNotificationTap,
  });

  final String name;
  final String avatarInitials;
  final VoidCallback? onNotificationTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: AppSizes.xxl / 2,
              backgroundColor: AppColors.primaryLight,
              child: Text(
                avatarInitials,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: AppSizes.fontMd,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(width: AppSizes.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.salesmanGreeting,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: AppSizes.fontSm,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  name,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: AppSizes.fontLg,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
        InkWell(
          onTap: onNotificationTap,
          borderRadius: BorderRadius.circular(AppSizes.radiusFull),
          child: Container(
            width: AppSizes.xxl,
            height: AppSizes.xxl,
            decoration: BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border),
            ),
            child: Icon(
              Icons.notifications_none_rounded,
              size: AppSizes.iconMd,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
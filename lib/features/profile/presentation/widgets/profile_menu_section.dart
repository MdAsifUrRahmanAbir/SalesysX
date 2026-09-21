import 'package:flutter/material.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import 'profile_menu_item.dart';

/// Vertical stack of the profile page's menu rows: My Sales Report,
/// My Achievement, Settings, and Logout.
class ProfileMenuSection extends StatelessWidget {
  const ProfileMenuSection({
    super.key,
    this.onSalesReportTap,
    this.onTeamSalesReportTap,
    this.onAchievementTap,
    this.onSettingsTap,
    this.onLogoutTap,
  });

  final VoidCallback? onSalesReportTap;
  final VoidCallback? onTeamSalesReportTap;
  final VoidCallback? onAchievementTap;
  final VoidCallback? onSettingsTap;
  final VoidCallback? onLogoutTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileMenuItem(
          icon: Icons.area_chart,
          title: AppStrings.teamTargetAndPerformance,
          subtitle: AppStrings.mySalesReportSubtitle,
          onTap: onTeamSalesReportTap,
        ),
        SizedBox(height: AppSizes.sm),
        ProfileMenuItem(
          icon: Icons.bar_chart_rounded,
          title: AppStrings.mySalesReportTitle,
          subtitle: AppStrings.mySalesReportSubtitle,
          onTap: onSalesReportTap,
        ),
        SizedBox(height: AppSizes.sm),
        ProfileMenuItem(
          icon: Icons.trending_up_rounded,
          title: AppStrings.myAchievementTitle,
          subtitle: AppStrings.myAchievementSubtitle,
          onTap: onAchievementTap,
        ),
        SizedBox(height: AppSizes.sm),
        ProfileMenuItem(
          icon: Icons.settings_outlined,
          title: AppStrings.settingsTitle,
          subtitle: AppStrings.settingsSubtitle,
          onTap: onSettingsTap,
        ),
        SizedBox(height: AppSizes.sm),
        ProfileMenuItem(
          icon: Icons.logout_rounded,
          title: AppStrings.logoutTitle,
          subtitle: AppStrings.logoutSubtitle,
          onTap: onLogoutTap,
          isDestructive: true,
        ),
      ],
    );
  }
}
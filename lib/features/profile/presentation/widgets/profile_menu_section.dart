import 'package:flutter/material.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import 'profile_menu_item.dart';

/// Vertical stack of the profile page's menu rows. Every role gets the
/// same personal rows (My Sales Report, My Achievement); a Team Head
/// additionally gets their team-only rows (Dashboard, Sales Log,
/// Reports) stacked on top — the only difference between the two
/// roles' Profile menu.
class ProfileMenuSection extends StatelessWidget {
  const ProfileMenuSection({
    super.key,
    this.isTeamHead = false,
    this.onSalesReportTap,
    this.onAchievementTap,
    this.onTeamDashboardTap,
    this.onTeamSalesLogTap,
    this.onTeamReportsTap,
    this.onSettingsTap,
    this.onLogoutTap,
  });

  final bool isTeamHead;
  final VoidCallback? onSalesReportTap;
  final VoidCallback? onAchievementTap;
  final VoidCallback? onTeamDashboardTap;
  final VoidCallback? onTeamSalesLogTap;
  final VoidCallback? onTeamReportsTap;
  final VoidCallback? onSettingsTap;
  final VoidCallback? onLogoutTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        if (isTeamHead) ...[
          ProfileMenuItem(
            icon: Icons.dashboard_outlined,
            title: AppStrings.teamDashboardMenuTitle,
            subtitle: AppStrings.teamDashboardMenuSubtitle,
            onTap: onTeamDashboardTap,
          ),
          SizedBox(height: AppSizes.sm),
          ProfileMenuItem(
            icon: Icons.receipt_long_outlined,
            title: AppStrings.teamSalesLogMenuTitle,
            subtitle: AppStrings.teamSalesLogMenuSubtitle,
            onTap: onTeamSalesLogTap,
          ),
          SizedBox(height: AppSizes.sm),
          ProfileMenuItem(
            icon: Icons.leaderboard_outlined,
            title: AppStrings.teamReportsMenuTitle,
            subtitle: AppStrings.teamReportsMenuSubtitle,
            onTap: onTeamReportsTap,
          ),
          SizedBox(height: AppSizes.sm),
        ],
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

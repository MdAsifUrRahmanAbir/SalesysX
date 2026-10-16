import 'package:flutter/material.dart';

import '../../../../core/constants/app_sizes.dart';
import 'profile_menu_item.dart';
import 'package:salesysx/core/locale/app_localizations_x.dart';

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
          title: context.l10n.mySalesReportTitle,
          subtitle: context.l10n.mySalesReportSubtitle,
          onTap: onSalesReportTap,
        ),
        SizedBox(height: AppSizes.sm),
        ProfileMenuItem(
          icon: Icons.trending_up_rounded,
          title: context.l10n.myAchievementTitle,
          subtitle: context.l10n.myAchievementSubtitle,
          onTap: onAchievementTap,
        ),
        SizedBox(height: AppSizes.sm),
        if (isTeamHead) ...[
          ProfileMenuItem(
            icon: Icons.dashboard_outlined,
            title: context.l10n.teamDashboardMenuTitle,
            subtitle: context.l10n.teamDashboardMenuSubtitle,
            onTap: onTeamDashboardTap,
          ),
          SizedBox(height: AppSizes.sm),
          ProfileMenuItem(
            icon: Icons.receipt_long_outlined,
            title: context.l10n.teamSalesLogMenuTitle,
            subtitle: context.l10n.teamSalesLogMenuSubtitle,
            onTap: onTeamSalesLogTap,
          ),
          SizedBox(height: AppSizes.sm),
          ProfileMenuItem(
            icon: Icons.leaderboard_outlined,
            title: context.l10n.teamReportsMenuTitle,
            subtitle: context.l10n.teamReportsMenuSubtitle,
            onTap: onTeamReportsTap,
          ),
          SizedBox(height: AppSizes.sm),
        ],
        ProfileMenuItem(
          icon: Icons.settings_outlined,
          title: context.l10n.settingsTitle,
          subtitle: context.l10n.settingsSubtitle,
          onTap: onSettingsTap,
        ),
        SizedBox(height: AppSizes.sm),
        ProfileMenuItem(
          icon: Icons.logout_rounded,
          title: context.l10n.logoutTitle,
          subtitle: context.l10n.logoutSubtitle,
          onTap: onLogoutTap,
          isDestructive: true,
        ),
      ],
    );
  }
}

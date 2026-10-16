import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/user_role.dart';
import '../../../../core/widgets/utility/custom_alert_dialog.dart';
import '../../../../core/widgets/utility/custom_refresh_wrapper.dart';
import '../../../../core/widgets/utility/custom_shimmer.dart';
import '../../../../core/widgets/utility/error_state.dart';
import '../../../../routes/route_names.dart';
import '../controllers/profile_controller.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_menu_section.dart';
import '../widgets/profile_stats_row.dart';
import 'package:salesysx/core/locale/app_localizations_x.dart';

class ProfileMobileView extends ConsumerWidget {
  const ProfileMobileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileControllerProvider);
    final controller = ref.read(profileControllerProvider.notifier);

    if (state.isLoading && state.name.isEmpty) {
      return Container(color: AppColors.background, child: SafeArea(child: _buildShimmer()));
    }
    if (state.errorMessage != null && state.name.isEmpty) {
      return Container(
        color: AppColors.background,
        child: SafeArea(child: ErrorState(message: state.errorMessage!, onRetry: controller.refresh)),
      );
    }

    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: CustomRefreshWrapper(
          onRefresh: controller.refresh,
          child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ProfileHeader(
              name: state.name,
              avatarInitials: state.avatarInitials,
              employeeId: state.employeeId,
              roleLabel: switch (state.role) {
                UserRole.superAdmin || UserRole.admin || UserRole.manager => context.l10n.roleAdmin,
                UserRole.teamHead => context.l10n.roleTeamHead,
                UserRole.salesman => context.l10n.profileRoleSalesman,
              },
              team: state.team,
              division: state.division,
            ),
            Padding(
              padding: EdgeInsets.all(AppSizes.md),
              child: Column(
                children: [
                  ProfileStatsRow(
                    monthlyAchievedShortLabel:
                    state.monthlyAchievedShortLabel,
                    monthlyTargetShortLabel: state.monthlyTargetShortLabel,
                    activeOutletCount: state.activeOutletCount,
                    salesTodayCompleted: state.salesTodayCompleted,
                  ),
                  SizedBox(height: AppSizes.lg),
                  ProfileMenuSection(
                    isTeamHead: state.isTeamHead,
                    onSalesReportTap: () {
                      context.push(RouteNames.new_sale_entry);
                    },
                    onAchievementTap: () {
                      context.push(RouteNames.target_performance);
                    },
                    onTeamDashboardTap: () {
                      context.push(RouteNames.team_overview);
                    },
                    onTeamSalesLogTap: () {
                      context.push(RouteNames.team_sales_list);
                    },
                    onTeamReportsTap: () {
                      context.push(RouteNames.team_reports);
                    },
                    onSettingsTap: () {
                      context.push(RouteNames.settings);
                    },
                    onLogoutTap: () async {
                      final confirmed = await CustomAlertDialog.confirm(
                        context,
                        title: context.l10n.logoutConfirmTitle,
                        message: context.l10n.logoutConfirmMessage,
                        confirmText: context.l10n.logoutTitle,
                        destructive: true,
                      );
                      if (confirmed != true) return;

                      await controller.logout();
                      if (!context.mounted) return;
                      context.go(RouteNames.login);
                    },                  ),
                ],
              ),
            ),
          ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return Padding(
      padding: EdgeInsets.all(AppSizes.md),
      child: Column(
        children: [
          CustomShimmer(height: 180, borderRadius: BorderRadius.circular(AppSizes.radiusLg)),
          SizedBox(height: AppSizes.lg),
          CustomShimmer(height: 90, borderRadius: BorderRadius.circular(AppSizes.radiusLg)),
          SizedBox(height: AppSizes.lg),
          CustomShimmer(height: 220, borderRadius: BorderRadius.circular(AppSizes.radiusLg)),
        ],
      ),
    );
  }
}
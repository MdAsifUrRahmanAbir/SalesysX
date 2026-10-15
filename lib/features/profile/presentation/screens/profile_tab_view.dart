import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/utility/custom_alert_dialog.dart';
import '../../../../core/widgets/utility/custom_refresh_wrapper.dart';
import '../../../../core/widgets/utility/error_state.dart';
import '../../../../routes/route_names.dart';
import '../controllers/profile_controller.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_menu_section.dart';
import '../widgets/profile_stats_row.dart';

class ProfileTabView extends ConsumerWidget {
  const ProfileTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileControllerProvider);
    final controller = ref.read(profileControllerProvider.notifier);

    if (state.errorMessage != null && state.name.isEmpty) {
      return Container(
        color: AppColors.background,
        child: SafeArea(child: ErrorState(message: state.errorMessage!, onRetry: controller.refresh)),
      );
    }

    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: CustomRefreshWrapper(
              onRefresh: controller.refresh,
              child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ProfileHeader(
                  name: state.name,
                  avatarInitials: state.avatarInitials,
                  employeeId: state.employeeId,
                  roleLabel: state.roleLabel,
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
                        monthlyTargetShortLabel:
                        state.monthlyTargetShortLabel,
                        activeOutletCount: state.activeOutletCount,
                        salesTodayCompleted: state.salesTodayCompleted,
                        middleLabel: state.middleStatLabel,
                        middleSubtitle: state.middleStatSubtitle,
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
                            title: AppStrings.logoutConfirmTitle,
                            message: AppStrings.logoutConfirmMessage,
                            confirmText: AppStrings.logoutTitle,
                            destructive: true,
                          );
                          if (confirmed != true) return;

                          await controller.logout();
                          if (!context.mounted) return;
                          context.go(RouteNames.login);
                        },
                      ),
                    ],
                  ),
                ),
              ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

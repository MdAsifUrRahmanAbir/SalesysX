import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../controllers/profile_controller.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_menu_section.dart';
import '../widgets/profile_stats_row.dart';

class ProfileMobileView extends ConsumerWidget {
  const ProfileMobileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileControllerProvider);
    final controller = ref.read(profileControllerProvider.notifier);

    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ProfileHeader(
              name: state.name,
              avatarInitials: state.avatarInitials,
              employeeId: state.employeeId,
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
                    onSalesReportTap: () {
                      // TODO: wire to context.push(RouteNames.salesReport)
                    },
                    onAchievementTap: () {
                      // TODO: wire to context.push(
                      // RouteNames.targetPerformance)
                    },
                    onSettingsTap: () {
                      // TODO: wire to context.push(RouteNames.settings)
                    },
                    onLogoutTap: () async {
                      // TODO: show a confirm dialog, then call
                      // controller.logout() and context.go(
                      // RouteNames.login) on success.
                      await controller.logout();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
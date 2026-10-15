import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:salesysx/routes/route_names.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_color_scheme.dart';
import '../../../../core/widgets/utility/custom_refresh_wrapper.dart';
import '../../../../core/widgets/utility/custom_shimmer.dart';
import '../../../../core/widgets/utility/custom_snackbar.dart';
import '../../../../core/widgets/utility/error_state.dart';
import '../../../notifications/presentation/controllers/notification_controller.dart';
import '../controllers/team_overview_controller.dart';
import '../widgets/add_member_fab.dart';
import '../widgets/member_performance_section_header.dart';
import '../widgets/team_member_performance_card.dart';
import '../widgets/team_overview_header.dart';
import '../widgets/team_target_summary_card.dart';

class TeamOverviewMobileView extends ConsumerWidget {
  const TeamOverviewMobileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(teamOverviewControllerProvider);
    final controller = ref.read(teamOverviewControllerProvider.notifier);
    final isFirstLoad = state.isLoading && state.teamName.isEmpty;

    return Container(
      color: context.appColors.background,
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                TeamOverviewHeader(
                  teamName: state.teamName,
                  unreadCount: ref.watch(notificationControllerProvider).unreadCount,
                  onTrailingTap: () => context.push(RouteNames.notifications),
                ),
                Expanded(
                  child: isFirstLoad
                      ? _buildShimmer()
                      : state.errorMessage != null
                          ? ErrorState(message: state.errorMessage!, onRetry: controller.refresh)
                          : CustomRefreshWrapper(
                              onRefresh: controller.refresh,
                              child: ListView(
                                padding: EdgeInsets.all(AppSizes.md),
                                children: [
                                  TeamTargetSummaryCard(
                                    totalTarget: state.totalTarget,
                                    totalAchieved: state.totalAchieved,
                                    achievedPercent: state.totalAchievedPercent,
                                    totalMembers: state.totalMembers,
                                    onlineCount: state.onlineCount,
                                  ),
                                  SizedBox(height: AppSizes.lg),
                                  MemberPerformanceSectionHeader(
                                    onViewAllTap: () => context.push(RouteNames.team_reports),
                                  ),
                                  SizedBox(height: AppSizes.sm),
                                  for (final member in state.members) ...[
                                    TeamMemberPerformanceCard(
                                      member: member,
                                      onTap: () => context.push(
                                        '${RouteNames.team_member}?email=${Uri.encodeQueryComponent(member.email)}',
                                      ),
                                    ),
                                    SizedBox(height: AppSizes.sm),
                                  ],
                                  SizedBox(height: AppSizes.xxl),
                                ],
                              ),
                            ),
                ),
              ],
            ),
            Positioned(
              right: AppSizes.md,
              bottom: AppSizes.lg,
              child: AddMemberFab(
                onTap: () => CustomSnackBar.show(context, AppStrings.managedFromAdminPanel),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return Padding(
      padding: EdgeInsets.all(AppSizes.md),
      child: Column(
        children: [
          CustomShimmer(height: 160, borderRadius: BorderRadius.circular(AppSizes.radiusLg)),
          SizedBox(height: AppSizes.lg),
          CustomShimmer(height: 120, borderRadius: BorderRadius.circular(AppSizes.radiusLg)),
          SizedBox(height: AppSizes.sm),
          CustomShimmer(height: 120, borderRadius: BorderRadius.circular(AppSizes.radiusLg)),
        ],
      ),
    );
  }
}
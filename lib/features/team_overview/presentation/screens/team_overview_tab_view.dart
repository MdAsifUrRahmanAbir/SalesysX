import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/app_color_scheme.dart';
import '../controllers/team_overview_controller.dart';
import '../widgets/add_member_fab.dart';
import '../widgets/member_performance_section_header.dart';
import '../widgets/team_member_performance_card.dart';
import '../widgets/team_overview_header.dart';
import '../widgets/team_target_summary_card.dart';

class TeamOverviewTabView extends ConsumerWidget {
  const TeamOverviewTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(teamOverviewControllerProvider);

    return Container(
      color: context.appColors.background,
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                TeamOverviewHeader(
                  teamName: state.teamName,
                  onTrailingTap: () {
                    // TODO: wire to context.push(RouteNames.notifications)
                  },
                ),
                Expanded(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 480),
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
                            onViewAllTap: () {
                              // TODO: wire to context.push(
                              // RouteNames.allMemberReports)
                            },
                          ),
                          SizedBox(height: AppSizes.sm),
                          for (final member in state.members) ...[
                            TeamMemberPerformanceCard(
                              member: member,
                              onTap: () {
                                // TODO: wire to context.push(
                                // RouteNames.memberDetail, extra: member)
                              },
                            ),
                            SizedBox(height: AppSizes.sm),
                          ],
                          SizedBox(height: AppSizes.xxl),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              right: AppSizes.md,
              bottom: AppSizes.lg,
              child: AddMemberFab(
                onTap: () {
                  // TODO: wire to context.push(RouteNames.addTeamMember)
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
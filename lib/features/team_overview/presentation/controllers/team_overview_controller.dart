import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../states/team_overview_state.dart';

final teamOverviewControllerProvider =
NotifierProvider.autoDispose<TeamOverviewController, TeamOverviewState>(
  TeamOverviewController.new,
);

class TeamOverviewController extends Notifier<TeamOverviewState> {
  @override
  TeamOverviewState build() {
    // TODO: wire to teamOverviewRepositoryProvider.getTeamOverview()
    // once features/team_overview/data is ready.
    // Values below mirror the approved design as placeholders.
    return const TeamOverviewState(
      teamName: 'Team Alpha',
      totalTarget: 1500000,
      totalAchieved: 975000,
      totalMembers: 4,
      onlineCount: 3,
      members: [
        TeamMemberPerformance(
          name: 'Rahim Uddin',
          initials: 'RU',
          role: 'Salesman',
          isOnline: true,
          target: 500000,
          achieved: 340000,
          todaySale: 8500,
          achievedPercent: 68,
          status: PerformanceStatus.good,
        ),
        TeamMemberPerformance(
          name: 'Karim Ahmed',
          initials: 'KA',
          role: 'Salesman',
          isOnline: true,
          target: 400000,
          achieved: 288000,
          todaySale: 12400,
          achievedPercent: 72,
          status: PerformanceStatus.good,
        ),
        TeamMemberPerformance(
          name: 'Faisal Rahman',
          initials: 'FR',
          role: 'Salesman',
          isOnline: true,
          target: 350000,
          achieved: 192000,
          todaySale: 6200,
          achievedPercent: 55,
          status: PerformanceStatus.atRisk,
        ),
        TeamMemberPerformance(
          name: 'Nasir Uddin',
          initials: 'NU',
          role: 'Salesman',
          isOnline: false,
          target: 250000,
          achieved: 120000,
          todaySale: 0,
          achievedPercent: 48,
          status: PerformanceStatus.atRisk,
        ),
      ],
    );
  }

  Future<void> refresh() async {
    // TODO: wire to teamOverviewRepositoryProvider.getTeamOverview()
    state = state.copyWith(isLoading: true, errorMessage: null);
    state = state.copyWith(isLoading: false);
  }
}
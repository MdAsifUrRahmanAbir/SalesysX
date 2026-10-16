import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/session/auth_session_controller.dart';
import '../../../../core/utils/error_mapper.dart';
import '../../../../core/utils/working_days.dart';
import '../../data/repositories/team_overview_repository.dart';
import '../states/team_overview_state.dart';

final teamOverviewControllerProvider =
NotifierProvider.autoDispose<TeamOverviewController, TeamOverviewState>(
  TeamOverviewController.new,
);

class TeamOverviewController extends Notifier<TeamOverviewState> {
  TeamOverviewRepository get _repository => ref.read(teamOverviewRepositoryProvider);

  @override
  TeamOverviewState build() {
    Future.microtask(_load);
    return const TeamOverviewState(isLoading: true);
  }

  Future<void> refresh() => _load();

  Future<void> _load() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final user = ref.read(authSessionControllerProvider).user;
      if (user == null) {
        state = state.copyWith(isLoading: false, errorMessage: 'Not signed in.');
        return;
      }

      final team = await _repository.getTeamForHead(user.id);
      if (team == null) {
        state = state.copyWith(isLoading: false, errorMessage: 'No team assigned to this account.');
        return;
      }

      final members = await _repository.getTeamMembers(team.id);
      final sales = await _repository.getSalesForTeam(team.id);
      final targets = await _repository.getTargetsForTeam(team.id);

      final now = DateTime.now();
      final monthStart = DateTime(now.year, now.month, 1);
      final todayStart = DateTime(now.year, now.month, now.day);
      final monthKey = '${now.year}-${now.month.toString().padLeft(2, '0')}';

      final performances = members.map((member) {
        final memberTargets = targets.where((t) => t.salesmanEmail == member.id && t.month == monthKey);
        final targetAmount = memberTargets.isEmpty ? 0.0 : memberTargets.first.targetAmount;
        final workingDays = memberTargets.isEmpty ? 0 : memberTargets.first.workingDays;

        final memberSales = sales.where((s) => s.salesmanEmail == member.id);
        final achieved = memberSales
            .where((s) => !s.date.isBefore(monthStart))
            .fold<double>(0, (sum, s) => sum + s.amount);
        final todaySale = memberSales
            .where((s) => !s.date.isBefore(todayStart))
            .fold<double>(0, (sum, s) => sum + s.amount);

        final achievedPercent = targetAmount <= 0 ? 0.0 : (achieved / targetAmount) * 100;
        final elapsedWorkingDays =
            workingDays > 0 ? WorkingDays.count(monthStart, now).clamp(0, workingDays) : 0;
        final expectedPercent = workingDays > 0 ? (elapsedWorkingDays / workingDays) * 100 : 0.0;

        return TeamMemberPerformance(
          email: member.id,
          name: member.name,
          initials: _initialsOf(member.name),
          role: member.role,
          isOnline: true, // no presence tracking exists in the data model
          target: targetAmount,
          achieved: achieved,
          todaySale: todaySale,
          achievedPercent: achievedPercent.round(),
          status: achievedPercent >= expectedPercent ? PerformanceStatus.good : PerformanceStatus.atRisk,
        );
      }).toList()
        ..sort((a, b) => a.achievedPercent.compareTo(b.achievedPercent)); // most at-risk first

      state = TeamOverviewState(
        isLoading: false,
        teamName: team.name,
        totalTarget: performances.fold<double>(0, (sum, m) => sum + m.target),
        totalAchieved: performances.fold<double>(0, (sum, m) => sum + m.achieved),
        totalMembers: performances.length,
        onlineCount: performances.length,
        members: performances,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: getErrorMessage(e));
    }
  }

  String _initialsOf(String name) {
    final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1)).toUpperCase();
  }
}

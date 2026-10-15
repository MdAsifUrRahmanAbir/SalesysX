import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/session/auth_session_controller.dart';
import '../../../../core/utils/error_mapper.dart';
import '../../data/repositories/team_reports_repository.dart';
import '../states/team_reports_state.dart';

final teamReportsControllerProvider = NotifierProvider.autoDispose<
TeamReportsController, TeamReportsState>(
TeamReportsController.new,
);

class TeamReportsController extends Notifier<TeamReportsState> {
  TeamReportsRepository get _repository => ref.read(teamReportsRepositoryProvider);

  @override
  TeamReportsState build() {
    Future.microtask(_load);
    return const TeamReportsState(isLoading: true);
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
      final monthKey = '${now.year}-${now.month.toString().padLeft(2, '0')}';
      final monthSales = sales.where((s) => !s.date.isBefore(monthStart)).toList();

      final ranking = members.map((member) {
        final memberTargets = targets.where((t) => t.salesmanEmail == member.id && t.month == monthKey);
        final targetAmount = memberTargets.isEmpty ? 0.0 : memberTargets.first.targetAmount;
        final achieved = monthSales
            .where((s) => s.salesmanEmail == member.id)
            .fold<double>(0, (sum, s) => sum + s.amount);
        final achievedPercent = targetAmount <= 0 ? 0.0 : (achieved / targetAmount) * 100;
        return SalesmanRankRow(
          name: member.name,
          target: targetAmount,
          achieved: achieved,
          achievedPercent: achievedPercent.round(),
        );
      }).toList()
        ..sort((a, b) => b.achievedPercent.compareTo(a.achievedPercent));

      final totalsByCategory = <String, double>{};
      for (final sale in monthSales) {
        totalsByCategory.update(sale.category, (v) => v + sale.amount, ifAbsent: () => sale.amount);
      }
      final maxCategoryAmount = totalsByCategory.values.isEmpty
          ? 0.0
          : totalsByCategory.values.reduce((a, b) => a > b ? a : b);
      final categorySales = totalsByCategory.entries.map((e) {
        return CategorySalesRow(
          category: e.key,
          amount: e.value,
          shareOfMax: maxCategoryAmount <= 0 ? 0 : e.value / maxCategoryAmount,
        );
      }).toList()
        ..sort((a, b) => b.amount.compareTo(a.amount));

      state = TeamReportsState(
        isLoading: false,
        totalTarget: ranking.fold<double>(0, (sum, r) => sum + r.target),
        totalAchieved: ranking.fold<double>(0, (sum, r) => sum + r.achieved),
        ranking: ranking,
        categorySales: categorySales,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: getErrorMessage(e));
    }
  }
}

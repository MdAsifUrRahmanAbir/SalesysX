import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/session/auth_session_controller.dart';
import '../../../../core/utils/error_mapper.dart';
import '../../data/repositories/team_sales_list_repository.dart';
import '../states/team_sales_list_state.dart';

final teamSalesListControllerProvider = NotifierProvider.autoDispose<
TeamSalesListController, TeamSalesListState>(
TeamSalesListController.new,
);

class TeamSalesListController extends Notifier<TeamSalesListState> {
  TeamSalesListRepository get _repository => ref.read(teamSalesListRepositoryProvider);

  @override
  TeamSalesListState build() {
    Future.microtask(_load);
    return const TeamSalesListState(isLoading: true);
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
      final outlets = await _repository.getOutletsForTeam(team.id);
      final sales = await _repository.getSalesForTeam(team.id);

      final nameByEmail = {for (final m in members) m.id: m.name};
      final nameByOutletId = {for (final o in outlets) o.id: o.name};

      final rows = sales.map((s) => TeamSaleRow(
        salesmanName: nameByEmail[s.salesmanEmail] ?? s.salesmanEmail,
        outletName: nameByOutletId[s.outletId] ?? s.outletId,
        productName: s.productName,
        date: s.date,
        amount: s.amount,
      )).toList()
        ..sort((a, b) => b.date.compareTo(a.date));

      state = state.copyWith(isLoading: false, rows: rows);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: getErrorMessage(e));
    }
  }
}

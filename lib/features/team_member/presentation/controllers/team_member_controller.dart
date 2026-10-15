import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:salesysx/features/common_models/outlet_model.dart';
import 'package:salesysx/features/common_models/sale_model.dart';
import '../../../../core/constants/user_role.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/utils/error_mapper.dart';
import '../../../../core/utils/working_days.dart';
import '../../data/repositories/team_member_repository.dart';
import '../states/team_member_state.dart';

final teamMemberControllerProvider = NotifierProvider.autoDispose<
TeamMemberController, TeamMemberState>(
TeamMemberController.new,
);

class TeamMemberController extends Notifier<TeamMemberState> {
  TeamMemberRepository get _repository => ref.read(teamMemberRepositoryProvider);
  String? _loadedEmail;

  @override
  TeamMemberState build() {
    return const TeamMemberState();
  }

  /// Called once from the screen's `initState` with the email passed via
  /// the route's `?email=` query parameter.
  Future<void> load(String email) async {
    if (_loadedEmail == email) return; // avoid refetching on rebuilds
    _loadedEmail = email;

    state = state.copyWith(isInitialLoading: true, errorMessage: null);
    try {
      final member = await _repository.getMember(email);
      if (member == null) {
        state = state.copyWith(isInitialLoading: false, errorMessage: 'Team member not found.');
        return;
      }

      final now = DateTime.now();
      final monthKey = '${now.year}-${now.month.toString().padLeft(2, '0')}';
      final monthStart = DateTime(now.year, now.month, 1);
      final todayStart = DateTime(now.year, now.month, now.day);

      final target = await _repository.getCurrentMonthTarget(email, monthKey);
      final sales = await _repository.getSalesForSalesman(email);
      final outlets = await _repository.getAssignedOutlets(email);

      final monthSales = sales.where((s) => !s.date.isBefore(monthStart)).toList();
      final achievedAmount = monthSales.fold<double>(0, (sum, s) => sum + s.amount);
      final todaysSales =
          sales.where((s) => !s.date.isBefore(todayStart)).fold<double>(0, (sum, s) => sum + s.amount);

      final targetAmount = target?.targetAmount ?? 0;
      final workingDays = target?.workingDays ?? 0;
      final todaysTarget = workingDays > 0 ? targetAmount / workingDays : 0.0;

      final elapsedWorkingDays =
          workingDays > 0 ? WorkingDays.count(monthStart, now).clamp(0, workingDays) : 0;
      final expectedPercent = workingDays > 0 ? (elapsedWorkingDays / workingDays) * 100 : 0.0;
      final achievedPercent = targetAmount <= 0 ? 0.0 : (achievedAmount / targetAmount) * 100;

      final recentSales = sales.toList()
        ..sort((a, b) => b.date.compareTo(a.date));

      state = TeamMemberState(
        isInitialLoading: false,
        name: member.name,
        initials: _initialsOf(member.name),
        roleLabel: 'Role: ${member.role.label} • ${member.employeeId}',
        email: member.email,
        phone: member.phone,
        monthlyTarget: targetAmount,
        achievedAmount: achievedAmount,
        todaysTarget: todaysTarget,
        todaysSales: todaysSales,
        isOnTrack: achievedPercent >= expectedPercent,
        recentSales: recentSales.take(10).map((s) => _toActivity(s, outlets)).toList(),
      );
    } catch (e) {
      state = state.copyWith(isInitialLoading: false, errorMessage: getErrorMessage(e));
    }
  }

  Future<void> refresh() async {
    final email = _loadedEmail;
    if (email == null) return;
    _loadedEmail = null;
    await load(email);
  }

  RecentSaleActivity _toActivity(SaleModel sale, List<OutletModel> outlets) {
    final outlet = outlets.where((o) => o.id == sale.outletId).isEmpty
        ? null
        : outlets.firstWhere((o) => o.id == sale.outletId);
    final dayLabel = _dayLabel(sale.date);
    return RecentSaleActivity(
      outletName: outlet?.name ?? sale.outletId,
      detailLine: '${sale.productName} x ${sale.quantity} • $dayLabel, ${DateFormatter.time(sale.date)}',
      amountLabel: CurrencyFormatter.format(sale.amount),
    );
  }

  String _dayLabel(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final day = DateTime(date.year, date.month, date.day);
    if (day == today) return 'Today';
    if (day == today.subtract(const Duration(days: 1))) return 'Yesterday';
    return '${date.day}/${date.month}';
  }

  String _initialsOf(String name) {
    final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1)).toUpperCase();
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/session/auth_session_controller.dart';
import '../../../../core/utils/error_mapper.dart';
import '../../data/repositories/salesman_home_repository.dart';
import '../states/salesman_home_state.dart';

final salesmanHomeControllerProvider =
NotifierProvider.autoDispose<SalesmanHomeController, SalesmanHomeState>(SalesmanHomeController.new);

class SalesmanHomeController extends Notifier<SalesmanHomeState> {
  SalesmanHomeRepository get _repository => ref.read(salesmanHomeRepositoryProvider);

  @override
  SalesmanHomeState build() {
    Future.microtask(_load);
    return const SalesmanHomeState(isLoading: true);
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

      final now = DateTime.now();
      final monthKey = '${now.year}-${now.month.toString().padLeft(2, '0')}';
      final monthStart = DateTime(now.year, now.month, 1);
      final todayStart = DateTime(now.year, now.month, now.day);
      final yesterdayStart = todayStart.subtract(const Duration(days: 1));

      final target = await _repository.getCurrentMonthTarget(user.id, monthKey);
      final sales = await _repository.getSalesForSalesman(user.id);

      final monthSales = sales.where((s) => !s.date.isBefore(monthStart));
      final achievedAmount = monthSales.fold<double>(0, (sum, s) => sum + s.amount);

      final todaySales = sales.where((s) => !s.date.isBefore(todayStart));
      final todaysSalesTotal = todaySales.fold<double>(0, (sum, s) => sum + s.amount);

      final yesterdaySales =
      sales.where((s) => !s.date.isBefore(yesterdayStart) && s.date.isBefore(todayStart));
      final yesterdayTotal = yesterdaySales.fold<double>(0, (sum, s) => sum + s.amount);

      final todaysSalesChangePercent = yesterdayTotal <= 0
          ? (todaysSalesTotal > 0 ? 100.0 : 0.0)
          : ((todaysSalesTotal - yesterdayTotal) / yesterdayTotal) * 100;

      final daysLeftInMonth =
      target != null ? target.endDate.difference(now).inDays.clamp(0, target.workingDays) : 0;

      final targetRunRatePerDay =
      target != null && target.workingDays > 0 ? target.targetAmount / target.workingDays : 0.0;
      final currentAvgRunRatePerDay = now.day > 0 ? achievedAmount / now.day : 0.0;

      state = SalesmanHomeState(
        isLoading: false,
        salesmanName: user.name,
        avatarInitials: _initialsOf(user.name),
        monthlyTarget: target?.targetAmount ?? 0,
        achievedAmount: achievedAmount,
        todaysSales: todaysSalesTotal,
        todaysSalesChangePercent: todaysSalesChangePercent,
        daysLeftInMonth: daysLeftInMonth,
        targetRunRatePerDay: targetRunRatePerDay,
        currentAvgRunRatePerDay: currentAvgRunRatePerDay,
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
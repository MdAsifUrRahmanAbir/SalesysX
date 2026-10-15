import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:salesysx/features/common_models/sale_model.dart';
import '../../../../core/session/auth_session_controller.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/error_mapper.dart';
import '../../../../core/utils/working_days.dart';
import '../../data/repositories/target_performance_repository.dart';
import '../states/target_performance_state.dart';

final targetPerformanceControllerProvider = NotifierProvider.autoDispose<
    TargetPerformanceController, TargetPerformanceState>(
  TargetPerformanceController.new,
);

class TargetPerformanceController extends Notifier<TargetPerformanceState> {
  TargetPerformanceRepository get _repository => ref.read(targetPerformanceRepositoryProvider);

  static const _weekdayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  @override
  TargetPerformanceState build() {
    Future.microtask(_load);
    return const TargetPerformanceState(isLoading: true);
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
      final daysInMonth = DateTime(now.year, now.month + 1, 0).day;

      final target = await _repository.getCurrentMonthTarget(user.id, monthKey);
      final sales = await _repository.getSalesForSalesman(user.id);
      final monthSales = sales.where((s) => !s.date.isBefore(monthStart)).toList();
      final achievedAmount = monthSales.fold<double>(0, (sum, s) => sum + s.amount);

      final targetAmount = target?.targetAmount ?? 0;
      final achievedPercent = targetAmount <= 0 ? 0.0 : (achievedAmount / targetAmount) * 100;

      final elapsedWorkingDays = target == null
          ? 0
          : WorkingDays.count(monthStart, now).clamp(0, target.workingDays);
      final workingDaysLeft = target == null ? 0 : (target.workingDays - elapsedWorkingDays).clamp(0, target.workingDays);

      final periodProgressPercent = (now.day / daysInMonth) * 100;
      final expectedAchievementPercent =
          target != null && target.workingDays > 0 ? (elapsedWorkingDays / target.workingDays) * 100 : 0.0;

      final remaining = (targetAmount - achievedAmount).clamp(0, targetAmount);
      final requiredDailySales = workingDaysLeft > 0 ? remaining / workingDaysLeft : 0.0;

      final isOnTrack = achievedPercent >= expectedAchievementPercent;

      state = TargetPerformanceState(
        isLoading: false,
        riskStatus: isOnTrack ? TargetRiskStatus.onTrack : TargetRiskStatus.atRisk,
        monthlyTarget: targetAmount,
        achievedAmount: achievedAmount,
        periodProgressPercent: periodProgressPercent.clamp(0, 100),
        expectedAchievementPercent: expectedAchievementPercent.clamp(0, 100),
        requiredDailySales: requiredDailySales,
        workingDaysLeft: workingDaysLeft,
        dailyTargetLabel: _shortLabel(
          target != null && target.workingDays > 0 ? targetAmount / target.workingDays : 0,
        ),
        dailyTrend: _buildDailyTrend(sales, now),
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: getErrorMessage(e));
    }
  }

  List<DailyTrendPoint> _buildDailyTrend(List<SaleModel> sales, DateTime now) {
    final points = <DailyTrendPoint>[];
    final weekStart = now.subtract(const Duration(days: 6));
    for (var i = 0; i < 7; i++) {
      final day = DateTime(weekStart.year, weekStart.month, weekStart.day + i);
      final nextDay = day.add(const Duration(days: 1));
      final dayTotal = sales
          .where((s) => !s.date.isBefore(day) && s.date.isBefore(nextDay))
          .fold<double>(0, (sum, s) => sum + s.amount);
      points.add(DailyTrendPoint(
        dayLabel: _weekdayLabels[day.weekday - 1],
        amountLabel: _shortLabel(dayTotal),
        amount: dayTotal,
        isHighlighted: day.year == now.year && day.month == now.month && day.day == now.day,
      ));
    }
    return points;
  }

  String _shortLabel(double amount) {
    if (amount >= 100000) return '৳${(amount / 100000).toStringAsFixed(1)}L';
    if (amount >= 1000) return '৳${(amount / 1000).toStringAsFixed(0)}k';
    return CurrencyFormatter.format(amount);
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../states/target_performance_state.dart';

final targetPerformanceControllerProvider = NotifierProvider.autoDispose<
TargetPerformanceController, TargetPerformanceState>(
TargetPerformanceController.new,
);

class TargetPerformanceController extends Notifier<TargetPerformanceState> {
  @override
  TargetPerformanceState build() {
    // TODO: wire to targetPerformanceRepositoryProvider.getPerformance()
    // once features/target_performance/data is ready.
    // Values below mirror the approved design as placeholders.
    return const TargetPerformanceState(
      riskStatus: TargetRiskStatus.atRisk,
      monthlyTarget: 500000,
      achievedAmount: 340000,
      periodProgressPercent: 60,
      expectedAchievementPercent: 65,
      requiredDailySales: 12000,
      workingDaysLeft: 10,
      dailyTargetLabel: '৳12k',
      dailyTrend: [
        DailyTrendPoint(
          dayLabel: 'M',
          amountLabel: '৳10k',
          amount: 10000,
          isHighlighted: false,
        ),
        DailyTrendPoint(
          dayLabel: 'T',
          amountLabel: '৳14k',
          amount: 14000,
          isHighlighted: true,
        ),
        DailyTrendPoint(
          dayLabel: 'W',
          amountLabel: '৳12k',
          amount: 12000,
          isHighlighted: false,
        ),
        DailyTrendPoint(
          dayLabel: 'T',
          amountLabel: '৳9k',
          amount: 9000,
          isHighlighted: false,
        ),
        DailyTrendPoint(
          dayLabel: 'F',
          amountLabel: '৳15k',
          amount: 15000,
          isHighlighted: true,
        ),
        DailyTrendPoint(
          dayLabel: 'S',
          amountLabel: '৳8k',
          amount: 8000,
          isHighlighted: false,
        ),
        DailyTrendPoint(
          dayLabel: 'S',
          amountLabel: '৳11k',
          amount: 11000,
          isHighlighted: false,
        ),
      ],
    );
  }

  Future<void> refresh() async {
    // TODO: wire to targetPerformanceRepositoryProvider.getPerformance()
    state = state.copyWith(isLoading: true, errorMessage: null);
    state = state.copyWith(isLoading: false);
  }
}
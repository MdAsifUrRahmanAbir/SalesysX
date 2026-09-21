import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_strings.dart';
import '../controllers/target_performance_controller.dart';
import '../widgets/benchmark_comparisons_card.dart';
import '../widgets/daily_trend_bar_chart.dart';
import '../widgets/target_performance_header.dart';
import '../widgets/target_progress_ring_card.dart';

class TargetPerformanceTabView extends ConsumerWidget {
  const TargetPerformanceTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(targetPerformanceControllerProvider);

    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Column(
          children: [
            TargetPerformanceHeader(riskStatus: state.riskStatus),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: ListView(
                    padding: EdgeInsets.all(AppSizes.md),
                    children: [
                      TargetProgressRingCard(
                        target: state.monthlyTarget,
                        achieved: state.achievedAmount,
                        remaining: state.remainingAmount,
                        achievedPercent: state.achievedPercent,
                      ),
                      SizedBox(height: AppSizes.lg),
                      BenchmarkComparisonsCard(
                        periodProgressPercent: state.periodProgressPercent,
                        expectedAchievementPercent:
                        state.expectedAchievementPercent,
                        requiredDailySales: state.requiredDailySales,
                        workingDaysLeft: state.workingDaysLeft,
                      ),
                      SizedBox(height: AppSizes.lg),
                      DailyTrendBarChart(
                        title: AppStrings.dailyTrendThisWeek,
                        dailyTargetLabel: state.dailyTargetLabel,
                        points: state.dailyTrend,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
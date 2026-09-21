import 'package:flutter/foundation.dart';

enum TargetRiskStatus { onTrack, atRisk }

@immutable
class DailyTrendPoint {
  final String dayLabel; // 'M', 'T', 'W', ...
  final String amountLabel; // '৳10k' — pre-formatted short label
  final double amount;
  final bool isHighlighted;

  const DailyTrendPoint({
    required this.dayLabel,
    required this.amountLabel,
    required this.amount,
    required this.isHighlighted,
  });
}

@immutable
class TargetPerformanceState {
  final bool isLoading;
  final String? errorMessage;

  final TargetRiskStatus riskStatus;

  final double monthlyTarget;
  final double achievedAmount;

  final double periodProgressPercent;
  final double expectedAchievementPercent;
  final double requiredDailySales;
  final int workingDaysLeft;

  final String dailyTargetLabel; // '৳12k'
  final List<DailyTrendPoint> dailyTrend;

  const TargetPerformanceState({
    this.isLoading = false,
    this.errorMessage,
    this.riskStatus = TargetRiskStatus.onTrack,
    this.monthlyTarget = 0,
    this.achievedAmount = 0,
    this.periodProgressPercent = 0,
    this.expectedAchievementPercent = 0,
    this.requiredDailySales = 0,
    this.workingDaysLeft = 0,
    this.dailyTargetLabel = '',
    this.dailyTrend = const [],
  });

  double get remainingAmount =>
      (monthlyTarget - achievedAmount).clamp(0, monthlyTarget);

  double get achievedPercent =>
      monthlyTarget <= 0 ? 0 : (achievedAmount / monthlyTarget).clamp(0, 1);

  TargetPerformanceState copyWith({
    bool? isLoading,
    String? errorMessage,
    TargetRiskStatus? riskStatus,
    double? monthlyTarget,
    double? achievedAmount,
    double? periodProgressPercent,
    double? expectedAchievementPercent,
    double? requiredDailySales,
    int? workingDaysLeft,
    String? dailyTargetLabel,
    List<DailyTrendPoint>? dailyTrend,
  }) {
    return TargetPerformanceState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      riskStatus: riskStatus ?? this.riskStatus,
      monthlyTarget: monthlyTarget ?? this.monthlyTarget,
      achievedAmount: achievedAmount ?? this.achievedAmount,
      periodProgressPercent:
      periodProgressPercent ?? this.periodProgressPercent,
      expectedAchievementPercent:
      expectedAchievementPercent ?? this.expectedAchievementPercent,
      requiredDailySales: requiredDailySales ?? this.requiredDailySales,
      workingDaysLeft: workingDaysLeft ?? this.workingDaysLeft,
      dailyTargetLabel: dailyTargetLabel ?? this.dailyTargetLabel,
      dailyTrend: dailyTrend ?? this.dailyTrend,
    );
  }
}
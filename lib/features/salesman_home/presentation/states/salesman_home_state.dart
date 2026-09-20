import 'package:flutter/foundation.dart';

@immutable
class SalesmanHomeState {
  final bool isLoading;
  final String? errorMessage;

  final String salesmanName;
  final String avatarInitials;

  final double monthlyTarget;
  final double achievedAmount;

  final double todaysSales;
  final double todaysSalesChangePercent;

  final int daysLeftInMonth;
  final double targetRunRatePerDay;
  final double currentAvgRunRatePerDay;

  const SalesmanHomeState({
    this.isLoading = false,
    this.errorMessage,
    this.salesmanName = '',
    this.avatarInitials = '',
    this.monthlyTarget = 0,
    this.achievedAmount = 0,
    this.todaysSales = 0,
    this.todaysSalesChangePercent = 0,
    this.daysLeftInMonth = 0,
    this.targetRunRatePerDay = 0,
    this.currentAvgRunRatePerDay = 0,
  });

  double get remainingAmount =>
      (monthlyTarget - achievedAmount).clamp(0, monthlyTarget);

  double get achievedPercent =>
      monthlyTarget <= 0 ? 0 : (achievedAmount / monthlyTarget).clamp(0, 1);

  bool get isOnTrack => currentAvgRunRatePerDay >= targetRunRatePerDay;

  SalesmanHomeState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? salesmanName,
    String? avatarInitials,
    double? monthlyTarget,
    double? achievedAmount,
    double? todaysSales,
    double? todaysSalesChangePercent,
    int? daysLeftInMonth,
    double? targetRunRatePerDay,
    double? currentAvgRunRatePerDay,
  }) {
    return SalesmanHomeState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      salesmanName: salesmanName ?? this.salesmanName,
      avatarInitials: avatarInitials ?? this.avatarInitials,
      monthlyTarget: monthlyTarget ?? this.monthlyTarget,
      achievedAmount: achievedAmount ?? this.achievedAmount,
      todaysSales: todaysSales ?? this.todaysSales,
      todaysSalesChangePercent:
      todaysSalesChangePercent ?? this.todaysSalesChangePercent,
      daysLeftInMonth: daysLeftInMonth ?? this.daysLeftInMonth,
      targetRunRatePerDay: targetRunRatePerDay ?? this.targetRunRatePerDay,
      currentAvgRunRatePerDay:
      currentAvgRunRatePerDay ?? this.currentAvgRunRatePerDay,
    );
  }
}
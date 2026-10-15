import 'package:flutter/foundation.dart';

@immutable
class SalesmanRankRow {
  final String name;
  final double target;
  final double achieved;
  final int achievedPercent;

  const SalesmanRankRow({
    required this.name,
    required this.target,
    required this.achieved,
    required this.achievedPercent,
  });
}

@immutable
class CategorySalesRow {
  final String category;
  final double amount;
  final double shareOfMax; // 0..1, relative to the top category

  const CategorySalesRow({
    required this.category,
    required this.amount,
    required this.shareOfMax,
  });
}

@immutable
class TeamReportsState {
  final bool isLoading;
  final String? errorMessage;

  final double totalTarget;
  final double totalAchieved;

  final List<SalesmanRankRow> ranking;
  final List<CategorySalesRow> categorySales;

  const TeamReportsState({
    this.isLoading = false,
    this.errorMessage,
    this.totalTarget = 0,
    this.totalAchieved = 0,
    this.ranking = const [],
    this.categorySales = const [],
  });

  double get achievedPercent => totalTarget <= 0 ? 0 : (totalAchieved / totalTarget * 100).clamp(0, 100);

  TeamReportsState copyWith({
    bool? isLoading,
    String? errorMessage,
    double? totalTarget,
    double? totalAchieved,
    List<SalesmanRankRow>? ranking,
    List<CategorySalesRow>? categorySales,
  }) {
    return TeamReportsState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      totalTarget: totalTarget ?? this.totalTarget,
      totalAchieved: totalAchieved ?? this.totalAchieved,
      ranking: ranking ?? this.ranking,
      categorySales: categorySales ?? this.categorySales,
    );
  }
}

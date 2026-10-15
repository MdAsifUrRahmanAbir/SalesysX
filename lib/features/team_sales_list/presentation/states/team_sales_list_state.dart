import 'package:flutter/foundation.dart';

@immutable
class TeamSaleRow {
  final String salesmanName;
  final String outletName;
  final String productName;
  final DateTime date;
  final double amount;

  const TeamSaleRow({
    required this.salesmanName,
    required this.outletName,
    required this.productName,
    required this.date,
    required this.amount,
  });
}

@immutable
class TeamSalesListState {
  final bool isLoading;
  final String? errorMessage;
  final List<TeamSaleRow> rows;

  const TeamSalesListState({
    this.isLoading = false,
    this.errorMessage,
    this.rows = const [],
  });

  TeamSalesListState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<TeamSaleRow>? rows,
  }) {
    return TeamSalesListState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      rows: rows ?? this.rows,
    );
  }
}

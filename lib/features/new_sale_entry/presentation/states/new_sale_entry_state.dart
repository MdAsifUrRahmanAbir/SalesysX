import 'package:flutter/foundation.dart';

@immutable
class TodaysSaleEntry {
  final String outletName;
  final String location;
  final int itemCount;
  final String time;
  final double amount;

  const TodaysSaleEntry({
    required this.outletName,
    required this.location,
    required this.itemCount,
    required this.time,
    required this.amount,
  });
}

@immutable
class NewSaleEntryState {
  final bool isSubmitting;
  final String? errorMessage;

  final String outletName;
  final List<String> categories;
  final String selectedCategory;

  final String? productName;
  final double unitPrice;

  final int quantity;
  final double discount;

  final List<TodaysSaleEntry> todaysEntries;

  const NewSaleEntryState({
    this.isSubmitting = false,
    this.errorMessage,
    this.outletName = '',
    this.categories = const [],
    this.selectedCategory = '',
    this.productName,
    this.unitPrice = 0,
    this.quantity = 1,
    this.discount = 0,
    this.todaysEntries = const [],
  });

  double get calculatedPrice =>
      ((quantity * unitPrice) - discount).clamp(0, double.infinity);

  NewSaleEntryState copyWith({
    bool? isSubmitting,
    String? errorMessage,
    String? outletName,
    List<String>? categories,
    String? selectedCategory,
    String? productName,
    double? unitPrice,
    int? quantity,
    double? discount,
    List<TodaysSaleEntry>? todaysEntries,
  }) {
    return NewSaleEntryState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
      outletName: outletName ?? this.outletName,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      productName: productName ?? this.productName,
      unitPrice: unitPrice ?? this.unitPrice,
      quantity: quantity ?? this.quantity,
      discount: discount ?? this.discount,
      todaysEntries: todaysEntries ?? this.todaysEntries,
    );
  }
}
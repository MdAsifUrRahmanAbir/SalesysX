import 'package:flutter/foundation.dart';

import 'package:salesysx/features/common_models/outlet_model.dart';
import '../../data/models/product_model.dart';

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
  final bool isLoading;
  final bool isSubmitting;
  final String? errorMessage;

  final List<OutletModel> outlets;
  final String? selectedOutletId;

  final List<ProductModel> products;
  final String selectedCategory;
  final String? selectedProductId;

  final int quantity;
  final double discount;

  final List<TodaysSaleEntry> todaysEntries;

  /// Company setting: the salesman may change the unit price.
  final bool allowPriceEdit;

  /// The edited unit price; null means the product's list price.
  final double? priceOverride;

  const NewSaleEntryState({
    this.isLoading = false,
    this.isSubmitting = false,
    this.errorMessage,
    this.outlets = const [],
    this.selectedOutletId,
    this.products = const [],
    this.selectedCategory = 'All',
    this.selectedProductId,
    this.quantity = 1,
    this.discount = 0,
    this.todaysEntries = const [],
    this.allowPriceEdit = false,
    this.priceOverride,
  });

  OutletModel? get selectedOutlet {
    for (final outlet in outlets) {
      if (outlet.id == selectedOutletId) return outlet;
    }
    return null;
  }

  ProductModel? get selectedProduct {
    for (final product in products) {
      if (product.id == selectedProductId) return product;
    }
    return null;
  }

  String get outletName => selectedOutlet?.name ?? '';
  String? get productName => selectedProduct?.name;
  double get unitPrice => (allowPriceEdit ? priceOverride : null) ?? selectedProduct?.unitPrice ?? 0;

  List<String> get categories => ['All', ...{for (final p in products) p.category}];

  List<ProductModel> get filteredProducts => selectedCategory == 'All'
      ? products
      : products.where((p) => p.category == selectedCategory).toList();

  double get calculatedPrice => ((quantity * unitPrice) - discount).clamp(0, double.infinity);

  NewSaleEntryState copyWith({
    bool? isLoading,
    bool? isSubmitting,
    String? errorMessage,
    List<OutletModel>? outlets,
    String? selectedOutletId,
    List<ProductModel>? products,
    String? selectedCategory,
    String? selectedProductId,
    int? quantity,
    double? discount,
    List<TodaysSaleEntry>? todaysEntries,
    bool? allowPriceEdit,
    double? priceOverride,
    bool clearPriceOverride = false,
  }) {
    return NewSaleEntryState(
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
      outlets: outlets ?? this.outlets,
      selectedOutletId: selectedOutletId ?? this.selectedOutletId,
      products: products ?? this.products,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedProductId: selectedProductId ?? this.selectedProductId,
      quantity: quantity ?? this.quantity,
      discount: discount ?? this.discount,
      todaysEntries: todaysEntries ?? this.todaysEntries,
      allowPriceEdit: allowPriceEdit ?? this.allowPriceEdit,
      priceOverride: clearPriceOverride ? null : (priceOverride ?? this.priceOverride),
    );
  }
}

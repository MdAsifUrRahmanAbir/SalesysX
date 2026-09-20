import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../states/new_sale_entry_state.dart';

final newSaleEntryControllerProvider =
NotifierProvider.autoDispose<NewSaleEntryController, NewSaleEntryState>(
  NewSaleEntryController.new,
);

class NewSaleEntryController extends Notifier<NewSaleEntryState> {
  late final TextEditingController discountController;

  @override
  NewSaleEntryState build() {
    discountController = TextEditingController(text: '50');
    ref.onDispose(discountController.dispose);

    // TODO: wire to newSaleEntryRepositoryProvider.getFormOptions()
    // and .getTodaysEntries() once features/new_sale_entry/data is ready.
    // Values below mirror the approved design as placeholders.
    return const NewSaleEntryState(
      outletName: 'Anowar Kirana Store, Mirpur',
      categories: ['All', 'Beverage', 'Snacks', 'Grocery', 'Hygiene'],
      selectedCategory: 'Beverage',
      productName: 'Pran Frooto Mango Juice 250ml',
      unitPrice: 35,
      quantity: 12,
      discount: 50,
      todaysEntries: [
        TodaysSaleEntry(
          outletName: 'Mayer Doa Enterprise',
          location: 'Uttara',
          itemCount: 8,
          time: '10:15 AM',
          amount: 4200,
        ),
        TodaysSaleEntry(
          outletName: 'Dhaka Mart',
          location: 'Banani',
          itemCount: 5,
          time: '11:30 AM',
          amount: 2800,
        ),
        TodaysSaleEntry(
          outletName: 'Popular General Store',
          location: 'Dhanmondi',
          itemCount: 3,
          time: '12:45 PM',
          amount: 1500,
        ),
      ],
    );
  }

  void selectCategory(String category) {
    state = state.copyWith(selectedCategory: category);
    // TODO: wire to newSaleEntryRepositoryProvider.getProducts(category)
  }

  void incrementQuantity() {
    state = state.copyWith(quantity: state.quantity + 1);
  }

  void decrementQuantity() {
    if (state.quantity <= 1) return;
    state = state.copyWith(quantity: state.quantity - 1);
  }

  void setDiscount(double discount) {
    state = state.copyWith(discount: discount < 0 ? 0 : discount);
  }

  Future<bool> submitSaleEntry() async {
    // TODO: wire to newSaleEntryRepositoryProvider.submitSaleEntry(...)
    state = state.copyWith(isSubmitting: true, errorMessage: null);
    state = state.copyWith(isSubmitting: false);
    return true;
  }
}
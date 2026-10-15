import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:salesysx/features/common_models/outlet_model.dart';
import 'package:salesysx/features/common_models/sale_model.dart';
import 'package:salesysx/features/salesman_home/presentation/controllers/salesman_home_controller.dart';
import 'package:salesysx/features/target_performance/presentation/controllers/target_performance_controller.dart';
import 'package:salesysx/features/team_overview/presentation/controllers/team_overview_controller.dart';
import 'package:salesysx/features/team_reports/presentation/controllers/team_reports_controller.dart';
import 'package:salesysx/features/team_sales_list/presentation/controllers/team_sales_list_controller.dart';
import '../../../../core/session/auth_session_controller.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/utils/error_mapper.dart';
import '../../data/repositories/new_sale_entry_repository.dart';
import '../states/new_sale_entry_state.dart';

final newSaleEntryControllerProvider =
NotifierProvider.autoDispose<NewSaleEntryController, NewSaleEntryState>(
  NewSaleEntryController.new,
);

class NewSaleEntryController extends Notifier<NewSaleEntryState> {
  late final TextEditingController discountController;

  NewSaleEntryRepository get _repository => ref.read(newSaleEntryRepositoryProvider);

  @override
  NewSaleEntryState build() {
    discountController = TextEditingController(text: '0');
    ref.onDispose(discountController.dispose);

    Future.microtask(_load);
    return const NewSaleEntryState(isLoading: true);
  }

  Future<void> refresh() => _load();

  /// Called once from the screen's `initState` when launched from the
  /// Outlets tab's "Record sale" shortcut with an outlet already chosen.
  void preselectOutlet(String outletId) {
    state = state.copyWith(selectedOutletId: outletId);
  }

  /// Folds a freshly created outlet (the "Add New Outlet" picker
  /// shortcut) into the form and selects it, without a full reload.
  void addNewOutlet(OutletModel outlet) {
    state = state.copyWith(
      outlets: [...state.outlets, outlet],
      selectedOutletId: outlet.id,
    );
  }

  Future<void> _load() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final user = ref.read(authSessionControllerProvider).user;
      if (user == null) {
        state = state.copyWith(isLoading: false, errorMessage: 'Not signed in.');
        return;
      }

      final outlets = await _repository.getAssignedOutlets(user.id);
      final products = await _repository.getActiveProducts();
      final sales = await _repository.getSalesForSalesman(user.id);

      final now = DateTime.now();
      final todayStart = DateTime(now.year, now.month, now.day);
      final todaysSales = sales.where((s) => !s.date.isBefore(todayStart)).toList()
        ..sort((a, b) => b.date.compareTo(a.date));

      state = state.copyWith(
        isLoading: false,
        outlets: outlets,
        products: products,
        todaysEntries: todaysSales.map((s) => _toTodaysEntry(s, outlets)).toList(),
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: getErrorMessage(e));
    }
  }

  TodaysSaleEntry _toTodaysEntry(SaleModel sale, List<OutletModel> outlets) {
    final outlet = outlets.where((o) => o.id == sale.outletId).isEmpty
        ? null
        : outlets.firstWhere((o) => o.id == sale.outletId);
    return TodaysSaleEntry(
      outletName: outlet?.name ?? sale.outletId,
      location: outlet?.areaRoute ?? '',
      itemCount: sale.quantity,
      time: DateFormatter.time(sale.date),
      amount: sale.amount,
    );
  }

  void selectOutlet(String outletId) {
    state = state.copyWith(selectedOutletId: outletId);
  }

  void selectProduct(String productId) {
    state = state.copyWith(selectedProductId: productId);
  }

  void selectCategory(String category) {
    state = state.copyWith(selectedCategory: category);
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
    if (state.isSubmitting) return false; // re-entrancy guard against double-tap

    final user = ref.read(authSessionControllerProvider).user;
    final outlet = state.selectedOutlet;
    final product = state.selectedProduct;

    if (user == null) {
      state = state.copyWith(errorMessage: 'Not signed in.');
      return false;
    }
    if (outlet == null) {
      state = state.copyWith(errorMessage: 'Please select an outlet.');
      return false;
    }
    if (product == null) {
      state = state.copyWith(errorMessage: 'Please select a product.');
      return false;
    }
    final subtotal = state.quantity * product.unitPrice;
    if (state.discount > subtotal) {
      state = state.copyWith(errorMessage: 'Discount cannot exceed the line subtotal.');
      return false;
    }

    state = state.copyWith(isSubmitting: true, errorMessage: null);
    try {
      await _repository.submitSale(
        salesmanEmail: user.id,
        teamId: user.teamId ?? '',
        outlet: outlet,
        product: product,
        quantity: state.quantity,
        discount: state.discount,
      );

      discountController.text = '0';
      // Reset quantity/discount/product but keep the outlet selected —
      // a salesman visiting one outlet commonly logs several products
      // in a row.
      state = NewSaleEntryState(
        isLoading: state.isLoading,
        isSubmitting: false,
        outlets: state.outlets,
        selectedOutletId: state.selectedOutletId,
        products: state.products,
        selectedCategory: state.selectedCategory,
        selectedProductId: null,
        quantity: 1,
        discount: 0,
        todaysEntries: state.todaysEntries,
      );

      // Invalidate every dashboard that could be showing this salesman's
      // numbers — harmless no-op for whichever ones aren't currently
      // mounted (role-gated tabs the signed-in user doesn't have).
      ref.invalidate(salesmanHomeControllerProvider);
      ref.invalidate(targetPerformanceControllerProvider);
      ref.invalidate(teamOverviewControllerProvider);
      ref.invalidate(teamSalesListControllerProvider);
      ref.invalidate(teamReportsControllerProvider);
      await _load();
      return true;
    } catch (e) {
      state = state.copyWith(isSubmitting: false, errorMessage: getErrorMessage(e));
      return false;
    }
  }
}

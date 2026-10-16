import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:salesysx/features/common_models/outlet_model.dart';
import '../../../../core/locale/l10n_provider.dart';
import '../../../../core/session/auth_session_controller.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/utils/error_mapper.dart';
import '../../data/repositories/outlets_customers_repository.dart';
import '../states/outlets_customers_state.dart';

final outletsCustomersControllerProvider = NotifierProvider.autoDispose<
OutletsCustomersController, OutletsCustomersState>(
OutletsCustomersController.new,
);

class OutletsCustomersController extends Notifier<OutletsCustomersState> {
  late final TextEditingController searchController;

  OutletsCustomersRepository get _repository => ref.read(outletsCustomersRepositoryProvider);

  @override
  OutletsCustomersState build() {
    searchController = TextEditingController();
    ref.onDispose(searchController.dispose);

    Future.microtask(_load);
    return const OutletsCustomersState(isLoading: true);
  }

  Future<void> refresh() => _load();

  Future<void> _load() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final user = ref.read(authSessionControllerProvider).user;
      if (user == null) {
        state = state.copyWith(isLoading: false, errorMessage: 'Not signed in.');
        return;
      }

      final outlets = await _repository.getAssignedOutlets(user.id);
      state = state.copyWith(
        isLoading: false,
        outlets: outlets.map(_toUiModel).toList(),
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: getErrorMessage(e));
    }
  }

  OutletCustomer _toUiModel(OutletModel outlet) {
    return OutletCustomer(
      id: outlet.id,
      name: outlet.name,
      status: switch (outlet.status) {
        'newCustomer' => OutletCustomerStatus.newCustomer,
        'potential' => OutletCustomerStatus.potential,
        _ => OutletCustomerStatus.active,
      },
      owner: outlet.ownerName,
      phone: outlet.phone,
      address: outlet.address,
      areaRoute: outlet.areaRoute,
      lastVisit: outlet.lastVisit == null ? ref.read(l10nProvider).notVisitedYet : DateFormatter.shortDate(outlet.lastVisit!),
      lastOrderAmount: outlet.lastOrderAmount,
    );
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void selectFilter(String filter) {
    state = state.copyWith(selectedFilter: filter);
  }
}

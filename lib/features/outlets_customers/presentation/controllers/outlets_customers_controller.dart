import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/outlets_customers_repository.dart';
import '../states/outlets_customers_state.dart';

final outletsCustomersControllerProvider = NotifierProvider.autoDispose<
OutletsCustomersController, OutletsCustomersState>(
OutletsCustomersController.new,
);

class OutletsCustomersController extends Notifier<OutletsCustomersState> {
  late final TextEditingController searchController;

  // OutletsCustomersRepository get _repository => ref.read(outletsCustomersRepositoryProvider);

  @override
  OutletsCustomersState build() {
    searchController = TextEditingController();
    ref.onDispose(searchController.dispose);

    // TODO: wire to outletsCustomersRepositoryProvider.getOutlets()
    // once features/outlets_customers/data is ready.
    // Values below mirror the approved design as placeholders.
    return const OutletsCustomersState(
      outlets: [
        OutletCustomer(
          name: 'Rahim Store',
          status: OutletCustomerStatus.active,
          owner: 'Rahim Uddin',
          areaRoute: 'Gulshan',
          lastVisit: '18 Jan 2024',
          lastOrderAmount: 12500,
        ),
        OutletCustomer(
          name: 'Karim Traders',
          status: OutletCustomerStatus.active,
          owner: 'Abdul Karim',
          areaRoute: 'Mirpur',
          lastVisit: '20 Jan 2024',
          lastOrderAmount: 8200,
        ),
        OutletCustomer(
          name: 'Nusrat Mart',
          status: OutletCustomerStatus.newCustomer,
          owner: 'Nusrat Jahan',
          areaRoute: 'Dhanmondi',
          lastVisit: '22 Jan 2024',
          lastOrderAmount: 15400,
        ),
        OutletCustomer(
          name: 'Anwar General Store',
          status: OutletCustomerStatus.potential,
          owner: 'Anwar Hossain',
          areaRoute: 'Uttara',
          lastVisit: '24 Jan 2024',
          lastOrderAmount: 5600,
        ),
      ],
    );
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void selectFilter(String filter) {
    state = state.copyWith(selectedFilter: filter);
    // TODO: wire to outletsCustomersRepositoryProvider.getOutlets(filter)
    // if filtering should happen server-side instead of client-side.
  }
}


import 'package:flutter/foundation.dart';

enum OutletCustomerStatus { active, newCustomer, potential }

@immutable
class OutletCustomer {
  final String name;
  final OutletCustomerStatus status;
  final String owner;
  final String areaRoute;
  final String lastVisit;
  final double lastOrderAmount;

  const OutletCustomer({
    required this.name,
    required this.status,
    required this.owner,
    required this.areaRoute,
    required this.lastVisit,
    required this.lastOrderAmount,
  });
}

@immutable
class OutletsCustomersState {
  final bool isLoading;
  final String? errorMessage;
  final String searchQuery;
  final String selectedFilter; // 'All' | 'Active' | 'New' | 'Potential'
  final List<OutletCustomer> outlets;

  const OutletsCustomersState({
    this.isLoading = false,
    this.errorMessage,
    this.searchQuery = '',
    this.selectedFilter = 'All',
    this.outlets = const [],
  });

  List<OutletCustomer> get filteredOutlets {
    final query = searchQuery.trim().toLowerCase();

    return outlets.where((outlet) {
      final matchesFilter = switch (selectedFilter) {
        'Active' => outlet.status == OutletCustomerStatus.active,
        'New' => outlet.status == OutletCustomerStatus.newCustomer,
        'Potential' => outlet.status == OutletCustomerStatus.potential,
        _ => true,
      };

      if (!matchesFilter) return false;
      if (query.isEmpty) return true;

      return outlet.name.toLowerCase().contains(query) ||
          outlet.owner.toLowerCase().contains(query);
    }).toList();
  }

  OutletsCustomersState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? searchQuery,
    String? selectedFilter,
    List<OutletCustomer>? outlets,
  }) {
    return OutletsCustomersState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      outlets: outlets ?? this.outlets,
    );
  }
}
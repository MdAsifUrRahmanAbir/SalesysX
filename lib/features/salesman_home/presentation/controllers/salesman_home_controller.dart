import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../states/salesman_home_state.dart';

final salesmanHomeControllerProvider =
NotifierProvider.autoDispose<SalesmanHomeController, SalesmanHomeState>(
  SalesmanHomeController.new,
);

class SalesmanHomeController extends Notifier<SalesmanHomeState> {
  @override
  SalesmanHomeState build() {
    // TODO: wire to salesmanHomeRepositoryProvider.getDashboard()
    // once features/salesman_home/data/repositories is ready.
    // Values below mirror the approved design as placeholders.
    return const SalesmanHomeState(
      salesmanName: 'Rahim Uddin',
      avatarInitials: 'RU',
      monthlyTarget: 500000,
      achievedAmount: 340000,
      todaysSales: 8500,
      todaysSalesChangePercent: 12,
      daysLeftInMonth: 12,
      targetRunRatePerDay: 13333,
      currentAvgRunRatePerDay: 14166,
    );
  }

  Future<void> refresh() async {
    // TODO: wire to salesmanHomeRepositoryProvider.getDashboard()
    state = state.copyWith(isLoading: true, errorMessage: null);
    state = state.copyWith(isLoading: false);
  }
}
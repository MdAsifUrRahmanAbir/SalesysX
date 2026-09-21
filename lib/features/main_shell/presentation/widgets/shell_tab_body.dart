import 'package:flutter/material.dart';
import 'package:salesysx/features/salesman_home/presentation/screens/salesman_home_screen.dart';

import '../../../new_sale_entry/presentation/screens/new_sale_entry_screen.dart';
import '../../../outlets_customers/presentation/screens/outlets_customers_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../../../target_performance/presentation/screens/target_performance_screen.dart';

/// Hosts all five bottom-nav destination screens in an [IndexedStack]
/// so switching tabs preserves each screen's scroll position and
/// state instead of rebuilding it from scratch every time.
class ShellTabBody extends StatelessWidget {
  final int selectedIndex;

  const ShellTabBody({super.key, required this.selectedIndex});

  static const _screens = [
    SalesmanHomeScreen(),
    NewSaleEntryScreen(),
    OutletsCustomersScreen(),
    TargetPerformanceScreen(),
    ProfileScreen(),
    // TermsPrivacyScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return IndexedStack(index: selectedIndex, children: _screens);
  }
}
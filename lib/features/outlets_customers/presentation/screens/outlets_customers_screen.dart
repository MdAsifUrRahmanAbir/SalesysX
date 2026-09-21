import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';
import 'outlets_customers_mobile_view.dart';
import 'outlets_customers_tab_view.dart';

class OutletsCustomersScreen extends StatelessWidget {
  const OutletsCustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Responsive(
        mobile: OutletsCustomersMobileView(),
        tablet: OutletsCustomersTabView(),
      ),
    );
  }
}

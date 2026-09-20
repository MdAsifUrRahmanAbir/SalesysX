import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';
import 'salesman_home_mobile_view.dart';
import 'salesman_home_tab_view.dart';

class SalesmanHomeScreen extends StatelessWidget {
  const SalesmanHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Responsive(
        mobile: SalesmanHomeMobileView(),
        tablet: SalesmanHomeTabView(),
      ),
    );
  }
}

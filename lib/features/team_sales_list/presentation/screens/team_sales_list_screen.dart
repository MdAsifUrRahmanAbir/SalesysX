import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';
import 'team_sales_list_mobile_view.dart';
import 'team_sales_list_tab_view.dart';

class TeamSalesListScreen extends StatelessWidget {
  const TeamSalesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Responsive(
        mobile: TeamSalesListMobileView(),
        tablet: TeamSalesListTabView(),
      ),
    );
  }
}

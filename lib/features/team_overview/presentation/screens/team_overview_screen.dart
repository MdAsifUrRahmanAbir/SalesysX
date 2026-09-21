import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';
import 'team_overview_mobile_view.dart';
import 'team_overview_tab_view.dart';

class TeamOverviewScreen extends StatelessWidget {
  const TeamOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Responsive(
        mobile: TeamOverviewMobileView(),
        tablet: TeamOverviewTabView(),
      ),
    );
  }
}

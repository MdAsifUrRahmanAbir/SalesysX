import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';
import 'team_reports_mobile_view.dart';
import 'team_reports_tab_view.dart';

class TeamReportsScreen extends StatelessWidget {
  const TeamReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Responsive(
        mobile: TeamReportsMobileView(),
        tablet: TeamReportsTabView(),
      ),
    );
  }
}

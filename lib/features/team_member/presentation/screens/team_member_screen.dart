import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';
import 'team_member_mobile_view.dart';
import 'team_member_tab_view.dart';

class TeamMemberScreen extends StatelessWidget {
  const TeamMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Responsive(
        mobile: TeamMemberMobileView(),
        tablet: TeamMemberTabView(),
      ),
    );
  }
}

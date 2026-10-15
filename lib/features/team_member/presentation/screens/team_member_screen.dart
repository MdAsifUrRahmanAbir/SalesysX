import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/responsive.dart';
import '../controllers/team_member_controller.dart';
import 'team_member_mobile_view.dart';
import 'team_member_tab_view.dart';

class TeamMemberScreen extends ConsumerStatefulWidget {
  const TeamMemberScreen({super.key, required this.email});

  final String email;

  @override
  ConsumerState<TeamMemberScreen> createState() => _TeamMemberScreenState();
}

class _TeamMemberScreenState extends ConsumerState<TeamMemberScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(teamMemberControllerProvider.notifier).load(widget.email));
  }

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

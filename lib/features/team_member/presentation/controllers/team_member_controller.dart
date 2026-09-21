import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/team_member_repository.dart';
import '../states/team_member_state.dart';

final teamMemberControllerProvider = NotifierProvider.autoDispose<
TeamMemberController, TeamMemberState>(
TeamMemberController.new,
);

class TeamMemberController extends Notifier<TeamMemberState> {
  TeamMemberRepository get _repository => ref.read(teamMemberRepositoryProvider);

  @override
  TeamMemberState build() {
    return const TeamMemberState();
  }

// TODO: wire getTeamMemberDetail(memberId) to _repository once
// features/team_member/data/repositories has a real staff-performance
// endpoint. Use add_api_feature.py to append the API method + loading flag.
}
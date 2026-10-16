import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/user_role.dart';
import '../../../../core/session/auth_session_controller.dart';
import '../../../common_models/user_model.dart';
import '../../data/repositories/help_support_repository.dart';

/// The person a field user should contact: their Team Head. Null for Team
/// Heads themselves and for salesmen without a team; they contact the
/// company admin.
class HelpSupportController extends AsyncNotifier<UserModel?> {
  @override
  Future<UserModel?> build() async {
    final user = ref.watch(authSessionControllerProvider).user;
    final teamId = user?.teamId;
    if (user == null || user.role != UserRole.salesman || teamId == null || teamId.isEmpty) return null;
    final head = await ref.read(helpSupportRepositoryProvider).getTeamHead(teamId);
    return head?.id == user.id ? null : head;
  }
}

final helpSupportControllerProvider =
    AsyncNotifierProvider.autoDispose<HelpSupportController, UserModel?>(HelpSupportController.new);

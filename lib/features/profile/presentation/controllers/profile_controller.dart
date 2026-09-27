import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/session/auth_session_controller.dart';
import '../states/profile_state.dart';

final profileControllerProvider =
NotifierProvider.autoDispose<ProfileController, ProfileState>(
  ProfileController.new,
);

class ProfileController extends Notifier<ProfileState> {
  @override
  ProfileState build() {
    // TODO: wire to profileRepositoryProvider.getProfile()
    // once features/profile/data is ready.
    // Values below mirror the approved design as placeholders.
    return const ProfileState(
      name: 'Rahim Uddin',
      avatarInitials: 'RU',
      employeeId: 'EMP-0042',
      team: 'Team Alpha',
      division: 'Dhaka Division',
      monthlyAchieved: 340000,
      monthlyTarget: 500000,
      monthlyAchievedShortLabel: '৳3.40L',
      monthlyTargetShortLabel: '৳5L',
      activeOutletCount: 24,
      salesTodayCompleted: 3,
    );
  }


  Future<bool> logout() async {
    await ref.read(authSessionControllerProvider.notifier).logout();
    return true;
  }
}
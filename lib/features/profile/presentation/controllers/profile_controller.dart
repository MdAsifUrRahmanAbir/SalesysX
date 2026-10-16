import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/user_role.dart';
import '../../../../core/session/auth_session_controller.dart';
import '../../../../core/utils/error_mapper.dart';
import '../../data/repositories/profile_repository.dart';
import '../states/profile_state.dart';

final profileControllerProvider =
NotifierProvider.autoDispose<ProfileController, ProfileState>(
  ProfileController.new,
);

class ProfileController extends Notifier<ProfileState> {
  ProfileRepository get _repository => ref.read(profileRepositoryProvider);

  @override
  ProfileState build() {
    Future.microtask(_load);
    return const ProfileState(isLoading: true);
  }

  Future<void> refresh() => _load();

  /// Same personal stats for every role — a Team Head has the full
  /// salesman feature set (including selling), so their Profile stats
  /// are their own numbers too, same as a Salesman's. Team-wide numbers
  /// live behind the Team Dashboard/Reports menu rows instead.
  Future<void> _load() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final user = ref.read(authSessionControllerProvider).user;
      if (user == null) {
        state = state.copyWith(isLoading: false, errorMessage: 'Not signed in.');
        return;
      }

      final teamName = user.teamId == null ? '' : (await _repository.getTeam(user.teamId!))?.name ?? '';

      final now = DateTime.now();
      final monthKey = '${now.year}-${now.month.toString().padLeft(2, '0')}';
      final monthStart = DateTime(now.year, now.month, 1);
      final todayStart = DateTime(now.year, now.month, now.day);

      final target = await _repository.getCurrentMonthTarget(user.id, monthKey);
      final sales = await _repository.getSalesForSalesman(user.id);
      final outlets = await _repository.getAssignedOutlets(user.id);

      final monthlyTarget = target?.targetAmount ?? 0;
      final monthlyAchieved = sales
          .where((s) => !s.date.isBefore(monthStart))
          .fold(0.0, (sum, s) => sum + s.amount);
      final salesTodayCompleted = sales.where((s) => !s.date.isBefore(todayStart)).length;

      state = ProfileState(
        isLoading: false,
        name: user.name,
        avatarInitials: _initialsOf(user.name),
        employeeId: user.employeeId,
        role: user.role,
        isTeamHead: user.role == UserRole.teamHead,
        team: teamName,
        division: '',
        monthlyAchieved: monthlyAchieved,
        monthlyTarget: monthlyTarget,
        monthlyAchievedShortLabel: _shortLabel(monthlyAchieved),
        monthlyTargetShortLabel: _shortLabel(monthlyTarget),
        activeOutletCount: outlets.length,
        salesTodayCompleted: salesTodayCompleted,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: getErrorMessage(e));
    }
  }

  Future<bool> logout() async {
    await ref.read(authSessionControllerProvider.notifier).logout();
    return true;
  }

  String _initialsOf(String name) {
    final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1)).toUpperCase();
  }

  String _shortLabel(double amount) {
    if (amount >= 100000) return '৳${(amount / 100000).toStringAsFixed(2)}L';
    if (amount >= 1000) return '৳${(amount / 1000).toStringAsFixed(1)}k';
    return '৳${amount.toStringAsFixed(0)}';
  }
}

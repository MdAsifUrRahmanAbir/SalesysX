import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/auth/auth_service.dart';

final changePasswordRepositoryProvider = Provider<ChangePasswordRepository>((ref) {
  return ChangePasswordRepository(ref.watch(authServiceProvider));
});

/// The password lives in Firebase Auth; [email] is kept for the caller's
/// convenience but the signed-in user is always the one changed.
class ChangePasswordRepository {
  final AuthService _auth;
  ChangePasswordRepository(this._auth);

  Future<void> changePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  }) {
    return _auth.changePassword(currentPassword: currentPassword, newPassword: newPassword);
  }
}

class ChangePasswordFailure implements Exception {
  final String message;
  const ChangePasswordFailure(this.message);

  @override
  String toString() => message;
}

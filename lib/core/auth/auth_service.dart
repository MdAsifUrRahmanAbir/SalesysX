import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../locale/l10n_provider.dart';
import '../utils/app_failure.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService(ref.watch(l10nProvider)));

/// Firebase Authentication for the Sales App. Accounts are created and
/// passwords reset from the Admin Panel; `users/{email}` holds the
/// profile, role and status.
class AuthService {
  final AppLocalizations _l10n;
  AuthService(this._l10n);

  FirebaseAuth get _auth => FirebaseAuth.instance;

  static String normalizeEmail(String email) => email.trim().toLowerCase();

  /// The signed-in email once Firebase has restored any persisted
  /// session, or null.
  Future<String?> restoredEmail() async {
    final user = _auth.currentUser ?? await _auth.authStateChanges().first;
    final email = user?.email;
    return email == null ? null : normalizeEmail(email);
  }

  Future<String> signIn(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(email: normalizeEmail(email), password: password);
      return normalizeEmail(result.user!.email!);
    } on FirebaseAuthException catch (e) {
      throw AppFailure(_messageFor(e));
    }
  }

  Future<void> signOut() => _auth.signOut();

  /// Re-verifies [currentPassword] first, as Firebase requires a recent
  /// sign-in for password changes.
  Future<void> changePassword({required String currentPassword, required String newPassword}) async {
    final user = _auth.currentUser;
    if (user == null || user.email == null) throw AppFailure(_l10n.sessionExpired);
    try {
      await user.reauthenticateWithCredential(EmailAuthProvider.credential(email: user.email!, password: currentPassword));
    } on FirebaseAuthException catch (e) {
      throw AppFailure(_isWrongPassword(e) ? _l10n.currentPasswordIncorrect : _messageFor(e));
    }
    try {
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      throw AppFailure(_messageFor(e));
    }
  }

  bool _isWrongPassword(FirebaseAuthException e) =>
      e.code == 'wrong-password' || e.code == 'invalid-credential' || e.code == 'INVALID_LOGIN_CREDENTIALS';

  String _messageFor(FirebaseAuthException e) {
    if (_isWrongPassword(e) || e.code == 'user-not-found' || e.code == 'invalid-email') return _l10n.invalidCredentials;
    return switch (e.code) {
      'user-disabled' => _l10n.accountDisabled,
      'too-many-requests' => _l10n.tooManyAttempts,
      'network-request-failed' => _l10n.networkError,
      'weak-password' => _l10n.passwordTooWeak,
      'requires-recent-login' => _l10n.sessionExpired,
      _ => _l10n.serverUnavailable,
    };
  }
}

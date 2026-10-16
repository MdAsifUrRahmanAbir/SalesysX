import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/common_models/user_model.dart';
import '../auth/auth_service.dart';
import '../company/company_settings.dart';
import '../constants/user_role.dart';
import '../push/push_notification_service.dart';
import '../constants/firestore_collections.dart';
import '../network/firebase_client.dart';
import '../storage/local_cache_service.dart';
import 'auth_session_state.dart';

class AuthSessionController extends Notifier<AuthSessionState> {
  AuthService get _auth => ref.read(authServiceProvider);
  FirebaseClient get _client => ref.read(firebaseClientProvider);

  @override
  AuthSessionState build() => const AuthSessionState();

  Future<void> restoreSession() async {
    final savedEmail = await _auth.restoredEmail();
    if (savedEmail == null) {
      state = state.copyWith(status: AuthStatus.unauthenticated);
      return;
    }
    await _loadProfile(savedEmail);
  }

  Future<void> onLoginSuccess(UserModel user) async {
    state = AuthSessionState(status: AuthStatus.authenticated, user: user);
    await _afterSignIn(user);
  }

  /// Re-reads the signed-in user's profile (after editing it).
  Future<void> reload() async {
    final email = state.user?.id;
    if (email != null) await _loadProfile(email);
  }

  /// Company rules (weekly holiday, price editing) and push registration.
  /// Neither may block the user from working, so failures are swallowed.
  Future<void> _afterSignIn(UserModel user) async {
    try {
      await ref.read(companySettingsProvider.notifier).load(user.companyId).timeout(const Duration(seconds: 8));
    } catch (_) {}
    // Not awaited: the permission prompt and token fetch must not hold
    // up the sign-in.
    unawaited(ref.read(pushNotificationServiceProvider).registerFor(user.id).catchError((_) => false));
  }

  Future<void> _loadProfile(String email) async {
    try {
      final data = await _client.getDocument(FirestoreCollections.userDoc(email));
      final user = data != null ? UserModel.fromMap(data, email) : null;

      // Panel accounts belong to the Web Admin Panel.
      if (user == null || !user.isActive || user.role.isPanelRole) {
        await _auth.signOut();
        state = const AuthSessionState(status: AuthStatus.unauthenticated);
        return;
      }
      state = AuthSessionState(status: AuthStatus.authenticated, user: user);
      await _afterSignIn(user);
    } catch (_) {
      state = const AuthSessionState(status: AuthStatus.unauthenticated);
    }
  }

  Future<void> logout() async {
    final email = state.user?.id;
    if (email != null) {
      try {
        await ref.read(pushNotificationServiceProvider).unregisterFrom(email);
      } catch (_) {}
    }
    await _auth.signOut();
    await ref.read(localCacheServiceProvider).clearOnLogout();
    state = const AuthSessionState(status: AuthStatus.unauthenticated);
  }
}

final authSessionControllerProvider =
NotifierProvider<AuthSessionController, AuthSessionState>(AuthSessionController.new);
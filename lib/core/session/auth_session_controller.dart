import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/login/data/models/user_model.dart';
import '../constants/firestore_collections.dart';
import '../network/firebase_client.dart';
import '../storage/local_cache_service.dart';
import '../storage/secure_storage_service.dart';
import 'auth_session_state.dart';

class AuthSessionController extends Notifier<AuthSessionState> {
  SecureStorageService get _secureStorage => ref.read(secureStorageServiceProvider);
  FirebaseClient get _client => ref.read(firebaseClientProvider);

  @override
  AuthSessionState build() => const AuthSessionState();

  Future<void> restoreSession() async {
    final savedEmail = await _secureStorage.readAccessToken();
    if (savedEmail == null || savedEmail.isEmpty) {
      state = state.copyWith(status: AuthStatus.unauthenticated);
      return;
    }
    await _loadProfile(savedEmail);
  }

  Future<void> onLoginSuccess(UserModel user) async {
    await _secureStorage.saveAccessToken(user.id);
    state = AuthSessionState(status: AuthStatus.authenticated, user: user);
  }

  Future<void> _loadProfile(String email) async {
    try {
      final data = await _client.getDocument(FirestoreCollections.userDoc(email));
      final user = data != null ? UserModel.fromMap(data, email) : null;

      if (user == null || !user.isActive) {
        await _secureStorage.clearAuthTokens();
        state = const AuthSessionState(status: AuthStatus.unauthenticated);
        return;
      }
      state = AuthSessionState(status: AuthStatus.authenticated, user: user);
    } catch (_) {
      state = const AuthSessionState(status: AuthStatus.unauthenticated);
    }
  }

  Future<void> logout() async {
    await _secureStorage.clearAuthTokens();
    await ref.read(localCacheServiceProvider).clearOnLogout();
    state = const AuthSessionState(status: AuthStatus.unauthenticated);
  }
}

final authSessionControllerProvider =
NotifierProvider<AuthSessionController, AuthSessionState>(AuthSessionController.new);
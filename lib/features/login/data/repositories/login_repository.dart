import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/firestore_collections.dart';
import '../../../../core/locale/l10n_provider.dart';
import '../../../../core/network/firebase_client.dart';
import '../../../../core/utils/password_hasher.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../common_models/user_model.dart';

final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  return LoginRepository(ref.watch(firebaseClientProvider), ref.watch(l10nProvider));
});

/// No Firebase Auth involved: accounts live in Firestore only, created
/// and role-assigned from the separate Web Admin Panel. This just looks
/// up `users/{email}` and checks the stored hash.
class LoginRepository {
  final FirebaseClient _client;
  final AppLocalizations _l10n;
  LoginRepository(this._client, this._l10n);

  Future<UserModel> signIn({required String email, required String password}) async {
    final normalizedEmail = email.trim().toLowerCase();
    final data = await _client.getDocument(FirestoreCollections.userDoc(normalizedEmail));

    if (data == null) {
      throw AuthFailure(_l10n.invalidCredentials);
    }

    final storedHash = data['passwordHash'] as String?;
    if (storedHash == null || storedHash != PasswordHasher.hash(password)) {
      throw AuthFailure(_l10n.invalidCredentials);
    }

    final user = UserModel.fromMap(data, normalizedEmail);
    if (!user.isActive) {
      throw AuthFailure(_l10n.accountDisabled);
    }
    return user;
  }
}

class AuthFailure implements Exception {
  final String message;
  const AuthFailure(this.message);

  @override
  String toString() => message;
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/auth/auth_service.dart';
import '../../../../core/constants/firestore_collections.dart';
import '../../../../core/locale/l10n_provider.dart';
import '../../../../core/network/firebase_client.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../common_models/user_model.dart';

final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  return LoginRepository(ref.watch(authServiceProvider), ref.watch(firebaseClientProvider), ref.watch(l10nProvider));
});

/// Signs in with Firebase Auth, then loads `users/{email}` for the role
/// and status. A sign-in without an active profile is signed out again.
class LoginRepository {
  final AuthService _auth;
  final FirebaseClient _client;
  final AppLocalizations _l10n;
  LoginRepository(this._auth, this._client, this._l10n);

  Future<UserModel> signIn({required String email, required String password}) async {
    final signedInEmail = await _auth.signIn(email, password);

    final data = await _client.getDocument(FirestoreCollections.userDoc(signedInEmail));
    if (data == null) {
      await _auth.signOut();
      throw AuthFailure(_l10n.invalidCredentials);
    }

    final user = UserModel.fromMap(data, signedInEmail);
    if (!user.isActive) {
      await _auth.signOut();
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

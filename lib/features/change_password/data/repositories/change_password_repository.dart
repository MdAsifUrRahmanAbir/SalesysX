import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/firestore_collections.dart';
import '../../../../core/locale/l10n_provider.dart';
import '../../../../core/network/firebase_client.dart';
import '../../../../core/utils/password_hasher.dart';
import '../../../../l10n/app_localizations.dart';

final changePasswordRepositoryProvider = Provider<ChangePasswordRepository>((
  ref,
) {
  return ChangePasswordRepository(ref.watch(firebaseClientProvider), ref.watch(l10nProvider));
});

class ChangePasswordRepository {
  final FirebaseClient _client;
  final AppLocalizations _l10n;
  ChangePasswordRepository(this._client, this._l10n);

  Future<void> changePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    final data = await _client.getDocument(FirestoreCollections.userDoc(email));
    final storedHash = data?['passwordHash'] as String?;
    if (storedHash == null || storedHash != PasswordHasher.hash(currentPassword)) {
      throw ChangePasswordFailure(_l10n.currentPasswordIncorrect);
    }

    await _client.updateDocument(FirestoreCollections.userDoc(email), {
      'passwordHash': PasswordHasher.hash(newPassword),
    });
  }
}

class ChangePasswordFailure implements Exception {
  final String message;
  const ChangePasswordFailure(this.message);

  @override
  String toString() => message;
}

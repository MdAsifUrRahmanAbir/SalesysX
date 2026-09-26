import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/firestore_collections.dart';
import '../../../../core/network/firebase_client.dart';
import '../../../../core/utils/password_hasher.dart';
import '../models/user_model.dart';

final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  return LoginRepository(ref.watch(firebaseClientProvider));
});

/// No Firebase Auth involved: accounts live in Firestore only, created
/// and role-assigned from the separate Web Admin Panel. This just looks
/// up `users/{email}` and checks the stored hash.
class LoginRepository {
  final FirebaseClient _client;
  LoginRepository(this._client);

  Future<UserModel> signIn({required String email, required String password}) async {
    final normalizedEmail = email.trim().toLowerCase();
    final data = await _client.getDocument(FirestoreCollections.userDoc(normalizedEmail));

    if (data == null) {
      throw const AuthFailure(AppStrings.invalidCredentials);
    }

    final storedHash = data['passwordHash'] as String?;
    if (storedHash == null || storedHash != PasswordHasher.hash(password)) {
      throw const AuthFailure(AppStrings.invalidCredentials);
    }

    final user = UserModel.fromMap(data, normalizedEmail);
    if (!user.isActive) {
      throw const AuthFailure(AppStrings.accountDisabled);
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
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/firestore_collections.dart';
import '../../../../core/network/firebase_client.dart';

final editProfileRepositoryProvider = Provider<EditProfileRepository>((ref) {
  return EditProfileRepository(ref.watch(firebaseClientProvider));
});

class EditProfileRepository {
  final FirebaseClient _client;

  EditProfileRepository(this._client);

  Future<void> updateProfile({
    required String email,
    required String name,
    required String phone,
  }) {
    return _client.updateDocument(FirestoreCollections.userDoc(email), {
      'name': name,
      'phone': phone,
    });
  }
}

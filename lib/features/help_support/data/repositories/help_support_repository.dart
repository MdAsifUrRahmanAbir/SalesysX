import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/firestore_collections.dart';
import '../../../../core/network/firebase_client.dart';
import '../../../common_models/team_model.dart';
import '../../../common_models/user_model.dart';

final helpSupportRepositoryProvider = Provider<HelpSupportRepository>((ref) {
  return HelpSupportRepository(ref.watch(firebaseClientProvider));
});

class HelpSupportRepository {
  final FirebaseClient _client;
  HelpSupportRepository(this._client);

  /// The Team Head of [teamId], the first person a salesman contacts for
  /// help. Password resets and account changes go through the admin.
  Future<UserModel?> getTeamHead(String teamId) async {
    final teamData = await _client.getDocument(FirestoreCollections.teamDoc(teamId));
    if (teamData == null) return null;
    final headEmail = TeamModel.fromMap(teamData).teamHeadEmail;
    if (headEmail.isEmpty) return null;
    final userData = await _client.getDocument(FirestoreCollections.userDoc(headEmail));
    return userData == null ? null : UserModel.fromMap(userData, headEmail);
  }
}

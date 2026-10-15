import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:salesysx/features/common_models/sale_model.dart';
import 'package:salesysx/features/common_models/target_model.dart';
import 'package:salesysx/features/common_models/team_model.dart';
import 'package:salesysx/features/common_models/user_model.dart';
import '../../../../core/constants/firestore_collections.dart';
import '../../../../core/constants/user_role.dart';
import '../../../../core/network/firebase_client.dart';

final teamReportsRepositoryProvider = Provider<TeamReportsRepository>((ref) {
  return TeamReportsRepository(ref.watch(firebaseClientProvider));
});

/// Same single-field-filter query shape as `team_overview_repository` —
/// kept as its own thin repository per the codebase's per-feature
/// convention.
class TeamReportsRepository {
  final FirebaseClient _client;
  TeamReportsRepository(this._client);

  Future<TeamModel?> getTeamForHead(String teamHeadEmail) async {
    final docs = await _client.getCollection(
      FirestoreCollections.teams,
      filters: [FirestoreFilter('teamHeadEmail', FirestoreOp.isEqualTo, teamHeadEmail)],
    );
    if (docs.isEmpty) return null;
    return TeamModel.fromMap(docs.first);
  }

  Future<List<UserModel>> getTeamMembers(String teamId) async {
    final docs = await _client.getCollection(
      FirestoreCollections.users,
      filters: [FirestoreFilter('teamId', FirestoreOp.isEqualTo, teamId)],
    );
    return docs
        .map((d) => UserModel.fromMap(d, d['id'] as String))
        .where((u) => u.role == UserRole.salesman)
        .toList();
  }

  Future<List<SaleModel>> getSalesForTeam(String teamId) async {
    final docs = await _client.getCollection(
      FirestoreCollections.sales,
      filters: [FirestoreFilter('teamId', FirestoreOp.isEqualTo, teamId)],
    );
    return docs.map(SaleModel.fromMap).toList();
  }

  Future<List<TargetModel>> getTargetsForTeam(String teamId) async {
    final docs = await _client.getCollection(
      FirestoreCollections.targets,
      filters: [FirestoreFilter('teamId', FirestoreOp.isEqualTo, teamId)],
    );
    return docs.map(TargetModel.fromMap).toList();
  }
}

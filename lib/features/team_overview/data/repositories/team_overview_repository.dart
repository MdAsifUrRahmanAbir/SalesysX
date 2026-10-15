import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:salesysx/features/common_models/sale_model.dart';
import 'package:salesysx/features/common_models/target_model.dart';
import 'package:salesysx/features/common_models/team_model.dart';
import 'package:salesysx/features/common_models/user_model.dart';
import '../../../../core/constants/firestore_collections.dart';
import '../../../../core/constants/user_role.dart';
import '../../../../core/network/firebase_client.dart';

final teamOverviewRepositoryProvider = Provider<TeamOverviewRepository>((ref) {
  return TeamOverviewRepository(ref.watch(firebaseClientProvider));
});

/// Shared single-field-filter data access for every Team Head screen
/// (Dashboard, Sales list, Reports) — each feature keeps its own thin
/// repository with these same queries, per the codebase's convention of
/// not sharing a repository layer across features.
class TeamOverviewRepository {
  final FirebaseClient _client;
  TeamOverviewRepository(this._client);

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

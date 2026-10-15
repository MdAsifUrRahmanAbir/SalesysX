import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:salesysx/features/common_models/outlet_model.dart';
import 'package:salesysx/features/common_models/sale_model.dart';
import 'package:salesysx/features/common_models/team_model.dart';
import 'package:salesysx/features/common_models/user_model.dart';
import '../../../../core/constants/firestore_collections.dart';
import '../../../../core/constants/user_role.dart';
import '../../../../core/network/firebase_client.dart';

final teamSalesListRepositoryProvider = Provider<TeamSalesListRepository>((ref) {
  return TeamSalesListRepository(ref.watch(firebaseClientProvider));
});

/// Single-field-filter data access for the Team Head's read-only Sales
/// tab — same query shape as `team_overview_repository`, kept as its
/// own thin repository per the codebase's per-feature convention.
class TeamSalesListRepository {
  final FirebaseClient _client;
  TeamSalesListRepository(this._client);

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

  Future<List<OutletModel>> getOutletsForTeam(String teamId) async {
    final docs = await _client.getCollection(
      FirestoreCollections.outlets,
      filters: [FirestoreFilter('teamId', FirestoreOp.isEqualTo, teamId)],
    );
    return docs.map(OutletModel.fromMap).toList();
  }

  Future<List<SaleModel>> getSalesForTeam(String teamId) async {
    final docs = await _client.getCollection(
      FirestoreCollections.sales,
      filters: [FirestoreFilter('teamId', FirestoreOp.isEqualTo, teamId)],
    );
    return docs.map(SaleModel.fromMap).toList();
  }
}

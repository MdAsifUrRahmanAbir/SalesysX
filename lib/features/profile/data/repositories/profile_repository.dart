import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:salesysx/features/common_models/outlet_model.dart';
import 'package:salesysx/features/common_models/sale_model.dart';
import 'package:salesysx/features/common_models/target_model.dart';
import 'package:salesysx/features/common_models/team_model.dart';
import '../../../../core/constants/firestore_collections.dart';
import '../../../../core/network/firebase_client.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(ref.watch(firebaseClientProvider));
});

class ProfileRepository {
  final FirebaseClient _client;
  ProfileRepository(this._client);

  Future<TeamModel?> getTeam(String teamId) async {
    final data = await _client.getDocument(FirestoreCollections.teamDoc(teamId));
    return data == null ? null : TeamModel.fromMap(data);
  }

  Future<TargetModel?> getCurrentMonthTarget(String salesmanEmail, String monthKey) async {
    final docs = await _client.getCollection(
      FirestoreCollections.targets,
      filters: [FirestoreFilter('salesmanEmail', FirestoreOp.isEqualTo, salesmanEmail)],
    );
    final targets = docs.map(TargetModel.fromMap).where((t) => t.month == monthKey);
    return targets.isEmpty ? null : targets.first;
  }

  Future<List<SaleModel>> getSalesForSalesman(String salesmanEmail) async {
    final docs = await _client.getCollection(
      FirestoreCollections.sales,
      filters: [FirestoreFilter('salesmanEmail', FirestoreOp.isEqualTo, salesmanEmail)],
    );
    return docs.map(SaleModel.fromMap).toList();
  }

  Future<List<OutletModel>> getAssignedOutlets(String salesmanEmail) async {
    final docs = await _client.getCollection(
      FirestoreCollections.outlets,
      filters: [FirestoreFilter('assignedSalesmanEmail', FirestoreOp.isEqualTo, salesmanEmail)],
    );
    return docs.map(OutletModel.fromMap).toList();
  }
}

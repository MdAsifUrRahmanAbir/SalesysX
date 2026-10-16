import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:salesysx/features/common_models/outlet_model.dart';
import 'package:salesysx/features/common_models/sale_model.dart';
import 'package:salesysx/features/common_models/target_model.dart';
import 'package:salesysx/features/common_models/user_model.dart';
import '../../../../core/constants/firestore_collections.dart';
import '../../../../core/network/firebase_client.dart';

final teamMemberRepositoryProvider = Provider<TeamMemberRepository>((ref) {
  return TeamMemberRepository(ref.watch(firebaseClientProvider));
});

class TeamMemberRepository {
  final FirebaseClient _client;
  TeamMemberRepository(this._client);

  Future<UserModel?> getMember(String email) async {
    final data = await _client.getDocument(FirestoreCollections.userDoc(email));
    return data == null ? null : UserModel.fromMap(data, email);
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
    return SaleModel.completedFrom(docs);
  }

  Future<List<OutletModel>> getAssignedOutlets(String salesmanEmail) async {
    final docs = await _client.getCollection(
      FirestoreCollections.outlets,
      filters: [FirestoreFilter('assignedSalesmanEmail', FirestoreOp.isEqualTo, salesmanEmail)],
    );
    return docs.map(OutletModel.fromMap).toList();
  }
}

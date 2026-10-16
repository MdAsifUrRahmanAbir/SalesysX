import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:salesysx/features/common_models/sale_model.dart';
import 'package:salesysx/features/common_models/target_model.dart';
import '../../../../core/constants/firestore_collections.dart';
import '../../../../core/network/firebase_client.dart';

final targetPerformanceRepositoryProvider = Provider<TargetPerformanceRepository>((ref) {
  return TargetPerformanceRepository(ref.watch(firebaseClientProvider));
});

class TargetPerformanceRepository {
  final FirebaseClient _client;
  TargetPerformanceRepository(this._client);

  /// Single-field filter only — month is matched client-side, same
  /// pattern as `salesman_home_repository`.
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
}

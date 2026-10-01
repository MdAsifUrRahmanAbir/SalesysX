import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/firestore_collections.dart';
import '../../../../core/network/firebase_client.dart';
import 'package:salesysx/features/lib/features/common_models/sale_model.dart';
import 'package:salesysx/features/lib/features/common_models/target_model.dart';

final salesmanHomeRepositoryProvider = Provider<SalesmanHomeRepository>((ref) {
  return SalesmanHomeRepository(ref.watch(firebaseClientProvider));
});

class SalesmanHomeRepository {
  final FirebaseClient _client;
  SalesmanHomeRepository(this._client);

  /// Single-field filter only (no composite index needed) — month is
  /// matched client-side since a salesman has at most a handful of
  /// target docs.
  Future<TargetModel?> getCurrentMonthTarget(String salesmanEmail, String monthKey) async {
    final docs = await _client.getCollection(
      FirestoreCollections.targets,
      filters: [FirestoreFilter('salesmanEmail', FirestoreOp.isEqualTo, salesmanEmail)],
    );
    final targets = docs.map(TargetModel.fromMap).where((t) => t.month == monthKey);
    return targets.isEmpty ? null : targets.first;
  }

  /// All of this salesman's sales — date-range filtering (today/this
  /// month/yesterday) happens client-side in the controller.
  Future<List<SaleModel>> getSalesForSalesman(String salesmanEmail) async {
    final docs = await _client.getCollection(
      FirestoreCollections.sales,
      filters: [FirestoreFilter('salesmanEmail', FirestoreOp.isEqualTo, salesmanEmail)],
    );
    return docs.map(SaleModel.fromMap).toList();
  }
}